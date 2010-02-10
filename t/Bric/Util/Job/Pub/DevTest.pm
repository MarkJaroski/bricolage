package Bric::Util::Job::Pub::DevTest;
use strict;
use warnings;
use base qw(Bric::Test::DevBase);
use Test::More;
use Test::Exception;
use Bric::Util::Job::Pub;
use Bric::Util::Job::Dist;
use Bric::Util::Grp::Job;
use Bric::Util::Class;
use Bric::Util::Time qw(:all);
use Bric::Dist::Server;
use Bric::Dist::ServerType;
use Bric::Dist::Resource;
use Bric::Config qw(:time DBI_DEBUG TEMP_DIR QUEUE_PUBLISH_JOBS);
use Bric::Util::Trans::FS;
use Bric::Util::MediaType;
use Bric::Biz::ElementType;
use Bric::Biz::Asset::Business::Story;
use Bric::Biz::Asset::Business::Media;
use Bric::Biz::Asset::Business::Media::Image;
use Bric::Util::Burner;
use Bric::Biz::Person::User;
use Bric::Biz::Asset::Template;
use Bric::Util::DBI qw(:all);
use Test::MockModule;
use Data::Dumper; # more useful output on failed tests

sub table {'job'}

our $DB;
do "./database.db" or die "Failed to read database.db: $!";

my $date = '2003-01-22 14:43:23.000000';

my %job = (
            name => 'Test Job',
            user_id => __PACKAGE__->user_id,
            sched_time => $date
          );

sub test_setup : Test(setup) {
    my $self = shift;
    # Turn off event logging, and job locking
    $self->{mock_job} = Test::MockModule->new('Bric::Util::Job');
    $self->{mock_job}->mock(commit_events => undef);
    $self->{mock_job}->mock(commit => undef);
    $self->{mock_job}->mock(begin => undef);
    $self->{mock_job}->mock(rollback => undef);
    $self->{mock_story} 
            = Test::MockModule->new('Bric::Biz::Asset::Business::Story');
    $self->{mock_story}->mock(commit_events => undef);
    $self->{mock_story}->mock(commit => undef);
    $self->{mock_story}->mock(begin => undef);
    $self->{mock_story}->mock(rollback => undef);
    $self->{mock_media} 
            = Test::MockModule->new('Bric::Biz::Asset::Business::Media');
    $self->{mock_media}->mock(commit_events => undef);
    $self->{mock_media}->mock(commit => undef);
    $self->{mock_media}->mock(begin => undef);
    $self->{mock_media}->mock(rollback => undef);
    # set up for possible debugging
    $self->{mock_dbi} = Test::MockModule->new('Bric::Util::DBI');
    $self->{mock_dbi}->mock(in_debug_mode => DBI_DEBUG);
    rollback;
    begin;
}

sub test_teardown : Test(teardown) {
    my $self = shift;
    rollback;
    $self->{mock_job}->unmock("commit_events");
    $self->{mock_job}->unmock("commit");
    $self->{mock_job}->unmock("begin");
    $self->{mock_job}->unmock("rollback");
    $self->{mock_story}->unmock("commit_events");
    $self->{mock_story}->unmock("commit");
    $self->{mock_story}->unmock("begin");
    $self->{mock_story}->unmock("rollback");
    $self->{mock_media}->unmock("commit_events");
    $self->{mock_media}->unmock("commit");
    $self->{mock_media}->unmock("begin");
    $self->{mock_media}->unmock("rollback");
}

##############################################################################
# Deploy the story and autohandler templates. During tests, they won't be
# found because we're using a temporary directory.
##############################################################################
sub _deploy_templates : Test(3) {
    my @tmpl = Bric::Biz::Asset::Template->list({
        output_channel__id => 1,
        file_name          => ANY('/story.mc', '/autohandler'),
        Order              => 'file_name',
    });
    ok( my $burner = Bric::Util::Burner->new, "Get burner" );
    ok( $burner->deploy($tmpl[0]), "Deploy autohandler template");
    ok( $burner->deploy($tmpl[1]), "Deploy story template");
}

