use utf8;
package UsersSchema::Result::Membership;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

UsersSchema::Result::Membership

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<memberships>

=cut

__PACKAGE__->table("memberships");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 user_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 role_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "user_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "role_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 role

Type: belongs_to

Related object: L<UsersSchema::Result::Role>

=cut

__PACKAGE__->belongs_to(
  "role",
  "UsersSchema::Result::Role",
  { id => "role_id" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);

=head2 user

Type: belongs_to

Related object: L<UsersSchema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "user",
  "UsersSchema::Result::User",
  { id => "user_id" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2017-02-14 07:20:00
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:YS8v5BlQ5tQU8ZL644ffhQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
