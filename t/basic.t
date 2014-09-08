use strict;
use Test::More;
use Test::Deep;
use Data::Dump::Streamer 'Dumper';
use MojoX::CustomTemplateFileParser;

my $parser = MojoX::CustomTemplateFileParser->new(path => 'corpus/test-1.mojo');
my $found = $parser->parse->structure;

my $expected = {
    head_lines => ['', '# Code here', '', '' ],
    tests => [
        {
            lines_after => ['', ''],
            lines_before => [''],
            lines_between => [''],
            lines_expected => [ '    <a href="http://www.metacpan.org/">MetaCPAN</a>' ],
            lines_template => [ "    %= link_to 'MetaCPAN', 'http://www.metacpan.org/'" ],
            loop => [],
            loop_variable => undef,
            test_name => 'test_1_1',
            test_number => 1,
            test_start_line => 4,
        },
        {
            lines_after => ['', ''],
            lines_before => [''],
            lines_between => [''],
            lines_expected => [ '    <input name="username" placeholder="first" type="text" />' ],
            lines_template => [ "    %= text_field username => placeholder => 'first'" ],
            loop => [ 'first', 'name' ],
            loop_variable => 'first',
            test_name => 'test_1_2_first',
            test_number => 2,
            test_start_line => 12,
        },
        {
            lines_after => ['', ''],
            lines_before => [''],
            lines_between => [''],
            lines_expected => [ '    <input name="username" placeholder="name" type="text" />' ],
            lines_template => [ "    %= text_field username => placeholder => 'name'" ],
            loop => [ 'first', 'name' ],
            loop_variable => 'name',
            test_name => 'test_1_2_name',
            test_number => 2,
            test_start_line => 12,
        }
    ]
};

cmp_deeply($found, $expected, "Parsed correctly") || warn Dumper $found;

my $test_start = qr/==(?:(NO) )?TEST(?: loop\(([^)]+)\))?(?: EXAMPLE)?(?: (\d+))?==/i;
my @test = ('test', 'test 2', 'test example', 'test example 3', 'no test', 'no test example', 'test loop(thing thing)');
foreach my $testy (@test) {
   like("==$testy==", $test_start, $testy);
}


done_testing;
