use strict;
use Test::More;
use MojoX::CustomTemplateFileParser;

my $parser = MojoX::CustomTemplateFileParser->new(path => 'corpus/test-1.mojo', output => ['Html']);

my $expected = q{};

is $parser->to_html, $expected, 'Creates correct tests';


done_testing;