##############################################################################
# Test constructors.
##############################################################################
# Test the new() constructor.
sub a_test_const : Test(5) {
    my $self = shift;
    my $sched_time = local_date(undef, undef, 1);
    my $args = { name => 'Test Job',
                 user_id => 0,
                 sched_time => $sched_time
               };

    ok ( my $job = Bric::Util::Job::Pub->new($args), "Test construtor" );
    ok( ! defined $job->get_id, 'Undefined ID' );
    is( $job->get_name, $args->{name}, "Name is '$args->{name}'" );
    is( $job->get_sched_time, $sched_time, "Scheduled time is $sched_time" );
    is( $job->get_user_id, 0, "Check User ID 0" );
}

##############################################################################
# Test the lookup() method.
sub b_test_lookup : Test(7) {
    my $self = shift;
    my %args = %job;
    ok( my $job = Bric::Util::Job::Pub->new(\%args), "Create job" );
    ok( $job->save, "Save the job" );
    ok( my $jid = $job->get_id, "Get the job ID" );
    ok( $job = Bric::Util::Job::Pub->lookup({ id => $jid }),
        "Look up the new job ID '$jid'" );
    is( $job->get_id, $jid, "Check that the ID is the same" );
    # Check a few attributes.
    is( $job->get_sched_time(ISO_8601_FORMAT), $date,
        "Scheduled time is '$date'" );
    my $uid = $self->user_id;
    is( $job->get_user_id, $uid, "Check User ID $uid" );
}

