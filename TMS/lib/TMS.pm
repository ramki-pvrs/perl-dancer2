package TMS;
BEGIN {
    $ENV{DBIC_TRACE} =  "1=/home/opensips/perl_tut/dancer2/TMS/logs/DBIC_TRACE.log";
}
use Dancer2;
use Dancer2::Plugin::Deferred;
use Dancer2::Plugin::DBIC;
use Dancer2::Plugin::Auth::Extensible;
use Dancer2::Plugin::Auth::Extensible::Provider::DBIC;
use Dancer2::Plugin::Auth::Extensible::Provider::Usergroup;
use Dancer2::Plugin::Ajax;
use Dancer2::Serializer::JSON;
use Data::Dumper qw(Dumper);
use NewTestCaseForm;
use EditTestCaseForm;

our $VERSION = '0.1';

any ['get', 'post'] => '/' =>  sub {
    app->log("debug", "1");
    my $err;
	if (request->method() eq "GET") {
 		template 'static_pages/home';
 	}elsif ( request->method() eq "POST" ) {
        app->log("debug", "2");
        my $user = schema('users')->resultset('User')->find({username => lc param('session.username')});
       
        my ($success, $realm) = authenticate_user(
            $user->username, param('session.password')
        );

        app->log("debug", "3");

        if ($success) {
            app->log("debug", "successful post of login params");
            # change session ID if we have a new enough D2 version with support
            # (security best practice on privilege level change)
            app->change_session_id if app->can('change_session_id');
            session 'logged_in' => true;
            session logged_in_user => $user->username;
            session logged_in_user_realm => $realm;
            session 'user_id' => $user->id;
            app->log("debug", session);
            deferred success => 'Login Successful (deferred msg)';
            #redirect param('return_url') || '/user/'.session('user_id');
            # per Dancer2 manual, avoid using param or params keyword, instead use route_parameters, query_parameters or body_parameters based on context
            # route_parameters => http://localhost:5006/user/:id (route_parameters->get('id') will give the id passed in the route)
            # query_parameters => http://localhost:5006/custom_login?return_url=%2Freqlogin (query_parameters->get('return_url') 
                #will give /reqlogin)
            #body_parameters is when you use a form and submit (the body of the HTTP method will have those parameters which you can use)
            redirect '/menu';
            # changed from menu to /newtestcase
        } else {
            app->log("debug", "4");

            deferred error => 'Seems some problem in login, please try again?';
            redirect '/error';
            # authentication failed
        }

    } # end of if POST
};

get '/menu' => sub {
    template 'testcases/testcasemenu';

};

any ['get', 'post'] => '/newtestcase' =>  sub {
    #return "testing";
# 	#app->log("debug", "before form process line");
# 	#app->log("debug", body_parameters);
 	my $testcase = schema('testcases')->resultset('Testcase')->new_result({});
	#return "succesful";
# 	# #app->log("debug", $user);
 	my $form = NewTestCaseForm->new;
	$form->process(item => $testcase, params => {params});
# 	# #app->log("debug", $user);
# 	# #app->log("debug", {params});
# 	# #app->log("debug", params);
# 	# #app->log("debug", "afer form process line");
# 	# #app->log("debug", param);
    #app->log("debug", body_parameters);

 	if (request->method() eq "GET") {
 		template 'testcases/newtestcase' => { form => $form };
 	}elsif(request->method() eq "POST") {
 	 	if ($form->validated) {
# 	 		# change session ID if we have a new enough D2 version with support
# 	# 	    # (security best practice on privilege level change)
# 	# 	    #app->change_session_id if app->can('change_session_id');
# 	# 	    #session 'logged_in' => true;
# 	# 	    #session logged_in_user => $user->username;
# 	# 	    #session logged_in_user_realm => 'users';
# 	# 	    #session 'user_id' => $user->id;
# 	#     	#app->log("debug", session);
# 	#     	#app->log("debug", $user);
# 	#     	#deferred success => 'Dear '.$user->firstname.', Welcome to UMS, your User Management System, truely!';
# 	#     	#redirect '/user/'.session('user_id');
 		deferred success => 'succesful added new testcase with following id'.$testcase->id;
        return 'succesful added new testcase with following id '.$testcase->id;
# 		redirect '/newtestcase';
 	 	} else {
 	 		deferred error => 'Seems some problem in adding the testcase, please try again?';
	    	template 'testcases/newtestcase' => { form => $form };
 	 	}

 	 } # END of post

};


