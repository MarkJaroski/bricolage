package Bric::Biz::Workflow;
###############################################################################

=head1 NAME

Bric::Biz::Workflow - Controls the progress of an asset through a series of desks.

=head1 VERSION

$Revision: 1.23.2.1 $

=cut

our $VERSION = (qw$Revision: 1.23.2.1 $ )[-1];

=head1 DATE

$Date: 2003-03-15 06:33:35 $

=head1 SYNOPSIS

  my $flow = new Bric::Biz::Workflow($param);

  $id    = $flow->get_id;

  $name  = $flow->get_name;
  $flow  = $flow->set_name($name);

  $desc  = $flow->get_description;
  $flow  = $flow->set_description($desc);

  $flow  = $flow->add_desk($param);

  # Returns a list of allowed desks.
  @desks = $flow->allowed_desks();

  # Lists the required desks
  @desks = $flow->required_desks();

  # Returns true if the asset object has been through all required desks.
  $bool  = $flow->required_satisfied($asset_obj);

=head1 DESCRIPTION

A workflow is something that guides an asset through a set of desks, where an
asset is any kind of creative content (a story, an image, a sound file, etc)
and a desk performs and kind of validation or transformation upon an asset
needed before it can be published. Example desks might be a 'legal' desk where
users can verify any legal issue for a particular asset, or an 'edit' desk
where users can check consistancy and presentation for an asset.

A workflow might be as simple as a linear path through a set of desks or as
complex as requiring certain desks be visited with other desks optional and a
route through the desks that can be arbitrarily complex.

=cut

#==============================================================================#
# Dependencies                         #
#======================================#

#--------------------------------------#
# Standard Dependencies
use strict;

#--------------------------------------#
# Programatic Dependencies
use Bric::Util::DBI qw(:all);
use Bric::Util::Grp::Desk;
use Bric::Util::Grp::Workflow;
use Bric::Util::Fault::Exception::DP;
use Bric::Util::Fault::Exception::AP;
use Bric::Biz::Workflow::Parts::Desk;

#==============================================================================#
# Inheritance                          #
#======================================#

use base qw( Bric Exporter );

our @EXPORT_OK = qw(TEMPLATE_WORKFLOW
                    STORY_WORKFLOW
                    MEDIA_WORKFLOW
                    WORKFLOW_TYPE_MAP
                   );

our %EXPORT_TAGS = (wf_const => [qw(TEMPLATE_WORKFLOW
                                    STORY_WORKFLOW
                                    MEDIA_WORKFLOW
                                    WORKFLOW_TYPE_MAP)],
                   );

#=============================================================================#
# Function Prototypes                  #
#======================================#
my $get_em;

#==============================================================================#
# Constants                            #
#======================================#

use constant DEBUG => 1;
use constant DESK_PKG => 'Bric::Biz::Workflow::Parts::Desk';
use constant GROUP_PACKAGE => 'Bric::Util::Grp::Workflow';
use constant INSTANCE_GROUP_ID => 25;
use constant TEMPLATE_WORKFLOW => 1;
use constant STORY_WORKFLOW    => 2;
use constant MEDIA_WORKFLOW    => 3;
use constant WORKFLOW_TYPE_MAP => { &STORY_WORKFLOW => 'Story',
                                    &MEDIA_WORKFLOW => 'Media',
                                    &TEMPLATE_WORKFLOW => 'Template' };


#==============================================================================#
# Fields                               #
#======================================#

#--------------------------------------#
# Public Class Fields
# None.

#--------------------------------------#
# Private Class Fields
my $meths;
my $table = 'workflow';
my @cols = qw(name description all_desk_grp_id head_desk_id req_desk_grp_id
              type active);
my @props = qw(name description all_desk_grp_id head_desk_id req_desk_grp_id
               type _active);

my $sel_cols = 'a.id, a.name, a.description, a.all_desk_grp_id, ' .
  'a.head_desk_id, a.req_desk_grp_id, a.type, a.active, m.grp__id';
my @sel_props = ('id', @props, 'grp_ids');

my @ord = qw(name description type active);


