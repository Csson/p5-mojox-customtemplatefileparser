use strict;
use Test::More;
use MojoX::CustomTemplateFileParser;

my $parser = MojoX::CustomTemplateFileParser->new(path => 'corpus/test-1.mojo', plugins => ['ToTest']);

my $expected = '';

is $parser->to_html, $expected, 'Creates correct tests' || warn $found;


done_testing;