##############################################################################
# Test the list() method.
sub c_test_list : Test(70) {
    my $self = shift;

    # Create a new job group.
    ok( my $grp = Bric::Util::Grp::Job::Pub->new({ name => 'Test JobGrp' }),
        "Create group" );

    my ($element) = Bric::Biz::ElementType->list({ name => 'Story' });
    # And the default OutputChannel.
    my ($oc) = Bric::Biz::OutputChannel->list();

    # Create a destination.
    ok( my $dest = Bric::Dist::ServerType->new({ name        => 'Bogus',
                                                 move_method => 'File System',
                                                 site_id     => 100,
                                               }),
        "Create destination." );

    $dest->add_output_channels($oc);
    ok( $dest->save, "Save destination" );
    ok( my $did = $dest->get_id, "Get destination ID" );

    # look up a story element
    my $time = time;
    my $story = Bric::Biz::Asset::Business::Story->new({
            name        => "_test_$time",
            description => 'this is a test',
            priority    => 1,
            source__id  => 1,
            slug        => 'test',
            user__id    => $self->user_id(),
            element     => $element,
            site_id     => 100,
        });
    my $cat = Bric::Biz::Category->lookup({ id => 1 });
    $story->add_categories([$cat]);
    $story->set_primary_category($cat);
    $story->set_cover_date('2005-03-22 21:07:56');
    $story->save();
    my $svid = $story->get_version_id;
    my $sid  = $story->get_id;

    # XXX Check media too !!!

    # Create some test records.
    for my $n (1..5) {
        my %args = %job;
        if ($n % 2) {
            # Tweak name and add destination ID. Will be 3 of these.
            $args{name} .= $n if $n % 2;
            $args{server_types} = [$dest];
        } else {
            # Add story ID. Will be two of these.
            $args{story_instance_id} = $svid;
        }

        ok( my $job = Bric::Util::Job::Pub->new(\%args), "Create $args{name}" );
        ok( $job->save, "Save $args{name}" );
        ok( my $all_grp_id = Bric::Util::Job::INSTANCE_GROUP_ID );
        ok( my $grp_pkg = Bric::Util::Job::GROUP_PACKAGE );
        ok( my $inst_grp = $grp_pkg->lookup({ id => $all_grp_id }) );
        my %job_ids = map { $_ => 1 } $inst_grp->get_member_ids($all_grp_id);
        ok( $job_ids{$job->get_id}, "check for registered instance" );
        # Save the ID for deleting.
        $grp->add_member({ obj => $job }) if $n % 2;
    }

    # Save the group.
    ok( $grp->save, "Save group" );
    ok( my $grp_id = $grp->get_id, "Get group ID" );

    # Try name.
    ok( my @jobs = Bric::Util::Job::Pub->list({ name => $job{name} }),
        "Look up name $job{name}" );
    is( scalar @jobs, 2, "Check for 2 jobs" );

    # Try name + wildcard.
    ok( @jobs = Bric::Util::Job::Pub->list({ name => "$job{name}%" }),
        "Look up name $job{name}%" );
    is( scalar @jobs, 5, "Check for 5 jobs" );

    # Try grp_id.
    ok( @jobs = Bric::Util::Job::Pub->list({ grp_id => $grp_id }),
        "Look up grp_id '$grp_id'" );
    is( scalar @jobs, 3, "Check for 3 jobs" );

    # Make sure we've got all the Group IDs we think we should have.
    my $all_grp_id = Bric::Util::Job::INSTANCE_GROUP_ID;
    foreach my $job (@jobs) {
        my %grp_ids = map { $_ => 1 } $job->get_grp_ids;
        ok( $grp_ids{$all_grp_id},
          "Check for 'all' group ID: $all_grp_id in grp_ids:\n" 
				. Dumper($job) );
        ok( $grp_ids{$grp_id},
          "Check for group IDs" );
    }

    # Try deactivating one group membership.
    ok( my $mem = $grp->has_member({ obj => $jobs[0] }), "Get member" );
    ok( $mem->deactivate->save, "Deactivate and save member" );

    # Now there should only be two using grp_id.
    ok( @jobs = Bric::Util::Job::Pub->list({ grp_id => $grp_id }),
        "Look up grp_id '$grp_id' again" );
    is( scalar @jobs, 2, "Check for 2 jobs with grp_id $grp_id" );

    # Try user_id.
    my $uid = $self->user_id;
    ok( @jobs = Bric::Util::Job::Pub->list({ user_id => $uid }),
        "Look up user_id $uid" );
    is( scalar @jobs, 5, "Check for 5 jobs" );

    # Try sched_time.
    ok( @jobs = Bric::Util::Job::Pub->list({ sched_time => $job{sched_time} }),
        "Look up sched_time '$job{sched_time}'" );
    is( scalar @jobs, 5, "Check for 5 jobs" );

    # Try sched_time BETWEEN.
    my $before = '2003-01-01 00:00:00';
    my $after  = '2003-02-01 00:00:00';
    ok( @jobs = Bric::Util::Job::Pub->list({ sched_time => [$before, $after] }),
        "Look up sched_time BETWEEN" );
    is( scalar @jobs, 5, "Check for 5 jobs" );

    # Try after a date.
    ok( @jobs = Bric::Util::Job::Pub->list({ sched_time => [$before] }),
        "Look up sched_time after 1" );
    is( scalar @jobs, 5, "Check for 5 jobs" );

    @jobs = Bric::Util::Job::Pub->list({ sched_time => [$after] });
    is( scalar @jobs, 0, "Check for 0 jobs" );

    # Try before a date.
    ok( @jobs = Bric::Util::Job::Pub->list({ sched_time => [undef, $after] }),
        "Look up sched_time before 1" );
    is( scalar @jobs, 5, "Check for 5 jobs" );

    @jobs = Bric::Util::Job::Pub->list({ sched_time => [undef, $before] });
    is( scalar @jobs, 0, "Check for 0 jobs" );

    # Try server_type_id.
    ok( @jobs = Bric::Util::Job::Pub->list({ server_type_id => $did }),
        "Look up server_type_id '$did'" );
    is( scalar @jobs, 3, "Check for 3 jobs" );

    # Try story_id.
    ok( @jobs = Bric::Util::Job::Pub->list({ story_id => $sid }),
        "Look up story_id '$sid'" );
    is( scalar @jobs, 2, "Check for 2 jobs" );

    # Try story_instance_id.
    ok( @jobs = Bric::Util::Job::Pub->list({ story_instance_id => $svid }),
        "Look up story_instance_id '$svid'" );
    is( scalar @jobs, 2, "Check for 2 jobs" );
}