#--------------------------------------#
# Instance Fields
BEGIN {
    Bric::register_fields({
                         # Public Fields
                         'id'                   => Bric::FIELD_READ,
                         'name'                 => Bric::FIELD_RDWR,
                         'description'          => Bric::FIELD_RDWR,
                         'all_desk_grp_id'      => Bric::FIELD_READ,
                         'req_desk_grp_id'      => Bric::FIELD_READ,
                         'head_desk_id'         => Bric::FIELD_READ,
                         'type'                 => Bric::FIELD_RDWR,
                         'grp_ids'              => Bric::FIELD_READ,

                         # Private Fields
                         '_all_desk_grp_obj'    => Bric::FIELD_NONE,
                         '_req_desk_grp_obj'    => Bric::FIELD_NONE,
                         '_head_desk_obj'       => Bric::FIELD_NONE,
                         '_active'              => Bric::FIELD_NONE,
                         '_remove'              => Bric::FIELD_NONE,
                        });
}

#==============================================================================#

=head1 INTERFACE

=head2 Constructors

=over 4

=item $success = $obj = new Bric::Biz::Workflow($param);

Keys for $param are:

=over 4

=item *

name

The name for this workflow

=item *

description

A description for this workflow

=item *

start_desk

The starting desk for this workflow

=back

B<Throws:>

NONE

B<Side Effects:>

NONE

B<Notes:>

NONE

=cut

sub new {
    my ($self, $init) = @_;

    my $sd = delete $init->{start_desk};
    $init->{_active} = 1;

    # Call the parent's constructor.
    $self = $self->SUPER::new($init);

    # Add the start desk if passed.
    $self->set_start_desk($sd) if $sd;

    # Since this is a new object, set the dirty bit so it will be saved.
    $self->_set__dirty(1);

    # Return the object.
    return $self;
}

#------------------------------------------------------------------------------#

=item my $wf = Bric::Biz::Workflow->lookup({ id => $id });

=item my $wf = Bric::Biz::Workflow->lookup({ name => $name });

Looks up and instantiates a new Bric::Biz::Workflow object based on an
Bric::Biz::Workflow object ID or name. If no output channelobject is
found in the database, C<lookup()> returns C<undef>.

B<Throws:>

=over 4

=item *

Unable to prepare SQL statement.

=item *

Unable to connect to database.

=item *

Unable to select column into arrayref.

=item *

Unable to execute SQL statement.

=item *

Unable to bind to columns to statement handle.

=item *

Unable to fetch row from statement handle.

=back

B<Side Effects:> NONE.

B<Notes:> NONE.

=cut

sub lookup {
    my $pkg = shift;
    my $wf = $pkg->cache_lookup(@_);
    return $wf if $wf;

    $wf = $get_em->($pkg, @_);
    # We want @$wf to have only one value.
    die Bric::Util::Fault::Exception::DP->new
      ({ msg => 'Too many ' . __PACKAGE__ . ' objects found.' })
      if @$wf > 1;
    return @$wf ? $wf->[0] : undef;
}

#------------------------------------------------------------------------------#

=item (@all || $all) = Bric::Biz::Workflow->list($params);

Return a list of all known workflow types. Keys of the $params hash reference
are:

=over 4

=item C<name>

Return all workflows matching a certain name.

=item C<description>

Return all workflows with a matching description.

=item C<active>

Boolean; Return all in/active workflows.

=item C<type>

Return all workflows of a particular type. The types are integers accessible
via the C<STORY_WORKFLOW>, C<MEDIA_WORKFLOW>, and C<TEMPLATE_WORKFLOW>
constants.

=item <desk_id>

Return all worfkflows containing a desk with this desk ID.

=item C<grp_id>

Return all workflows in the group corresponding to this group ID.

=back

B<Throws:>

=over 4

=item *

Unable to prepare SQL statement.

=item *

Unable to connect to database.

=item *

Unable to select column into arrayref.

=item *

Unable to execute SQL statement.

=item *

Unable to bind to columns to statement handle.

=item *

Unable to fetch row from statement handle.

=back

B<Side Effects:> NONE.

B<Notes:> Seaches against C<name> and C<description> use the LIKE operator, so
'%' can be used for substring searching.

=cut

sub list { wantarray ? @{ &$get_em(@_) } : &$get_em(@_) }

#------------------------------------------------------------------------------#

=item (@ids || $ids) = Bric::Biz::Workflow->list_ids($params);

