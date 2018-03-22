use utf8;
package TMSSchema::Result::ProductRl;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

TMSSchema::Result::ProductRl

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<product_rls>

=cut

__PACKAGE__->table("product_rls");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 prod_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 rls_num

  data_type: 'varchar'
  is_nullable: 0
  size: 100

=head2 rls_name

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 rls_type

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 remarks

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "prod_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "rls_num",
  { data_type => "varchar", is_nullable => 0, size => 100 },
  "rls_name",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "rls_type",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "remarks",
  { data_type => "varchar", is_nullable => 0, size => 255 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<uniq_prod_rls>

=over 4

=item * L</prod_id>

=item * L</rls_num>

=back

=cut

__PACKAGE__->add_unique_constraint("uniq_prod_rls", ["prod_id", "rls_num"]);

=head1 RELATIONS

=head2 features

Type: has_many

Related object: L<TMSSchema::Result::Feature>

=cut

__PACKAGE__->has_many(
  "features",
  "TMSSchema::Result::Feature",
  { "foreign.prod_rls_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 prod

Type: belongs_to

Related object: L<TMSSchema::Result::Product>

=cut

__PACKAGE__->belongs_to(
  "prod",
  "TMSSchema::Result::Product",
  { id => "prod_id" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2017-04-07 22:00:23
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:R9Dgex0rtUaHrDE7E7x9og


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