##############################################################################
# Test class methods.
##############################################################################
# Test the list_ids() method.
sub d_test_list_ids : Test(21) {
    my $self = shift;

    # Create a new job group.
    ok( my $grp = Bric::Util::Grp::Job->new({ name => 'Test JobGrp' }),
        "Create group" );

    # Create some test records.
    for my $n (1..5) {
        my %args = %job;
        # Make sure the name is unique.
        $args{name} .= $n if $n % 2;
        ok( my $job = Bric::Util::Job::Pub->new(\%args), "Create $args{name}" );
        ok( $job->save, "Save $args{name}" );
        # Save the ID for deleting.
        $grp->add_member({ obj => $job }) if $n % 2;
    }

    # Save the group.
    ok( $grp->save, "Save group" );
    ok( my $grp_id = $grp->get_id, "Get group ID" );

    # Try name.
    ok( my @job_ids = Bric::Util::Job::Pub->list_ids({ name => $job{name} }),
        "Look up name $job{name}" );
    is( scalar @job_ids, 2, "Check for 2 job ids" );

    # Try name + wildcard.
    ok( @job_ids = Bric::Util::Job::Pub->list_ids({ name => "$job{name}%" }),
        "Look up name $job{name}%" );
    is( scalar @job_ids, 5, "Check for 5 job ids" );

    # Try grp_id.
    ok( @job_ids = Bric::Util::Job::Pub->list_ids({ grp_id => $grp_id }),
        "Look up grp_id $grp_id" );
    is( scalar @job_ids, 3, "Check for 3 job ids" );

    # Try user_id.
    my $uid = $self->user_id;
    ok( @job_ids = Bric::Util::Job::Pub->list_ids({ user_id => $uid }),
        "Look up user_id $uid" );
    is( scalar @job_ids, 5, "Check for 5 job ids" );
}

##############################################################################
# Test instance methods.
##############################################################################
# Test save()
sub f_test_save : Test(9) {
    my $self = shift;
    my %args = %job;
    ok( my $job = Bric::Util::Job::Pub->new(\%args), "Create job" );
    ok( $job->save, "Save the job" );
    ok( my $jid = $job->get_id, "Get the job ID" );
    ok( $job = Bric::Util::Job::Pub->lookup({ id => $jid }),
        "Look up the new job" );
    ok( my $old_name = $job->get_name, "Get its name" );
    my $new_name = $old_name . ' Foo';
    ok( $job->set_name($new_name), "Set its name to '$new_name'" );
    ok( $job->save, "Save it" );
    ok( Bric::Util::Job::Pub->lookup({ id => $jid }),
        "Look it up again" );
    is( $job->get_name, $new_name, "Check name is '$new_name'" );

}