Return a list of workflow IDs. See C<list()> for a list of the relevant keys
in the C<$params> hash reference.

B<Throws:>

=over 4

=item *

Unable to prepare SQL statement.

=item *

Unable to connect to database.

=item *

Unable to select column into arrayref.

=item *

Unable to execute SQL statement.

=item *

Unable to bind to columns to statement handle.

=item *

Unable to fetch row from statement handle.

=back

B<Side Effects:> NONE.

B<Notes:> Seaches against C<name> and C<description> use the LIKE operator, so
'%' can be used for substring searching.

=cut

sub list_ids { wantarray ? @{ &$get_em(@_, 1) } : &$get_em(@_, 1) }

#--------------------------------------#

=back

=head2 Destructors

=over 4

=item $self->DESTROY

Dummy method to prevent wasting time trying to AUTOLOAD DESTROY.

=cut

sub DESTROY {
    # This method should be here even if its empty so that we don't waste time
    # making Bricolage's autoload method try to find it.
}

#--------------------------------------#

=back

=head2 Public Class Methods

=over 4

=item my $meths = Bric::Biz::Workflow->my_meths

=item my (@meths || $meths_aref) = Bric::Biz::Workflow->my_meths(TRUE)

=item my (@meths || $meths_aref) = Bric::Biz::Workflow->my_meths(0, TRUE)

Returns an anonymous hash of introspection data for this object. If called
with a true argument, it will return an ordered list or anonymous array of
introspection data. If a second true argument is passed instead of a first,
then a list or anonymous array of introspection data will be returned for
properties that uniquely identify an object (excluding C<id>, which is
assumed).

Each hash key is the name of a property or attribute of the object. The value
for a hash key is another anonymous hash containing the following keys:

=over 4

=item name

The name of the property or attribute. Is the same as the hash key when an
anonymous hash is returned.

=item disp

The display name of the property or attribute.

=item get_meth

A reference to the method that will retrieve the value of the property or
attribute.

=item get_args

An anonymous array of arguments to pass to a call to get_meth in order to
retrieve the value of the property or attribute.

=item set_meth

A reference to the method that will set the value of the property or
attribute.

=item set_args

An anonymous array of arguments to pass to a call to set_meth in order to set
the value of the property or attribute.

=item type

The type of value the property or attribute contains. There are only three
types:

=over 4

=item short

=item date

=item blob

=back

=item len

If the value is a 'short' value, this hash key contains the length of the
field.

=item search

The property is searchable via the list() and list_ids() methods.

=item req

The property or attribute is required.

=item props

An anonymous hash of properties used to display the property or
attribute. Possible keys include:

=over 4

=item type

The display field type. Possible values are

=over 4

=item text

=item textarea

=item password

=item hidden

=item radio

=item checkbox

=item select

=back

=item length

The Length, in letters, to display a text or password field.

=item maxlength

The maximum length of the property or value - usually defined by the SQL DDL.

=back

=item rows

The number of rows to format in a textarea field.

=item cols

The number of columns to format in a textarea field.

=item vals

An anonymous hash of key/value pairs reprsenting the values and display names
to use in a select list.

=back

B<Throws:> NONE.

B<Side Effects:> NONE.

B<Notes:> NONE.

=cut

