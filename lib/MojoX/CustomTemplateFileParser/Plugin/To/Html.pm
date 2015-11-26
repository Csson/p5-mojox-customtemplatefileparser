package MojoX::CustomTemplateFileParser::Plugin::To::Html;

use strict;
use warnings;
use 5.10.1;

# VERSION
# ABSTRACT: Create html

use Moose::Role;

sub to_html {
    my $self = shift;

    my @out = ();
    my $tests = $self->structure->{'tests'};

    foreach my $test (@{ $tests }) {
        push @out => (qq{<div class="panel panel-default"><div class="panel-body">});
        if(scalar @{ $test->{'lines_before'} }) {
            push @out => @{ $test->{'lines_before'} };
        }
        push @out => ('<pre>', HTML::Entities::encode_entities(join("\n" => @{ $test->{'lines_template'} })), '</pre>');
        if(scalar @{ $test->{'lines_between'} }) {
            push @out => @{ $test->{'lines_between'} };
        }
        push @out => ('<pre>', HTML::Entities::encode_entities(join("\n" => @{ $test->{'lines_expected'} })), '</pre>');
        if(scalar @{ $test->{'lines_after'} }) {
            push @out => @{ $test->{'lines_after'} };
        }
        push @out => '<hr />', @{ $test->{'lines_expected'} };
        push @out => (qq{</div></div>});
    }

    return join '' => @out;
}

1;

=pod

=head1 SYNOPSIS

  use MojoX::CustomTemplateFileParser;

  my $parser = MojoX::CustomTemplateFileParser->new(path => '/path/to/file.mojo', output => ['Html']);

  print $parser->to_html;

=head1 DESCRIPTION

MojoX::CustomTemplateFileParser::Plugin::To::Html is an output plugin to L<MojoX::CustomTemplateFileParser>.

=head2 to_html()

This method is added to L<MojoX::CustomTemplateFileParser> objects created with C<output =E<gt> ['Html']>.

=head1 SEE ALSO

=for :list
* L<Dist::Zilla::Plugin::InsertExample::FromMojoTemplates>
* L<MojoX::CustomTemplateFileParser::Plugin::To::Pod>
* L<MojoX::CustomTemplateFileParser::Plugin::To::Test>

=cut
