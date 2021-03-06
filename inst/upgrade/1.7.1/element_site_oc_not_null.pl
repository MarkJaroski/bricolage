#!/usr/bin/perl -w

use strict;
use File::Spec::Functions qw(catdir updir);
use FindBin;
use lib catdir $FindBin::Bin, updir, 'lib';
use bric_upgrade qw(:all);

# Just exit if the column is NOT NULL.
exit if test_column 'element__site', 'primary_oc__id', undef, 1;

# Make sure that there are no NULLs in the column.
die "Cannot make element__site.primary_oc__id NOT NULL because\n",
  "there are NULL values in it. This is because there are story\n",
  "type and/or media type elements without a primary output channel\n",
  "associated with one or more sites. Please correct this problem\n",
  "and try again.\n"
  if fetch_sql
  "SELECT 1
   WHERE  EXISTS (
            SELECT 1
            FROM   element__site
            WHERE  primary_oc__id IS NULL
          )
  ";

# Make the column NOT NULL.
if (db_version ge '7.3') {
    # This should work even if the column already is not null.
    do_sql "ALTER TABLE element__site ALTER COLUMN primary_oc__id SET NOT NULL";
} else {
    # This approach may not be safe. If so, we'll have to add the constraint
    # using a CHECK.
    do_sql
      q{LOCK TABLE element__site IN ACCESS EXCLUSIVE MODE},
      "UPDATE pg_attribute
       SET    attnotnull = 't'
       WHERE  attname = 'primary_oc__id'
               AND attrelid in (
                 SELECT oid
                 FROM   pg_class
                 WHERE  relkind='r'
                        AND relname='element__site'
               )
      ";
}