sub my_meths {
    my ($pkg, $ord, $ident) = @_;

    # Create 'em if we haven't got 'em.
    $meths ||= {
              name        => {
                              name     => 'name',
                              get_meth => sub { shift->get_name(@_) },
                              get_args => [],
                              set_meth => sub { shift->set_name(@_) },
                              set_args => [],
                              disp     => 'Name',
                              type     => 'short',
                              len      => 64,
                              req      => 1,
                              search   => 1,
                              props    => { type       => 'text',
                                            length     => 32,
                                            maxlength => 64
                                          }
                             },
              description => {
                              get_meth => sub { shift->get_description(@_) },
                              get_args => [],
                              set_meth => sub { shift->set_description(@_) },
                              set_args => [],
                              name     => 'description',
                              disp     => 'Description',
                              len      => 256,
                              req      => 0,
                              type     => 'short',
                              props    => { type => 'textarea',
                                            cols => 40,
                                            rows => 4
                                          }
                             },
              type        => {
                              get_meth => sub { shift->get_type(@_) },
                              get_args => [],
                              set_meth => sub { shift->set_type(@_) },
                              set_args => [],
                              name     => 'type',
                              disp     => 'Type',
                              len      => 1,
                              req      => 1,
                              type     => 'short',
                              props    => { type => 'select',
                                            vals => [ [STORY_WORKFLOW,    'Story'],
                                                      [MEDIA_WORKFLOW,    'Media'],
                                                      [TEMPLATE_WORKFLOW, 'Template'] ],
                                          }
                             },
              active      => {
                              name     => 'active',
                              get_meth => sub { shift->is_active(@_) ? 1 : 0 },
                              get_args => [],
                              set_meth => sub { $_[1] ? shift->activate(@_)
                                                  : shift->deactivate(@_) },
                              set_args => [],
                              disp     => 'Active',
                              len      => 1,
                              req      => 1,
                              type     => 'short',
                              props    => { type => 'checkbox' }
                             }
             };

    if ($ord) {
        return wantarray ? @{$meths}{@ord} : [@{$meths}{@ord}];
    } elsif ($ident) {
        return wantarray ? $meths->{name} : [$meths->{name}];
    } else {
        return $meths;
    }
}

#--------------------------------------#

=back

=head2 Public Instance Methods

=over 4

=item $flow->add_desk($param);

Add a desk to this workflow.  Keys to param are:

=over 4

=item *

allowed

Add a list of desks as part of the allowed desks.

=item *

required

Add a list of desks as required desks.

=back

B<Throws:>

NONE

B<Side Effects:>

NONE

B<Notes:>

NONE

=cut

sub add_desk {
    my $self = shift;
    my ($param) = @_;
    my $all_grp = $self->_get_all_desk_grp;
    my $req_grp = $self->_get_req_desk_grp;
    my (@all, @req);

    push @all, @{$param->{'allowed'}} if $param->{'allowed'};

    if ($param->{'required'}) {
        push @all, @{$param->{'required'}};
        push @req, @{$param->{'required'}};
    }

    # Add all the desks to the desk group.
    $all_grp->add_members([map {ref $_ ? {'obj'=>$_} 
                                       : {'id'=>$_,'package'=>DESK_PKG}} @all]);
    $req_grp->add_members([map {ref $_ ? {'obj'=>$_} 
                                       : {'id'=>$_,'package'=>DESK_PKG}} @req]);

    return $self;
}

#------------------------------------------------------------------------------#

=item $flow->del_desk([$desk || $desk_id]);

Delete a desk from this workflow.

B<Throws:>

NONE

B<Side Effects:>

NONE

B<Notes:>

NONE

=cut

sub del_desk {
    my $self = shift;
    my ($desks) = @_;
    my $all_grp = $self->_get_all_desk_grp;
    my $req_grp = $self->_get_req_desk_grp;
    my $vals;

    foreach my $d (@$desks) {
        my $id;
        if (ref $d) {
            $id = $d->get_id;
            push @$vals, { obj => $d };
        } else {
            $id = $d;
            push @$vals, { package => DESK_PKG, id => $d };
        }

        # Clear out the head desk stuff if they delete the head desk.
        if ($self->get_head_desk_id == $id) {
            $self->_set(['head_desk_id', '_head_desk_obj'], [undef, undef]);
        }
    }

    # Delete the desks from the desk groups.
    $all_grp->delete_members($vals);
    $req_grp->delete_members($vals);

    return $self;
}

#------------------------------------------------------------------------------#

=item $flow->allowed_desks();

Returns a list of allowed desks.

B<Throws:>

NONE

B<Side Effects:>

NONE

B<Notes:>

NONE

=cut

sub allowed_desks {
    my $self = shift;
    my $all_grp = $self->_get_all_desk_grp;

    return unless $all_grp;

    # Sort desks so that the start desk is first, normal desks come next and
    # the publish desk is last.
    my @mem = sort {($self->is_start_desk($b)||0) <=> ($self->is_start_desk($a)||0) ||
                      ($a->can_publish || 0) <=> ($b->can_publish || 0) ||
                        $a->get_id <=> $b->get_id} $all_grp->get_objects;

    # Drop any inactive desks from the list.
    @mem = grep($_->is_active, @mem);

    return wantarray ? @mem : \@mem;
}