##############################################################################
# Test execute_me(). This is the big one.
sub g_test_execute_me : Test(10) {
    my $self = shift;
    my %args = %job;
    # Get the story element
    my ($element) = Bric::Biz::ElementType->list({ name => 'Story' });
    # And the default OutputChannel.
    my ($oc) = Bric::Biz::OutputChannel->list();
    # and a user
    # We'll need a destination, since there are none by default
    my $dest = Bric::Dist::ServerType->new({ 
                                             name => 'Big Test',
                                             move_method => 'File System',
                                             site_id     => 100,
                                          });
    $dest->add_output_channels($oc); # this is crucial for publishing
    $dest->save;
    my $did = $dest->get_id;
    # Create a story
    my $time = time;
    my $story = Bric::Biz::Asset::Business::Story->new({
            name        => "_test_$time",
            description => 'this is a test',
            priority    => 1,
            source__id  => 1,
            slug        => 'test',
            user__id    => $self->user_id(),
            element     => $element, 
            site_id     => 100,
        });
    my $cat = Bric::Biz::Category->lookup({ id => 1 });
    $story->add_categories([$cat]);
    $story->set_primary_category($cat);
    $story->set_cover_date('2005-03-22 21:07:56');
    $story->save();
    my $sid = $story->get_id;
    # create a job
    my $job = Bric::Util::Job::Pub->new(\%args);
    # add the story to the job
    $job->set_story_instance_id($story->get_version_id);
    # set the job execution time to now
    $job->set_sched_time(local_date(0, ISO_8601_FORMAT, 1));
    # test: Save the job.  With the default config file this will have the
    # side effect of executing the job. OK?
    if (QUEUE_PUBLISH_JOBS) {
        $job->save;
        ok( $job->execute_me, 'Execute the job');
    } else {
        ok( $job->save, 'Save (and execute) the job');
    }
    is( $job->get_error_message, undef, "There was no error running job.");
    # test: Check that our job is now complete
    ok( $job = Bric::Util::Job->lookup({ id => $job->get_id }), 
      'lookup the job we just executed' );
    isnt( $job->get_comp_time(), undef, 
      'check that the job has a completion time');
    # test: Check for a matching Dist job
    my $story_name = $story->get_name();
    my $job_name = "Distribute \"$story_name\" to \"Web\"";
    ok( my @dist_jobs = Bric::Util::Job::Dist->list({ name => $job_name }), 
      'list the dist jobs' );
    is( scalar @dist_jobs, 1, '... there should be just one' );
    # test: Get it's resources and ...
    my ($dist_job) = @dist_jobs;
    ok( my @resources = $dist_job->get_resources(),
      'get the resources of from the new dist job');
    is( scalar @resources, 1, '... there should be just one' );
    my ($resource) = @resources;
    # test: get the resource path
    ok( my $path = $resource->get_path, 'get the path to the resource');
    open IN, $path;
    local $/;
    my $got = <IN>;
    close IN;
    my $expect = qq{<!-- Start "autohandler" -->
<html>
    <head>
        <title>$story_name</title>
    </head>
    <body>
<!-- Start "Story" -->

<h1>$story_name</h1>

<hr />


<br>
Page 1
<!-- End "Story" -->
    </body>
</html>
<!-- End "autohandler" -->
};
    is( $got, $expect, 'Check that the resource came out all right');
    # Save any dist job ids for deleting too
}

##############################################################################
# Test execute_me error_handling.
sub h_test_execute_me : Test(16) {
    my $self = shift;

    my $elem = Bric::Biz::ElementType->new({
        name          => 'Test Element',
        key_name      => 'test_element',
        description   => 'Testing Publish Job error handling',
        top_level     => 1,
        reference     => 0,
        primary_oc_id => 1
    });
    $elem->save;

    my $tmpl = Bric::Biz::Asset::Template->new({
        output_channel__id => 1,
        user__id           => $self->user_id,
        category_id        => 1,
        site_id            => 100,
        element            => $elem,
        data               => '% die "Goodbye cruel world !";',
    });
    $tmpl->save;

    # Create a burner.
    my $fs = Bric::Util::Trans::FS->new;
    ok( my $burner = Bric::Util::Burner->new
        ({ comp_dir => $fs->cat_dir(TEMP_DIR, 'comp') }),
        "Create burner" );

    # Check in an deploy the template
    $tmpl->checkin;
    $tmpl->save;
    $burner->deploy($tmpl);

    # We'll need a destination, since there are none by default
    my $dest = Bric::Dist::ServerType->new({
        name => 'Big Test',
        move_method => 'File System',
        site_id     => 100,
    });

    # the default OutputChannel.
    my $oc = Bric::Biz::OutputChannel->lookup({ id => 1 });
    $dest->add_output_channels($oc); # this is crucial for publishing
    $dest->save;
    my $did = $dest->get_id;

    # Create a story
    my $story = Bric::Biz::Asset::Business::Story->new({
        name        => 'bad test story',
        description => 'this is a test',
        priority    => 1,
        source__id  => 1,
        slug        => 'badtest',
        user__id    => $self->user_id(),
        element     => $elem,
        site_id     => 100,
    });

    my $cat = Bric::Biz::Category->lookup({ id => 1 });
    $story->add_categories([$cat]);
    $story->set_primary_category($cat);
    $story->add_output_channels($oc);;
    $story->set_primary_oc_id(1);
    $story->set_cover_date('2005-03-22 21:07:56');
    $story->save;

    # Make sure that the old story_id parameter still works.
    my $job = Bric::Util::Job::Pub->new({
        name        => 'Test Job',
        user_id     => $self->user_id,
        sched_time  => $date,
        story_id    => $story->get_id,
    });

    if (QUEUE_PUBLISH_JOBS) {
        $job->save;
        dies_ok {$job->execute_me} 'Publish with a template error';
    } else {
        dies_ok {$job->save} 'Publish with a template error';
    }

    # check for error message
    isnt($job->get_error_message, undef, "... should have an error message now.");
    # check that tries goes up
    is($job->get_tries, 1, "... should have one try now.");
    is($job->has_failed, 0, "... has_failed should still return false.");
    # check that tries goes up on another error
    dies_ok {$job->execute_me} "Try again.";
    is($job->get_tries, 2, "... should have two tries now.");
    # check that tries goes up on another error
    dies_ok {$job->execute_me} "Try again.";
    is($job->get_tries, 3, "... should have three tries now.");
    is($job->has_failed, 1, "... has_failed should now return true.");

    # Try resetting the job.
    ok($job->reset, 'Reset the job');
    ok($job->save, 'Save the reset job');
    ok($job = Bric::Util::Job::Pub->lookup({ id => $job->get_id}),
       'Look up the job again for good measure');
    is($job->get_error_message, undef,
       'The error message should be undefined again');
    is($job->get_tries, 0, 'Tries should be reset');
    is($job->has_failed, 0, 'The job should no loner be marked as failed');
}

