package MojoX::CustomTemplateFileParser::Plugin::To::Test;

use strict;
use warnings;
use 5.10.1;
our $VERSION = '0.08';

use Moose::Role;

sub to_html {
    my $self = shift;

    my @out = ();
    my $tests = $self->structure->{'tests'};

    foreach my $test (@{ $tests }) {
        push @out => (qq{<div class="panel panel-default"><div class="panel-body">});
        push @out => (@{ $test->{'lines_before'} }) if scalar @{ $test->{'lines_before'} };
        push @out => ('<pre>', HTML::Entities::encode_entities(join("\n" => @{ $test->{'lines_template'} })), '</pre>');
        push @out => (@{ $test->{'lines_between'} }) if scalar @{ $test->{'lines_between'} };
        push @out => ('<pre>', HTML::Entities::encode_entities(join("\n" => @{ $test->{'lines_expected'} })), '</pre>');
        push @out => (@{ $test->{'lines_after'} }, "<hr />") if scalar @{ $test->{'lines_after'} };
        push @out => (@{ $test->{'lines_expected'} });
        push @out => (qq{</div></div>});
    }

    return join '' => @out;
}

1;