#------------------------------------------------------------------------------#

=item $bool = $flow->desk_in_allowed($desk_obj);

Returns true if desk is in the list of allowed desks.

B<Throws:>

NONE

B<Side Effects:>

NONE

B<Notes:>

NONE

=cut

sub desk_in_allowed {
    my $self = shift;
    my ($desk_obj) = @_;
    my $all_grp = $self->_get_all_desk_grp;
    return unless $all_grp;
    return $all_grp->has_member({ obj => $desk_obj });
}

#------------------------------------------------------------------------------#

=item @desks = $flow->required_desks();

Lists the required desks

B<Throws:>

NONE

B<Side Effects:>

NONE

B<Notes:>

NONE

=cut

sub required_desks {
    my $self = shift;
    my $req_grp = $self->_get_req_desk_grp;

    return unless $req_grp;

    my @mem = sort { $a->get_id <=> $b->get_id } $req_grp->get_members;

    # Drop any inactive desks from the list.
    @mem = grep($_->is_active, @mem);

    return wantarray ? @mem : \@mem;
}

#------------------------------------------------------------------------------#

=item $bool = $flow->desk_in_required($desk_obj);

Returns true if the deskref given is in the required list

B<Throws:>

NONE

B<Side Effects:>

NONE

B<Notes:>

NONE

=cut

sub desk_in_required {
    my $self = shift;
    my ($desk_obj) = @_;
    my $req_grp = $self->_get_req_desk_grp;
    return unless $req_grp;
    return $req_grp->has_member({ obj => $desk_obj });
}

#------------------------------------------------------------------------------#

=item $bool = $flow->required_satisfied($asset_obj);

Returns true if a assetref has been through all required desks.

B<Throws:>

NONE

B<Side Effects:>

NONE

B<Notes:>

=cut

sub required_satisfied {
    my $self = shift;
    my ($asset_obj) = @_;
    my @stamps      = $asset_obj->get_desk_stamps;
    my @req         = $self->required_desks;

    # Load the stamps into a hash so they can be searched more quickly.
    my %stamp_search = map { $_->get_id => 1 } @stamps;

    # Look for each required desk.
    foreach my $d (@req) {
        return unless $stamp_search{$d->get_id};
    }

    return $self;
}

#------------------------------------------------------------------------------#

=item $desk = $flow->get_start_desk();

=item ($flow || undef) = $flow->set_start_desk($desk_id);

=item $self = $flow->is_start_desk();

Get/Set the start desk.

B<Throws:>

NONE

B<Side Effects:>

NONE

B<Notes:>

=cut

sub get_start_desk {
    my $self = shift;
    my ($id, $head) = $self->_get('head_desk_id', '_head_desk_obj');

    return $head if $head;
    return unless $id;

    $head = Bric::Biz::Workflow::Parts::Desk->lookup({'id' => $id});

    return unless $head;

    $self->_set(['_head_desk_obj'], [$head]);

    return $head;
}

sub set_start_desk {
    my $self = shift;
    my ($val) = @_;

    # Grab an ID if they pass a desk object.
    my ($id, $desk) = ref $val ? ($val->get_id, $val) : ($val);

    # Add desk to the required list.  Should do nothing if its already there.
    $self->add_desk({ required => [$id] });

    $self->_set([qw(head_desk_id _head_desk_obj)], [$id, $desk])
}

sub is_start_desk {
    my $self = shift;
    my ($d) = @_;
    my ($id, $head) = $self->_get('head_desk_id', '_head_desk_obj');

    # Return if they didn't pass a desk;
    return unless $d;
    # Return our self object if it matches the start desk ID.
    return $self if $d->get_id eq $id;
    # Return undef if its not the start desk;  separate to prevent array context
    return;
}

#------------------------------------------------------------------------------#

=item $desk || undef = $desk->is_active;

=item $desk = $desk->activate;

=item $desk = $desk->deactivate;

Get/Set the active flag.

B<Throws:>

NONE

B<Side Effects:>

NONE

B<Notes:>

NONE

=cut

sub is_active {
    my $self = shift;

    return $self->_get('_active') ? $self : undef;
}

