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
- in ubuntu install (typical installation procedure followed; for any error, refer respective documentation or google)
	- sudo apt-get update
	- sudo apt-get install git-all
	- sudo apt-get install mysql-workbench
	- sudo apt-get install libmysqlclient-dev
	- sudo apt-get install carton
	- sudo apt install redis-server
		- after install, at prompt, if you enter redis-cli ping, you should get PONG as response
	- sudo perl -MCPAN -e 'install DBIx::Class::Schema::Loader' (takes a long time to install)
	- sudo perl -MCPAN -e 'install DBIx::Class::PassphraseColumn' (takes a long time to install)
- makesure for your username mysql is set with grant all privileges like
	- ubuntu prompt$mysql -uroot -p (if you have not configured any password just press enter)
	- mysql>CREATE USER 'your_username'@'localhost' IDENTIFIED BY 'your_password';
	- mysql>GRANT ALL PRIVILEGES ON * . * TO 'your_username'@'localhost';
	- mysql>FLUSH PRIVILEGES;
- create a project directory and change to that directory
- git init
- git clone https://github.com/ramki-pvrs/perl-dancer2.git
	- note that UMS can be a standalone app, whereas TMS needs UMS to create users (e.g engineers who write testcases)
- in both TMS and UMS directories, setup .gitignore with local/ logs/ (though I have checked in logs folder, just to show how the logs will look like; )
- use the dB dump in TMS directory,'Users_TMS_sample_MySQL_dB_dump.sql' and create the two databases TMS, Users with respective dummy data
	- I use MYSQL WORKBENCH as mysql client (root/root123)
	- change the definer user name and password if any before running the dump per your local setup
- in both TMS and UMS directories, run 'carton install'; this command might take sometime to complete because all packages have to be installed
- dB models are created in both UMS and TMS apps by running 'perl load_DB_schema_to_create_models.pl'; 
	- already created so don't need to run; for a new project setup, will be useful 
	- some extra functions are added here such that when a user name and password is created using UMS app, password is encrypted using Blowfishcrypt
- *****EDITS BASED ON YOUR LOCAL SETTINGS:******
	- edit TMS/config.yml
		- change log_dir to your path (opensips is my ubuntu username and password)
		- change DBIC your_username and password in users dB and testcases dB settings (you should be able to use MySQL Workbench with this user name and password)
	- edit TMS/lib/TMS.pm and change the DBIC log path at the top BEGIN section
	- repeat the same for UMS/config.yml and UMS/lib/UMS.pm, UMS/lib/RESTUMS.pm, UMS/lib/UMS/RESTUMS.pm files
		- though UMS/lib/UMS/RESTUMS.pm looks like obsolete; only UMS/lib/RESTUMS.pm in action

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

