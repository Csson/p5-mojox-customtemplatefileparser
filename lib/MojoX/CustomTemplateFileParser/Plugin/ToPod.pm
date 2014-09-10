package MojoX::CustomTemplateFileParser::Plugin::ToPod;

use strict;
use warnings;
use 5.10.1;
our $VERSION = '0.08';

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
        push @out => @{ $test->{'lines_before'} }, "\n", @{ $test->{'lines_template'} }, "\n", @{ $test->{'lines_between'} }, "\n", @{ $test->{'lines_expected' } }, "\n", @{ $test->{'lines_after'} };
    }

    my $out = join "\n" => @out;
    $out =~ s{\n\n\n+}{\n\n}g;

    return $out;

}

1;
