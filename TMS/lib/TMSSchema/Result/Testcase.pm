use utf8;
package TMSSchema::Result::Testcase;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

TMSSchema::Result::Testcase

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<testcases>

=cut

__PACKAGE__->table("testcases");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 feat_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 title

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 description

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 setup

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 exec_steps

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 expected_result

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 automate

  data_type: 'tinyint'
  default_value: 1
  is_nullable: 1

=head2 automt_sts

  data_type: 'tinyint'
  default_value: 0
  is_nullable: 1

=head2 script_path

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 status

  data_type: 'enum'
  default_value: 'Active'
  extra: {list => ["Active","Obsolete"]}
  is_nullable: 1

=head2 author_id

  data_type: 'integer'
  is_nullable: 0

=head2 created

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  default_value: 'CURRENT_TIMESTAMP'
  is_nullable: 1

=head2 updated

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  default_value: 'CURRENT_TIMESTAMP'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "feat_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "title",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "description",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "setup",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "exec_steps",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "expected_result",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "automate",
  { data_type => "tinyint", default_value => 1, is_nullable => 1 },
  "automt_sts",
  { data_type => "tinyint", default_value => 0, is_nullable => 1 },
  "script_path",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "status",
  {
    data_type => "enum",
    default_value => "Active",
    extra => { list => ["Active", "Obsolete"] },
    is_nullable => 1,
  },
  "author_id",
  { data_type => "integer", is_nullable => 0 },
  "created",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    default_value => "CURRENT_TIMESTAMP",
    is_nullable => 1,
  },
  "updated",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    default_value => "CURRENT_TIMESTAMP",
    is_nullable => 1,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 feat

Type: belongs_to

Related object: L<TMSSchema::Result::Feature>

=cut

__PACKAGE__->belongs_to(
  "feat",
  "TMSSchema::Result::Feature",
  { id => "feat_id" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2017-04-07 22:00:23
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:R+jw9ynw783F++6SfvrMWQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
