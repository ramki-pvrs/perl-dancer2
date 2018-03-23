package RESTUMS;

BEGIN {
	#change to your path
	$ENV{DBIC_TRACE} =  "1=/home/opensips/perl_tut/dancer2/UserMgmt/UMS/logs/DBIC_TRACE.log";
}

use Dancer2;
use Dancer2::Plugin::Deferred;
use Dancer2::Plugin::DBIC;
use Dancer2::Plugin::Auth::Extensible;
use Dancer2::Plugin::Auth::Extensible::Provider::DBIC;
use Dancer2::Plugin::Auth::Extensible::Provider::Usergroup;
use Dancer2::Serializer::JSON;
#use Dancer2::Plugin::REST;
set serializer => 'JSON'; 

#prepare_serializer_for_format;

use NewUserForm;

our $VERSION = '0.1';


get '/rest' => sub {
	#template 'static_pages/home';
	return to_json => {"Hello there"};
};

# any ['get', 'post'] => '/rest/newuser' =>  sub {
# 	app->log("debug", "before form process line");
# 	app->log("debug", body_parameters);
# 	my $user = schema('users')->resultset('User')->new_result({});
# 	my $form = NewUserForm->new;
# 	$form->process(item => $user, params => {params});
# 	#app->log("debug", params);
# 	app->log("debug", "afer form process line");
# 	app->log("debug", param);
# 	app->log("debug", body_parameters);

# 	if (request->method() eq "GET") {
# 		template 'user/newuser' => { form => $form };
# 	} elsif(request->method() eq "POST") {
# 		if ($form->validated) {
# 			# change session ID if we have a new enough D2 version with support
# 		    # (security best practice on privilege level change)
# 		    app->change_session_id if app->can('change_session_id');
# 		    session 'logged_in' => true;
# 		    session logged_in_user => $user->username;
# 		    session logged_in_user_realm => 'users';
# 		    session 'user_id' => $user->id;
# 	    	#app->log("debug", session);
# 	    	#app->log("debug", $user);
# 	    	return 'Dear '.$user->firstname.', Welcome to UMS, your User Management System, truely!';
# 	    	#redirect '/user/rest/'.session('user_id');
# 		} else {
# 			return 'Seems some problem in signing up, please try again?';
# 	    	#template 'user/newuser' => { form => $form };
# 		}
# 	} # END of post

# };

# any ['get', 'post'] => '/rest/custom_login' => sub {
# 	my $err;
# 	my $reqloginNote;

# 	app->log("debug", "print return_url using param keyword ".param('return_url'));
# 	app->log("debug", "print return_url using query_parameters keyword ".query_parameters->get('return_url'));

# 	if ( request->method() eq "POST" ) {
# 		my $user = schema('users')->resultset('User')->find({email => lc param('session.email')});

# 		my ($success, $realm) = authenticate_user(
# 	    	$user->username, param('session.password')
# 		);

# 		if ($success) {
# 		    # change session ID if we have a new enough D2 version with support
# 		    # (security best practice on privilege level change)
# 		    app->change_session_id if app->can('change_session_id');
# 		    session 'logged_in' => true;
# 		    session logged_in_user => $user->username;
# 		    session logged_in_user_realm => $realm;
# 		    session 'user_id' => $user->id;
# 		 	deferred success => 'Login Successful (deferred msg)';
# 		 	#redirect param('return_url') || '/user/'.session('user_id');
# 		 	# per Dancer2 manual, avoid using param or params keyword, instead use route_parameters, query_parameters or body_parameters based on context
# 		 	# route_parameters => http://localhost:5006/user/:id (route_parameters->get('id') will give the id passed in the route)
# 		 	# query_parameters => http://localhost:5006/custom_login?return_url=%2Freqlogin (query_parameters->get('return_url') 
# 		 		#will give /reqlogin)
# 		 	#body_parameters is when you use a form and submit (the body of the HTTP method will have those parameters which you can use)
# 		 	redirect query_parameters->get('return_url') || '/user/'.session('user_id');
# 		} else {
# 			deferred error => 'Seems some problem in login, please try again?';
# 			redirect '/rest/custom_login';
# 		    # authentication failed
# 		}

# 	} # end of if POST
# 	#if (param('return_url') eq '/reqlogin') {
# 	#if (param('return_url')) {
# 	if (query_parameters->get('return_url')) {
# 		$reqloginNote = "Please login to access this site.";
# 	} 
# 	# display login form
# 	template 'user/custom_login_template', {
# 	  'err' => $err,'reqloginNote' => $reqloginNote
# 	};
# };

# # show
# get '/rest/user/:id' => require_login sub {
# 	my $user = schema('users')->resultset('User')->find(param('id'))
# 	    or return send_error('Not Found', 404);
# 	template 'user/show' => { user => $user };
# };

# # edit
# get '/rest/user/:id/edit' => require_login sub {
# 	my $user = schema('users')->resultset('User')->find(param('id'))
# 	    or return send_error('Not Found', 404);

# 	my $form = NewUserForm->new;
# 	$form->process(item => $user, params => { params });

# 	template 'user/edit' => { form => $form };
# };

# # update
# any [ 'post', 'put' ] => '/rest/user/:id' => require_login sub {
# 	my $user = schema('users')->resultset('User')->find(param('id'))
# 	    or return send_error('Not Found', 404);

# 	my $form = NewUserForm->new;
# 	$form->process(item => $user, params => { params });

# 	if ($form->validated) {
# 	    deferred success => 'Dear '.$user->firstname.', Your profile is updated';
# 	    redirect uri_for('/rest/user/' . $user->id);
# 	} else {
# 	    template 'user/edit' => { form => $form };
# 	}
# };

# any '/custom_logout' => sub {
#     app->destroy_session;
#     redirect '/rest/';
# };

# # in any template now you can use testLogin keyword to check value and do something on condition
# # as an example, user/custom_login_template uses this token now
# hook before_template_render => sub {
#         my $tokens = shift;
#         $tokens->{testLogin} = 'need login';
# };

# get '/rest/reqlogin' => require_login sub {
# 	#deferred error => 'Hello, you need to login to User Management System (UMS) to access this site';
# 	return 'Only after login';
# };

# get '/rest/report' => require_role Admin => sub {
# 	return 'Only authenticated users should be able to see this page';
# };


true;
