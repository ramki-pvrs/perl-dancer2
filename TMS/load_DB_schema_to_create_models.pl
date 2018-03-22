#!/usr/bin/perl

use strict;
use warnings;

use DBIx::Class::Schema::Loader qw/ make_schema_at /;

our $users_conn_info = [ 'dbi:mysql:dbname=Users:localhost', 'root', 'root123' ];
our $tms_conn_info = [ 'dbi:mysql:dbname=TMS:localhost', 'root', 'root123' ];

# IMPORTANT: need to install DBIx::Class::Schema::Loader and 
# DBIx::Class::PassphraseColumn in opensips>sudo cpan
# command line because this file is outside of carton package
# manager context in this app


#call make_schema_at to create the schema; this is a method from DBIx::Class::Schema::Loader

# DBIx::Class::Schema::Loader::Base  constructor options are give below
# such that additional password column attributes are loaded in the result set (passphrase values are in addition to mysql db attributes)
# the result_components_map constructor enables additional packages to be loaded before namespaces are loaded
# though we are not using it here, schema_components loads packages in UsersSchema.pm where result_components_map loads additional packages 
# only to tables (resultsets) given by the key of the hash, (here 'User')

my $customPasswd = sub {
				        my ($table, $column_name, $column_info) = @_;
				        if ($column_name eq 'password') {
				            return { data_type => "varchar", 
				            		 is_nullable => 0, 
				            		 size => 255, 
				            		 passphrase => 'rfc2307',
				            		 passphrase_class => 'BlowfishCrypt',
				            		 passphrase_args  => {key_nul => 1, cost => 10, salt_random => 20 },
				    				 passphrase_check_method => 'check_password'  };
				    			   }
                   };
make_schema_at (
	'UsersSchema',
	{debug => 1,
	 dump_directory => './lib',
	 overwrite_modifications => 1,
	 custom_column_info => $customPasswd,
	 #schema_components => (qw(PassphraseColumn)),
	 result_components_map => { User    => (qw/PassphraseColumn/),}
	}, [@{$users_conn_info}]
);

make_schema_at (
	'TMSSchema',
	{debug => 1,
	 dump_directory => './lib',
	 overwrite_modifications => 1,
	 #custom_column_info => $customPasswd,
	 #schema_components => (qw(PassphraseColumn)),
	 #result_components_map => { User    => (qw/PassphraseColumn/),}
	}, [@{$tms_conn_info}]
);