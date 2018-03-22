use utf8;
package UsersSchema::Result::UserRolesView;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

UsersSchema::Result::UserRolesView - VIEW

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';
__PACKAGE__->table_class("DBIx::Class::ResultSource::View");

=head1 TABLE: C<user_roles_view>

=cut

__PACKAGE__->table("user_roles_view");
__PACKAGE__->result_source_instance->view_definition("select `Users`.`memberships`.`user_id` AS `user_id`,`Users`.`users`.`username` AS `username`,`Users`.`users`.`email` AS `email`,`Users`.`users`.`mobilenumber` AS `mobilenumber`,`Users`.`memberships`.`role_id` AS `role_id`,`Users`.`roles`.`role` AS `role` from ((`Users`.`users` left join `Users`.`memberships` on((`Users`.`users`.`id` = `Users`.`memberships`.`user_id`))) left join `Users`.`roles` on((`Users`.`roles`.`id` = `Users`.`memberships`.`role_id`)))");

=head1 ACCESSORS

=head2 user_id

  data_type: 'integer'
  is_nullable: 1

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

=head2 role_id

  data_type: 'integer'
  is_nullable: 1

=head2 role

  data_type: 'varchar'
  is_nullable: 1
  size: 40

=cut

__PACKAGE__->add_columns(
  "user_id",
  { data_type => "integer", is_nullable => 1 },
  "username",
  { data_type => "varchar", is_nullable => 0, size => 40 },
  "email",
  { data_type => "varchar", is_nullable => 0, size => 255 },
  "mobilenumber",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "role_id",
  { data_type => "integer", is_nullable => 1 },
  "role",
  { data_type => "varchar", is_nullable => 1, size => 40 },
);


# Created by DBIx::Class::Schema::Loader v0.07046 @ 2017-04-07 22:00:23
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:cjrWjyDvPO9zIswr5j+v1A


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
