package EditTestCaseForm;



use HTML::FormHandler::Moose;
extends 'HTML::FormHandler::Model::DBIC';
use Dancer2::Plugin::DBIC;
use DBIx::Class::ResultSetColumn;
use HTML::FormHandler::Field::Select;
use Data::Dumper;
# http://search.cpan.org/dist/Moose/lib/Moose/Manual/BestPractices.pod
# use namespace::autoclean instead of no declaration at the end of the package.
use namespace::autoclean;

# https://searchcode.com/codesearch/view/18749572/
#this name is form's name, in this case to create user, so named 'user'
# shd be avoiding this and use form_element_attr instead, TBD LATER
# + is used when the attribute is changed like in this case setting defaule value
has '+name'        => (default => 'edittestcase');
has '+html_prefix' => (default => 1);

#has_field 'prod_rls_id'  => (type => 'Select', required => 1, noupdate => 1 );
#has_field 'id'  => (type => 'Integer', required => 1, noupdate => 1);
#has_field 'feat_id'  => (type => 'Integer', required => 1,noupdate => 1);
has_field 'authorname'  => (type => 'Text', required => 1,noupdate => 1);
has_field 'featurename'  => (type => 'Text', required => 1,noupdate => 1);
has_field 'title'  => (type => 'Text', required => 1, maxlength => 255);
has_field 'description'  => (type => 'Text', required => 1, maxlength => 255);
has_field 'setup'  => (type => 'Text', required => 1, maxlength => 255);
has_field 'exec_steps' => (type => 'Text', required => 1, maxlength => 255);
has_field 'expected_result'  => (type => 'Text', required => 1, maxlength => 255);
has_field 'automate' => (type => 'Integer', required => 1);
#has_field 'author_id' => (type => 'Integer', required => 1);
has_field 'script_path'  => (type => 'Text', required => 1, maxlength => 255);


=begin
sub default_featurename {
  my $self = shift;
  
  return unless $self->schema;
  #don't know why? search is not working here only find
  my $thisFeatureName = $self->schema->resultset('Feature')->find({'testcases.feat_id' => 8},{join =>'testcases'});
  return $thisFeatureName->get_column('fname');

  #working lines below
  #my $thisFeatureName = $self->schema->resultset('Feature')->find({'testcases.feat_id' => 8},{join =>'testcases'});
  #return $thisFeatureName->get_column('fname'); #returns fname IPV6Support which is id = 8
  #my $thisFeatureName = $self->schema->resultset('Feature')->find({id => 6});
  #return $thisFeatureName->get_column('fname');
  #my @rs = $self->schema->resultset('Feature')->search({ 'me.id' => '6'})->all;
  #print Dumper @rs;
      
}
=cut

=begin
sub options_featurename {
       return (
           1   => 'RoutingTable',
           2   => 'selftest',
           3   => 'IPV6Support',
       );
   }


sub options_prod_rls_id {
  my $self = shift;
  
  return unless $self->schema;
  my @rows =
         $self->schema->resultset( 'ProductRl' )->
            search( {}, { order_by => ['rls_num'] } )->all;
      return [ map { $_->id, $_->rls_num } @rows ];
}

#http://search.cpan.org/dist/HTML-FormHandler-0.40023/lib/HTML/FormHandler/Manual/Cookbook.pod
#search for options_country
sub options_feat_id {
  my $self = shift;
  return unless $self->schema;
  my @rows =
         $self->schema->resultset( 'Feature' )->
            search( {}, { order_by => ['fname'] } )->all;
      return [ map { $_->id, $_->fname } @rows ];
}

=cut


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


# If element id is "foo.bar" the jQuery selector would have to written as "$('#foo\\.bar')", 
# so do not use dot as separator!
# HTML::FormHandler::Manual::Rendering 
# http://search.cpan.org/dist/HTML-FormHandler-0.40054/lib/HTML/FormHandler/Manual/Rendering.pod

# build_id_method changes id attribute of each element 
# when 'custom_id' is called, (subroutine reference) it goes and changes each form element like 'firstname', 'lastname'
# 'id' attribute to 'user_firstname', 'user_lastname'; the 'name' attribute is retained as 'user.firstname', 'user.lastname'
# 'user' here is the form name set it in <has '+name' ...> line at the starting of this package file



# http://search.cpan.org/dist/Moose/lib/Moose/Manual/BestPractices.pod
__PACKAGE__->meta->make_immutable;

# unload with no declaration
# https://www.safaribooksonline.com/library/view/programming-perl-4th/9781449321451/ch11s02.html
# no HTML::FormHandler::Moose;

1;
