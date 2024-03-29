package MojoX::CustomTemplateFileParser::Plugin::To::Pod;

use strict;
use warnings;
use 5.10.1;

# VERSION
# ABSTRACT: Create pod

use Moose::Role;

sub to_pod {
    my $self = shift;
    my $test_index = shift;
    my $want_all_examples = shift || 0;

    my $tests_at_index = $self->test_index->{ $test_index };
    my @out = ();

    TEST:
    foreach my $test (@{ $tests_at_index }) {
        next TEST if $want_all_examples && !$test->{'is_example'};

        if(scalar @{ $test->{'lines_before'} }) {
            push @out => "\n", '=begin html', "\n",
                      '<p>', @{ $test->{'lines_before'} }, '</p>',
                      "\n", '=end html',
                      "\n";
        }

        push @out => @{ $test->{'lines_template'} }, "\n";
        if(scalar @{ $test->{'lines_between'} }) {
            push @out => '=begin html', "\n",
                      '<p>',@{ $test->{'lines_between'} }, '</p>',
                      "\n", '=end html',
                      "\n";
        }
        push @out => @{ $test->{'lines_expected' } }, "\n";
        if(scalar @{ $test->{'lines_after'} }) {
            push @out => '=begin html', "\n",
                      '<p>',@{ $test->{'lines_after'} }, '</p>',
                      "\n", '=end html', "\n";
        }
    }

    my $out = join "\n" => @out;
    $out =~ s{\n\n\n+}{\n\n}g;
    $out =~ s{\n+=begin html\n+}{\n\n=begin html\n\n}g;
    $out =~ s{\n+=end html\n+}{\n\n=end html\n\n}g;

    return $out;

}

1;

__END__

=pod

=head1 SYNOPSIS

  use MojoX::CustomTemplateFileParser;

  my $parser = MojoX::CustomTemplateFileParser->new(path => '/path/to/file.mojo', output => ['Pod']);

  print $parser->to_pod;

=head1 DESCRIPTION

MojoX::CustomTemplateFileParser::Plugin::To::Pod is an output plugin to L<MojoX::CustomTemplateFileParser>.

=head2 to_pod()

This method is added to L<MojoX::CustomTemplateFileParser> objects created with C<output =E<gt> ['Pod']>.

=head1 SEE ALSO

=for :list

* L<Dist::Zilla::Plugin::InsertExample::FromMojoTemplates>
* L<MojoX::CustomTemplateFileParser::Plugin::To::Pod>
* L<MojoX::CustomTemplateFileParser::Plugin::To::Test>

=cut