sub activate {
    my $self = shift;

    $self->_set__dirty(1);

    $self->_set(['_active'], [1]) and return $self;
}

sub deactivate {
    my $self = shift;

    $self->_set__dirty(1);

    $self->_set(['_active'], [0]) and return $self;
}

#------------------------------------------------------------------------------#

=item $desk->remove;

Get/Set the active flag.

B<Throws:>

NONE

B<Side Effects:>

NONE

B<Notes:>

NONE

=cut

sub remove {
    my $self = shift;

    $self->_set__dirty;

    $self->_set(['_remove'], [1]);
}

#------------------------------------------------------------------------------#

=item $save = $workflow->save;

Save this workflow

B<Throws:>

NONE

B<Side Effects:>

NONE

B<Notes:>

NONE

=cut

sub save {
    my $self = shift;
    my $all_grp = $self->_get_all_desk_grp;
    my $req_grp = $self->_get_req_desk_grp;
    my $id = $self->get_id;

    # Make sure they don't try to save with out setting a start desk.
    unless ($self->get_start_desk) {
        my $err_msg = 'No start desk: A start desk must be defined using '.
                      "'set_start_desk' before 'save' is called";
        die Bric::Util::Fault::Exception::AP->new({'msg' => $err_msg});
    }

    unless ($self->_get('_remove')) {
        $all_grp->save if $all_grp;
        $req_grp->save if $req_grp;

        # Set the ID if the objects were saved.
        $self->_set(['all_desk_grp_id'], [$all_grp->get_id]) if $all_grp;
        $self->_set(['req_desk_grp_id'], [$req_grp->get_id]) if $req_grp;

        # Only update if anything has changed.
        return unless $self->_get__dirty;

        if ($id) {
            $self->_update_workflow;
        } else {
            $self->_insert_workflow;
        }

        $self->SUPER::save();
    } else {
        $all_grp->deactivate and $all_grp->save if $all_grp;
        $req_grp->deactivate and $req_grp->save if $req_grp;

        $self->_remove_workflow;
    }

    return $self;
}

#==============================================================================#

=back

=head1 Private Methods

NONE.

=head2 Private Class Methods

NONE.

=head2 Private Instance Methods

=over 4

=cut

# We need to documente these!

sub _get_all_desk_grp {
    my $self = shift;
    my ($id, $grp) = $self->_get('all_desk_grp_id', '_all_desk_grp_obj');

    # Return the group if we have it
    return $grp if $grp;

    if ($id) {
        $grp = Bric::Util::Grp::Desk->lookup({'id' => $id});
    } else {
        my $desc = 'All desks available to a workflow';
        $grp = Bric::Util::Grp::Desk->new({'name'        => 'All Workflow Desks',
                                         'description' => $desc});
    }

    $self->_set(['_all_desk_grp_obj'], [$grp]);

    return $grp;
}

sub _get_req_desk_grp {
    my $self = shift;
    my ($id, $grp) = $self->_get('req_desk_grp_id', '_req_desk_grp_obj');

   # Return the group if we have it
    return $grp if $grp;

    if ($id) {
        $grp = Bric::Util::Grp::Desk->lookup({'id' => $id});
    } else {
        my $desc = 'Desks required in a workflow';
        $grp = Bric::Util::Grp::Desk->new({'name'        => 'Required Workflow Desks',
                                         'description' => $desc});
    }

    $self->_set(['_req_desk_grp_obj'], [$grp]);

    return $grp;
}

sub _insert_workflow {
    my $self = shift;
    my $nextval = next_key($table);

    # Create the insert statement.
    my $ins = prepare_c(qq{
        INSERT INTO $table (id, ${\join(', ', @cols)})
        VALUES ($nextval, ${\join(', ', ('?') x @cols)})
    });

    execute($ins, $self->_get(@props));

    # Set the ID of this object.
    $self->_set(['id'],[last_key($table)]);

    # And finally, register this workflow in the "All Workflows" group.
    $self->register_instance(INSTANCE_GROUP_ID, GROUP_PACKAGE);

    return $self;
}

sub _update_workflow {
    my $self = shift;
    my $sql = "UPDATE $table SET " .
      join(',', map { "$_ = ?" } @cols) . " WHERE id = ?";
    my $sth = prepare_c($sql);
    execute($sth, $self->_get(@props), $self->get_id);
    return 1;
}

