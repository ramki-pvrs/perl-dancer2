use utf8;
package UsersSchema::Result::Role;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

UsersSchema::Result::Role

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<roles>

=cut

__PACKAGE__->table("roles");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 role

  data_type: 'varchar'
  is_nullable: 0
  size: 40

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "role",
  { data_type => "varchar", is_nullable => 0, size => 40 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<uniq_role>

=over 4

=item * L</role>

=back

=cut

__PACKAGE__->add_unique_constraint("uniq_role", ["role"]);

=head1 RELATIONS

=head2 memberships

Type: has_many

Related object: L<UsersSchema::Result::Membership>

=cut

__PACKAGE__->has_many(
  "memberships",
  "UsersSchema::Result::Membership",
  { "foreign.role_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 user_roles

Type: has_many

Related object: L<UsersSchema::Result::UserRole>

=cut

__PACKAGE__->has_many(
  "user_roles",
  "UsersSchema::Result::UserRole",
  { "foreign.role_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2017-02-16 08:03:00
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:TUzralQZDRwPmBfR89DYcQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