# test listing of jobs by asset URI and name
sub i_test_list_jobs_by_uri : Test(36) { # Plan: 3 cats * 6 assets * 2 tests
    my $self = shift;
    # FIXTURE
    my @assets; 
    foreach (0..2) { # will have three categories
        local $TODO = "tests not written yet";
        my $cat = $self->build_category;
        foreach my $n (0..2) { # and three media and stories each 18 total
            my %args = %job;
            # two stories per category to excercise search by uri
            push @assets, $self->build_story($cat);
            my $dest = $self->build_destination;
            $args{story_instance_id} = $assets[-1]->get_version_id;
            my $job = Bric::Util::Job::Pub->new(\%args);
            $job->save;
            # and two media items per category to excercise search by uri
            push @assets, $self->build_media($cat);
            $args{media_instance_id} = $assets[-1]->get_version_id;
            $job = Bric::Util::Job::Pub->new(\%args);
            $job->save;
        }
    }
    # TESTS
    foreach my $asset (@assets) {
        my $cat = $asset->get_primary_category;
        my $name = $asset->get_name;
        my $uri = $cat->get_uri . '%';
        ok( my @jobs = Bric::Util::Job::Pub->list({ uri => $uri }),
                    "List jobs by uri: " . $uri );
        is( scalar @jobs, 6, "Count jobs by uri: " . $uri )
                or $self->dump_test_data;
    }
}

sub j_test_list_jobs_by_scheduling_user : Test(4) {
    my $self = shift;
    # FIXTURE
    my @users;
    foreach (1..4) { # build 4 users
        push @users, $self->build_user;
    }
    # all the stuff we need to build a job
    my %args = %job;
    my $story = $self->build_story($self->build_category);
    $args{story_instance_id} = $story->get_version_id;
    # build the same number of jobs as the index of the user
    #        so user[0] gets no jobs, user[1] gets one, etc.
    for (my $i = 0; $i < @users; $i++) {
        for (my $y = 0; $y < $i; $y++) {
            $args{user_id} = $users[$i]->get_id;
            my $dest = $self->build_destination;
            my $job = Bric::Util::Job::Pub->new(\%args);
            $job->save;
        }
    }
    # TEST list searching by each user
    for (my $i = 0; $i < @users; $i++) {
        my @jobs = Bric::Util::Job::Pub->list({
                    user_id => $users[$i]->get_id
                });
        is( scalar @jobs, $i, "Number of jobs scheduled by user id: " 
                     . $users[$i]->get_id );
    }
}