#------------------------------------------------------------------------------#

=item $desk = $desk->_remove_workflow

Remove this workflow

B<Throws:>

NONE

B<Side Effects:>

NONE

B<Notes:>

NONE

=cut

sub _remove_workflow {
    my $self = shift;
    my $sth = prepare_c("DELETE FROM $table WHERE id = ?");
    execute($sth, $self->get_id);

    return $self;
}

=back

=head2 Private Functions

=over 4

=item my $wf_aref = &$get_em( $pkg, $search_href )

=item my $wf_ids_aref = &$get_em( $pkg, $search_href, 1 )

Function used by C<lookup()> and C<list()> to return a list of
Bric::Biz::Workflow objects or, if called with an optional third argument,
returns a list of Bric::Biz::Workflow object IDs (used by C<list_ids()>).

B<Throws:>

=over 4

=item *

Unable to prepare SQL statement.

=item *

Unable to connect to database.

=item *

Unable to select column into arrayref.

=item *

Unable to execute SQL statement.

=item *

Unable to bind to columns to statement handle.

=item *

Unable to fetch row from statement handle.

=back

B<Side Effects:> NONE.

B<Notes:> NONE.

=cut

$get_em = sub {
    my ($pkg, $params, $ids) = @_;

    # Make sure to set active explictly if its not passed.
    $params->{active} = exists $params->{active} ?
      $params->{active} ? 1 : 0 : 1 unless $params->{id};

    my $tables = "$table a, member m, workflow_member c";
    my $wheres = 'a.id = c.object_id AND c.member__id = m.id AND ' .
      'm.active = 1';
    my @params;
    while (my ($k, $v) = each %$params) {
        if ($k eq 'name' or $k eq 'description') {
            $wheres .= " AND LOWER(a.$k) LIKE ?";
            push @params, lc $v;
        } elsif ($k eq 'grp_id') {
            $tables .= ", member m2, workflow_member c2";
            $wheres .= " AND a.id = c2.object_id AND c2.member__id = m2.id" .
              " AND m2.active = 1 AND m2.grp__id = ?";
            push @params, $v;
        } elsif ($k eq 'desk_id') {
            # Yes, this is a hack. It requires too much knowledge of the Group
            # schema. This will go away once Workflow has this group stuff
            # refactored out of it.
            $tables .= ", member m3, desk_member c3";
            $wheres .= ' AND a.all_desk_grp_id = m3.grp__id AND ' .
              'm3.id = c3.member__id AND m3.active = 1 AND ' .
              'c3.object_id = ?';
            push @params, $v;
        } else {
            $wheres .= " AND a.$k = ?";
            push @params, $v;
        }
    }

    my ($qry_cols, $order) = $ids ? (\'DISTINCT a.id', 'a.id') :
      (\$sel_cols, 'a.name, a.id');

    my $sel = prepare_c(qq{
        SELECT $$qry_cols
        FROM   $tables
        WHERE  $wheres
        ORDER BY $order
    }, undef, DEBUG);

    # Just return the IDs, if they're what's wanted.
    return col_aref($sel, @params) if $ids;

    execute($sel, @params);
    my (@d, @wfs, $grp_ids);
    bind_columns($sel, \@d[0..$#sel_props]);
    my $last = -1;
    $pkg = ref $pkg || $pkg;
    while (fetch($sel)) {
        if ($d[0] != $last) {
            $last = $d[0];
            # Create a new workflow object.
            my $self = bless {}, $pkg;
            $self->SUPER::new;
            # Get a reference to the array of group IDs.
            $grp_ids = $d[$#d] = [$d[$#d]];
            $self->_set(\@sel_props, \@d);
            $self->_set__dirty; # Disables dirty flag.
            push @wfs, $self->cache_me;
        } else {
            push @$grp_ids, $d[$#d];
        }
    }
    return \@wfs;
};

1;
__END__

=back

=head1 NOTES

NONE

=head1 AUTHOR

Garth Webb <garth@perijove.com>

=head1 SEE ALSO

L<Bric>, L<Bric::Biz::Workflow::Parts::Desk>, L<perl>

=cut
