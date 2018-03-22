package UMS::RESTUMS;

BEGIN {
	$ENV{DBIC_TRACE} =  "1=/home/opensips/perl_tut/dancer2/UserMgmt/UMS/logs/DBIC_TRACE.log";
}

use Dancer2;
use Dancer2::Plugin::Deferred;
use Dancer2::Plugin::DBIC;
use Dancer2::Plugin::Auth::Extensible;
use Dancer2::Plugin::Auth::Extensible::Provider::DBIC;
use Dancer2::Plugin::Auth::Extensible::Provider::Usergroup;
#use Dancer2::Serializer::JSON;
#use v5.10.1;
#use Data::Dumper;
use Dancer2::Plugin::REST;

#prepare_serializer_for_format;
set serializer => 'JSON'; 

use NewUserForm;



our $VERSION = '0.1';


get '/' => sub {
	#template 'static_pages/home';
	# working line return to_json => {"msg" => "Hello there"};
	return {"msg" => "Hello there"};
};

# http://search.cpan.org/~jrobinson/DBIx-Class-Tutorial-0.0001/lib/DBIx/Class/Tutorial/Part1.pod
# check on Inserting data section

#other sites search string = perl DBIx::Class MySQL example
#VERY IMPORTANT: with test scripts as well https://github.com/castaway/dbix-class-book/blob/master/chapters/04-Creating-Reading-Updating-Deleting.md
#
post '/newuser' =>  sub {
	app->log("debug", {params});
	app->log("debug", {body_parameters});
	#app->log("debug", {parameters});
	my $newuser = schema('users')->resultset('User')->create({params});
	  #print $newname->in_storage();  ## 1 (TRUE)
	#app->log("debug", $newuser);
	#app->log("debug", $newuser->in_storage());
	app->log("debug", {params});
	app->log("debug", {body_parameters});
	#app->log("debug", {parameters});
};



any ['get', 'post'] => '/custom_login' => sub {
	#my $err;
	#my $reqloginNote;

	#app->log("debug", "print return_url using param keyword ".param('return_url'));
	#app->log("debug", "print return_url using query_parameters keyword ".query_parameters->get('return_url'));

	if ( request->method() eq "POST" ) {
		#app->log("debug", params);
		             
		#app->log("debug", body_parameters);
		


		my $user = schema('users')->resultset('User')->find({email => lc body_parameters->get('email')});
		#app->log("debug", $user);

		my ($success, $realm) = authenticate_user(
	    	$user->username, body_parameters->get('password')
		);

		if ($success) {
		    # change session ID if we have a new enough D2 version with support
		    # (security best practice on privilege level change)
		    app->change_session_id if app->can('change_session_id');
		    session 'logged_in' => true;
		    session logged_in_user => $user->username;
		    session logged_in_user_realm => $realm;
		    session 'user_id' => $user->id;

		    #working line: return {"msg" => "Login Successful"};
		    #working line return {"thisUser" => $user->username};
		    #working line return {"thisSession" => session('logged_in_user')};
		    #return {"thisSession" => {$user->_column_data}};
		    #something working in next two lines; jumbled hash value, not useful but kep it only for some reference 
		    #my $hash = session;
		    #return {"thisSession" => %{$hash} };
		    return {"Logged in User" => session('logged_in_user'), "Result" => "Login Successful"};
		   

		    #return session.logged_in_user;
		 	#deferred success => 'Login Successful (deferred msg)';
		 	#redirect param('return_url') || '/user/'.session('user_id');
		 	# per Dancer2 manual, avoid using param or params keyword, instead use route_parameters, query_parameters or body_parameters based on context
		 	# route_parameters => http://localhost:5006/user/:id (route_parameters->get('id') will give the id passed in the route)
		 	# query_parameters => http://localhost:5006/custom_login?return_url=%2Freqlogin (query_parameters->get('return_url') 
		 		#will give /reqlogin)
		 	#body_parameters is when you use a form and submit (the body of the HTTP method will have those parameters which you can use)
		 	#redirect query_parameters->get('return_url') || '/user/'.session('user_id');
		} else {
			#deferred error => 'Seems some problem in login, please try again?';
			#redirect '/custom_login';
		    # authentication failed
		    return {"Result" => "Login Failed"};
		}

	} # end of if POST
	#if (param('return_url') eq '/reqlogin') {
	#if (param('return_url')) {
	# if (query_parameters->get('return_url')) {
	# 	$reqloginNote = "Please login to access this site.";
	# } 
	# # display login form
	# template 'user/custom_login_template', {
	#   'err' => $err,'reqloginNote' => $reqloginNote
	# };
};

# show
get '/user/:id' => require_login sub {
	my $user = schema('users')->resultset('User')->find(param('id'))
	    or return send_error('Not Found', 404);
	
};

# edit
get '/user/:id/edit' => require_login sub {
	my $user = schema('users')->resultset('User')->find(param('id'))
	    or return send_error('Not Found', 404);

	my $form = NewUserForm->new;
	$form->process(item => $user, params => { params });

	template 'user/edit' => { form => $form };
};

# update
any [ 'post', 'put' ] => '/user/:id' => require_login sub {
	my $user = schema('users')->resultset('User')->find(param('id'))
	    or return send_error('Not Found', 404);

	my $form = NewUserForm->new;
	$form->process(item => $user, params => { params });

	if ($form->validated) {
	    deferred success => 'Dear '.$user->firstname.', Your profile is updated';
	    redirect uri_for('/user/' . $user->id);
	} else {
	    template 'user/edit' => { form => $form };
	}
};

any '/custom_logout' => sub {
    app->destroy_session;
    redirect '/';
};

# in any template now you can use testLogin keyword to check value and do something on condition
# as an example, user/custom_login_template uses this token now
hook before_template_render => sub {
        my $tokens = shift;
        $tokens->{testLogin} = 'need login';
};

get '/reqlogin' => require_login sub {
	#deferred error => 'Hello, you need to login to User Management System (UMS) to access this site';
	return 'Only after login';
};

get '/report' => require_role Admin => sub {
	return 'Only authenticated users should be able to see this page';
};


true;