# get features based on selected product in newtestcase form
# not used, ony for testing; we needed ajax call which is next block
get '/feats' => sub {
    my @rows = schema('testcases')->resultset( 'Feature' )->
                search( {prod_id => 1}, { order_by => ['fname'] } )->all;

    #print Dumper { map { $_->id, $_->fname } @rows };          
    return to_json { map { $_->id, $_->fname } @rows };          
     #return @rows;
    #return [ map { $_->id, $_->fname } @rows ];
};

ajax '/get_features' => sub {
    #print Dumper body_parameters->get('productRlsID');
    my $prod_rls_id = body_parameters->get('productRlsID');
    my @rows = schema('testcases')->resultset( 'Feature' )->
                search( {prod_rls_id => $prod_rls_id}, { order_by => ['fname'] } )->all;

    #print Dumper { map { $_->id, $_->fname } @rows };          
    return to_json { map { $_->id, $_->fname } @rows };          
     #return @rows;
    #return [ map { $_->id, $_->fname } @rows ];
};

ajax '/get_rls' => sub {
    #print Dumper body_parameters->get('productID');
    my $productID = body_parameters->get('productID');
    #return $productID;
    my @rows = schema('testcases')->resultset( 'ProductRl' )->
                search( {prod_id => $productID}, { order_by => ['rls_num'] } )->all;

    #print Dumper { map { $_->id, $_->fname } @rows };          
    return to_json { map { $_->id, $_->rls_num } @rows };          
     #return @rows;
    #return [ map { $_->id, $_->fname } @rows ];
};

#tc_edit_button
get '/select_testcase/:action' => sub {
    #print Dumper route_parameters->get('action');
    my $action = route_parameters->get('action');
    template 'testcases/select_testcase' => {action => $action};
};

post '/update_testcase' => sub {
    my $testcase = schema('testcases')->resultset('Testcase')->find({id => body_parameters->get('enterTCID')})
        or return send_error('Not Found', 404);

    my $form = EditTestCaseForm->new;
    $form->process(item => $testcase, params => { params });

    template 'testcases/edit_testcase' => { form => $form };
};

post '/commit_updates/:id' => sub {
    #print Dumper route_parameters->get('id');
    my $testcase = schema('testcases')->resultset('Testcase')->find({id => route_parameters->get('id')})
        or return send_error('Not Found', 404);

    #print Dumper $testcase;

    my $form = EditTestCaseForm->new;
    $form->process(item => $testcase, params => { params });
    if ($form->validated) {
        return 'succesful';
    } else {
        return 'failed update';
    }
    #template 'testcases/updatedtestcase' => { form => $form };

};

post '/delete_testcase' => require_role Admin => sub {
    my $testcase = schema('testcases')->resultset('Testcase')->find({id => body_parameters->get('enterTCID')})
        or return send_error('Not Found', 404);

    $testcase->delete;

    return 'deleted'.body_parameters->get('enterTCID');
};

#get the edittestcase 




post '/edittestcase' => sub {
   #print Dumper body_parameters->get('enterTCID');

    #my $user = schema('users')->resultset('User')->find({username => lc param('session.username')});

    #my $testcase = schema('testcases')->resultset('Testcase')->new_result({});
    my $testcase = schema('testcases')->resultset('Testcase')->find({id => body_parameters->get('enterTCID')})
        or return send_error('Not Found', 404);

    my $form = EditTestCaseForm->new;
    $form->process(item => $testcase, params => { params });

    template 'testcases/edittestcase' => { form => $form };

};

#display updated test case
post '/updatedtestcase' => sub {
   #print Dumper body_parameters->get('enterTCID');

    #my $user = schema('users')->resultset('User')->find({username => lc param('session.username')});

    #my $testcase = schema('testcases')->resultset('Testcase')->new_result({});
    my $testcase = schema('testcases')->resultset('Testcase')->find({id => body_parameters->get('enterTCID')})
        or return send_error('Not Found', 404);

    my $form = EditTestCaseForm->new;
    $form->process(item => $testcase, params => { params });

    template 'testcases/updatedtestcase' => { form => $form };

};

any '/custom_logout' => sub {
    app->destroy_session;
    redirect '/';
};

=begin
#show 
get '/user/:id' => require_login sub {
    
    if(session('user_id') eq route_parameters->get('id')) {
        #my $user = schema('users')->resultset('User')->find(param('id'))
        my $user = schema('users')->resultset('User')->find(route_parameters->get('id'))
        or return send_error('Not Found', 404);
        template 'user/show' => { user => $user };
    } else {
        app->destroy_session;
        redirect '/';
    }
};


#update
any [ 'post', 'put' ] => '/user/:id' => require_login sub {
    my $user = schema('users')->resultset('User')->find(route_parameters->get('id'))
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
=cut
true;
