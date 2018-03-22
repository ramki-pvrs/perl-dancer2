package NewUserForm;
use HTML::FormHandler::Moose;
extends 'HTML::FormHandler::Model::DBIC';
# http://search.cpan.org/dist/Moose/lib/Moose/Manual/BestPractices.pod
# use namespace::autoclean instead of no declaration at the end of the package.
use namespace::autoclean;

# https://searchcode.com/codesearch/view/18749572/
#this name is form's name, in this case to create user, so named 'user'
# shd be avoiding this and use form_element_attr instead, TBD LATER
# + is used when the attribute is changed like in this case setting defaule value
has '+name'        => (default => 'user');
has '+html_prefix' => (default => 1);

has_field 'firstname'  => (type => 'Text', required => 1, maxlength => 255);
has_field 'lastname'  => (type => 'Text', required => 1, maxlength => 255);
has_field 'username'  => (type => 'Text', required => 1, apply => [ { transform => sub { lc $_[0] } } ], maxlength => 40);
has_field 'email' => (type => 'Email', required => 1, apply => [ { transform => sub { lc $_[0] } } ]);
has_field 'mobilenumber'  => (type => 'Text', required => 1, maxlength => 255);
has_field 'password' => (type => 'Password', required => 1, minlength => 8, noupdate => 1);
has_field 'password_confirmation' => (type => 'PasswordConf', required => 1, noupdate => 1);

# update_model in 
# http://search.cpan.org/~gshank/HTML-FormHandler-Model-DBIC-0.29/lib/HTML/FormHandler/TraitFor/Model/DBIC.pm
# http://stackoverflow.com/questions/11150393/dbixclass-modify-column-data-before-update-or-insert
# column accessor overloading
# https://metacpan.org/pod/DBIx::Class::Manual::Cookbook#Wrapping-overloading-a-column-accessor

# item database row object
# http://search.cpan.org/~gshank/HTML-FormHandler-0.40067/lib/HTML/FormHandler.pm#html_prefix
# http://search.cpan.org/~gshank/HTML-FormHandler-0.40056/lib/HTML/FormHandler/Field.pm
# prevents entered value being displayed on the form

# read this http://search.cpan.org/dist/HTML-FormHandler-0.40023/lib/HTML/FormHandler/Manual/Cookbook.pod
# for update_model
before 'update_model' => sub {
    my $self = shift;
    $self->item->password($self->field('password')->value);
};

# If element id is "foo.bar" the jQuery selector would have to written as "$('#foo\\.bar')", 
# so do not use dot as separator!
# HTML::FormHandler::Manual::Rendering 
# http://search.cpan.org/dist/HTML-FormHandler-0.40054/lib/HTML/FormHandler/Manual/Rendering.pod

# build_id_method changes id attribute of each element 
# when 'custom_id' is called, (subroutine reference) it goes and changes each form element like 'firstname', 'lastname'
# 'id' attribute to 'user_firstname', 'user_lastname'; the 'name' attribute is retained as 'user.firstname', 'user.lastname'
# 'user' here is the form name set it in <has '+name' ...> line at the starting of this package file
sub build_update_subfields {
    { all => { build_id_method => \&custom_id } }
}

sub custom_id {
    my $self = shift;
    #ternary if condition; CONDITION ? EVALUATE_IF_CONDITION_WAS_TRUE : EVALUATE_IF_CONDITION_WAS_FALSE
    my $prefix = ($self->form && $self->form->html_prefix) ? $self->form->name . '.' : '';
    my $full_name = $prefix . $self->full_name;
    # globally change . to _ in $full_name (do it and assign it back is represented by =~)
    $full_name =~ s/\./_/g;
    return $full_name;
}

# http://search.cpan.org/dist/Moose/lib/Moose/Manual/BestPractices.pod
__PACKAGE__->meta->make_immutable;

# unload with no declaration
# https://www.safaribooksonline.com/library/view/programming-perl-4th/9781449321451/ch11s02.html
# no HTML::FormHandler::Moose;

1;
