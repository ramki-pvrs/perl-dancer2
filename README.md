References:
- perl dancer2 documentation
- advent.perldancer.org articles
- https://github.com/sherwind/dancer2-example
- youtube videos by Sawyer X and his articles
- https://www.digitalocean.com/ - many of my installations attempts were successful because of this URL contents
- https://github.com/ramki-pvrs/perl-dancer2.git (my own project site)

My Thanks:
- to all authors who posted their work in public, making it easier for me to learn
- these apps are dedicated to all of them

Prerequisites:
- anyone who wants to use this app need to go through dancer2 documentation and their tutorials
- need some understanding of Redis session server in ubuntu (how to install and start the server)
- MySQL setup and database creation - I used MYSQL WORKBENCH as mysql client
- some full stack web development knowledge (HTML, CSS, BOOTSTRAP, jQUERY, server side programming, DB ....)
- MVC WEB architecture

What is this?
- two sample apps, User Management System(UMS) and Test Management System(TMS)
- this app helps to understand how to use dancer2 along with some of the critical packages
	- I developed with dancer2 version .204004 and run sanity with .205002, it worked :)
- refer to config.yml for some of the features I have setup
	- shows how to connect two data bases to use in TMS project

What is this not?
- neither a comprehensive application covering all user and test management workflows nor covering all features of dancer2
- only the following features are tested
	- Create New Test Case in Add/Create menu
- menus are just shown from GUI - not tested fully

Project Development Environment:
- ubuntu 16.04 LTS
- MySQL, Redis Server, Carton (package manager) - these are installed in ubuntu (i.e. not local to this dancer2 project) 
	- MySQL user id root and password should be set to root123
	- required for the apps; not secured 
 - ref:http://advent.perldancer.org/2014/4
- html, CSS, bootstrap, jQuery, 
- Firefox as browser

How to use?
- git clone or download the zip
- note that UMS can be a standalone app, whereas TMS needs UMS to create users (e.g engineers who write testcases)
- in both TMS and UMS directories, setup .gitignore with local/ logs/ (though I have checked in logs folder, just to show how the logs will look like; )
- use the dB dump 'Users_TMS_sample_MySQL_dB_dump.sql' and create the two databases TMS, Users with respective dummy data
	- I use MYSQL WORKBENCH as mysql client
- install DBIx::Class::Schema::Loader and DBIx::Class::PassphraseColumn (e.g sudo perl -MCPAN -e 'install DBIx::Class::Schema::Loader')
- install Redis in ubuntu and setup the server; if you type redis-cli ping on ubuntu cmd prompt, you shd get PONG
- in both TMS and UMS directories, run 'carton install'; this command might take sometime because all packages have to be installed
- in both TMS and UMS directories, run 'perl load_DB_schema_to_create_models.pl'; 
	- this will create the models for you; 
	- some extra functions are added here such that when a user name and password is created using UMS app, password is encrypted using Blowfishcrypt

- assuming all modules from cpanfile are installed in UMS directory,goto UMS directory and run 'carton exec plackup -p 8090 bin/app.psgi' and you should see URL for UMS app; 
	- to login you can use eeee@y.com with password eeee1234
	- curl_commands file shows rest interface to UMS app; note the port number used, change it to yours
- assuming all modules from cpanfile are installed in TMS directory, goto TMS directory and run 'carton exec plackup -p 8091 bin/app.psgi' and you should see URL for TMS app
	- try adding a test case

Contact:
ramki
ramki.pvrs@gmail.com

Some more links refered:
http://search.cpan.org/dist/HTML-FormHandler-0.40057/lib/HTML/FormHandler/Field/Select.pm
http://search.cpan.org/~gshank/HTML-FormHandler-0.40067/lib/HTML/FormHandler/Manual/Cookbook.pod#Select_lists
http://search.cpan.org/~gshank/HTML-FormHandler-0.40067/lib/HTML/FormHandler/Manual/Cookbook.pod
http://search.cpan.org/~gshank/HTML-FormHandler-Model-DBIC-0.29/lib/HTML/FormHandler/TraitFor/Model/DBIC.pm#belongs_to
-- lookup_options
http://search.cpan.org/~gshank/HTML-FormHandler-0.40067/lib/HTML/FormHandler/Field.pm
also search for 'hidden field' in the above links