sub k_test_locking : Test(1) {
    $TODO = 'Check to make sure that jobs are locked while executing.';
    # The locking mechanism consists of a call to commit from the job
    # XXX build all the stuff we need to build a job
    # XXX build a job
    # XXX remock Job::commit as a sub which checks job state for 'executing'
    #          and then stores the result in the fixture somewhere
    # XXX execute the job
    # XXX TEST that commit has been called while the job was in an
    #           'executing' state
}

sub build_random_string {
    my $self = shift;
    my $length = shift || 10;
    my @slice;
    foreach (1..$length) { 
        push @slice, rand 26; 
    }
    return join '', ('a'..'z')[@slice];
}

sub build_user {
    my $self = shift;
    my $user = Bric::Biz::Person::User->new({
            lname => "User",
            fname => "Test",
            login => $self->build_random_string(10),
        });
    $user->set_password( $self->build_random_string(10) );
    $user->save;
    return $user;
}

sub build_category {
    my $dir = shift->build_random_string(20);
    my $cat = Bric::Biz::Category->new({
            name        => "test: $dir",
            site_id     => 100,
            description => 'for testing jobs',
            parent_id   => 1,
            directory   => "test_$dir",
        });
    $cat->save;
    return $cat;
}

sub build_destination {
    my $self = shift;
    my ($oc) = Bric::Biz::OutputChannel->list();
    my $dest = Bric::Dist::ServerType->new({ name => $self->build_random_string,
                                         move_method => 'File System',
                                         site_id     => 100,
                                       });
    $dest->add_output_channels($oc); # this is crucial for publishing
    $dest->save;
    return $dest;
}

sub build_media {
    my ($self, $cat) = @_;
    my ($element) = Bric::Biz::ElementType->list({ name => 'Illustration' });
    my $filename = $self->build_random_string(20);
    my $image = Bric::Biz::Asset::Business::Media::Image->new({
            name        => 'image_' . time,
            file_name   => $filename,
            element     => $element, 
            priority    => 1,
            category__id => $cat->get_id,
            source__id  => 1,
            user__id    => $self->user_id(),
            description => '', # not important
            site_id     => 100,
    });
    # No need to upload an actual image, it's the job that counts
    $image->set_cover_date('2005-03-22 21:07:56'); # doesn't matter
    # Now save the media.
    $image->save;
    return $image;
}

sub build_story {
    my ($self,$cat) = @_;
    my $time = time; # for the story name
    my ($element) = Bric::Biz::ElementType->list({ name => 'Story' });
    my $slug = $self->build_random_string(20);
    my $story = Bric::Biz::Asset::Business::Story->new({
            name        => "_test_$time",
            description => 'this is a test',
            priority    => 1,
            source__id  => 1,
            slug        => $slug,
            user__id    => $self->user_id(),
            element     => $element, 
            site_id     => 100,
        });
    $story->add_categories([$cat]);
    $story->set_primary_category($cat);
    $story->set_cover_date('2005-03-22 21:07:56'); # doesn't matter
    $story->save();
    return $story;
}

sub start_debug_mode {
    shift->{mock_dbi}->mock(in_debug_mode => 1);
    return '';
}

sub stop_debug_mode {
    shift->{mock_dbi}->mock(in_debug_mode => DBI_DEBUG);
    return '';
}

sub dump_test_data {
    my $self = shift;
    my $queries = [
"SELECT * 
 FROM job
    JOIN job_member
        ON job_member.object_id = job.id
    JOIN member
        ON member.id = job_member.member__id
    LEFT JOIN story_instance                                                                                           
        ON job.story_instance__id = story_instance.id                                             
    LEFT JOIN media_instance
        ON job.media_instance__id = media_instance.id
    LEFT JOIN story_uri
        ON story_instance.story__id = story_uri.story__id
    LEFT JOIN media_uri
        ON media_instance.media__id = media_uri.media__id
"
];
    $self->start_debug_mode;
    foreach my $sql (@$queries) {
        my $dbh = prepare($sql);
        $dbh->execute();
        $dbh->dump_results(80,"\n",",",*STDERR);
    }
    $self->stop_debug_mode;
}

1;
__END__
