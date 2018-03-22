use utf8;
package UsersSchema::Result::User;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

UsersSchema::Result::User

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::PassphraseColumn>

=back

=cut

__PACKAGE__->load_components("PassphraseColumn");

=head1 TABLE: C<users>

=cut

__PACKAGE__->table("users");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 username

  data_type: 'varchar'
  is_nullable: 0
  size: 40

=head2 email

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 mobilenumber

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 firstname

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 lastname

  data_type: 'varchar'
  is_nullable: 0
  size: 255

=head2 password

  data_type: 'varchar'
  is_nullable: 0
  passphrase: 'rfc2307'
  passphrase_args: {cost => 10,key_nul => 1,salt_random => 20}
  passphrase_check_method: 'check_password'
  passphrase_class: 'BlowfishCrypt'
  size: 255

=head2 manager_id

  data_type: 'integer'
  is_nullable: 1

=head2 created_at

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  default_value: 'CURRENT_TIMESTAMP'
  is_nullable: 1

=head2 updated_at

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  default_value: 'CURRENT_TIMESTAMP'
  is_nullable: 1

=head2 status

  data_type: 'enum'
  default_value: 'Active'
  extra: {list => ["Active","Inactive"]}
  is_nullable: 1

=head2 canlogin

  data_type: 'tinyint'
  default_value: 1
  is_nullable: 1

=head2 lastlogin

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 pw_changed

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 pw_reset_code

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "username",
  { data_type => "varchar", is_nullable => 0, size => 40 },
  "email",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "mobilenumber",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "firstname",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "lastname",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "password",
  {
    data_type => "varchar",
    is_nullable => 0,
    passphrase => "rfc2307",
    passphrase_args => { cost => 10, key_nul => 1, salt_random => 20 },
    passphrase_check_method => "check_password",
    passphrase_class => "BlowfishCrypt",
    size => 255,
  },
  "manager_id",
  { data_type => "integer", is_nullable => 1 },
  "created_at",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    default_value => "CURRENT_TIMESTAMP",
    is_nullable => 1,
  },
  "updated_at",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    default_value => "CURRENT_TIMESTAMP",
    is_nullable => 1,
  },
  "status",
  {
    data_type => "enum",
    default_value => "Active",
    extra => { list => ["Active", "Inactive"] },
    is_nullable => 1,
  },
  "canlogin",
  { data_type => "tinyint", default_value => 1, is_nullable => 1 },
  "lastlogin",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  "pw_changed",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  "pw_reset_code",
  { data_type => "varchar", is_nullable => 1, size => 255 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<uniq_email>

=over 4

=item * L</email>

=back

=cut

__PACKAGE__->add_unique_constraint("uniq_email", ["email"]);

=head2 C<uniq_user>

=over 4

=item * L</username>

=back

=cut

__PACKAGE__->add_unique_constraint("uniq_user", ["username"]);

=head1 RELATIONS

=head2 memberships

Type: has_many

Related object: L<UsersSchema::Result::Membership>

=cut

__PACKAGE__->has_many(
  "memberships",
  "UsersSchema::Result::Membership",
  { "foreign.user_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 user_roles

Type: has_many

Related object: L<UsersSchema::Result::UserRole>

=cut

__PACKAGE__->has_many(
  "user_roles",
  "UsersSchema::Result::UserRole",
  { "foreign.user_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2017-04-07 22:00:23
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:qeZTyhebX7vLWoyWJI8itQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
