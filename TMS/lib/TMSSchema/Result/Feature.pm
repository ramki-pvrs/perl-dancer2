use utf8;
package TMSSchema::Result::Feature;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

TMSSchema::Result::Feature

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<features>

=cut

__PACKAGE__->table("features");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 fname

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 prod_rls_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 fg_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "fname",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "prod_rls_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "fg_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 fg

Type: belongs_to

Related object: L<TMSSchema::Result::Featuregroup>

=cut

__PACKAGE__->belongs_to(
  "fg",
  "TMSSchema::Result::Featuregroup",
  { id => "fg_id" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);

=head2 prod_rl

Type: belongs_to

Related object: L<TMSSchema::Result::ProductRl>

=cut

__PACKAGE__->belongs_to(
  "prod_rl",
  "TMSSchema::Result::ProductRl",
  { id => "prod_rls_id" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);

=head2 testcases

Type: has_many

Related object: L<TMSSchema::Result::Testcase>

=cut

__PACKAGE__->has_many(
  "testcases",
  "TMSSchema::Result::Testcase",
  { "foreign.feat_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2017-04-07 22:00:23
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:yFrfKXep/1sqtbg9tBqWsA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
