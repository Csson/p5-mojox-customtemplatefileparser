# NAME

MojoX::CustomTemplateFileParser - Parses a custom Mojo template file format

<div>
    <p><a style="float: left;" href="https://travis-ci.org/Csson/p5-mojox-customtemplatefileparser"><img src="https://travis-ci.org/Csson/p5-mojox-customtemplatefileparser.svg?branch=master">&nbsp;</a>
</div>

# SYNOPSIS

    use MojoX::CustomTemplateFileParser;

    my $content = MojoX::CustomTemplateFileParser->new(path => '/path/to/file.mojo')->parse->flatten;

    print $content;

# STATUS

Unstable.

# DESCRIPTION

MojoX::CustomTemplateFileParser parses files containing [Mojo::Templates](https://metacpan.org/pod/Mojo::Template) mixed with the expected rendering.

The parsing creates a data structure that also can be dumped into a string ready to be put in a [Test::More](https://metacpan.org/pod/Test::More) file.

Its purpose is to facilitate development of tag helpers.

## Options

**`path`**

The only argument given to the constructor is the path to the file that should be parsed.

## Methods

**`$self->parse`**

Parses the file given in `path`. After parsing the structure is available in `$self->structure`.

**`$self->flatten`**

Returns a string that is suitable to put in a [Test::More](https://metacpan.org/pod/Test::More) test file.

# Example

Given a file (`metacpan-1.mojo`) that looks like this:

    # Code here

    ==test==
    --t--
        %= link_to 'MetaCPAN', 'http://www.metacpan.org/'
    --t--
    --e--
        <a href="http://www.metacpan.org/">MetaCPAN</a>
    --e--

    ==test loop(first name)==
    --t--
        %= text_field username => placeholder => '[var]'
    --t--
    --e--
        <input name="username" placeholder="[var]" type="text" />
    --e--

    ==no test==
    --t--
        %= text_field username => placeholder => 'Not tested'
    --t--
    --e--
        <input name="username" placeholder="Not tested" type="text" />
    --e--

    ==test==
    --t--

    --t--

    --e--

    --e--

`loop(first name)` on the second test means there is one test generated where `[var]` is replaced with `first` and one where it is replaced with `name`.

`no test` on the third test means it is skipped.

Running `$self->parse` will fill `$self->structure` with:

    {
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
    }

And `$self->flatten` returns:

    # Code here

    #** test from test-1.mojo, line 4

    my $expected_test_1_1 = qq{     <a href="http://www.metacpan.org/">MetaCPAN</a> };

    get '/test_1_1' => 'test_1_1';

    $test->get_ok('/test_1_1')->status_is(200)->trimmed_content_is($expected_test_1_1, 'Matched trimmed content in test-1.mojo, line 4');

    #** test from test-1.mojo, line 12, loop: first

    my $expected_test_1_2 = qq{     <input name="username" placeholder="first" type="text" /> };

    get '/test_1_2' => 'test_1_2';

    $test->get_ok('/test_1_2')->status_is(200)->trimmed_content_is($expected_test_1_2, 'Matched trimmed content in test-1.mojo, line 12, loop: first');

    #** test from test-1.mojo, line 12, loop: name

    my $expected_test_1_2 = qq{     <input name="username" placeholder="name" type="text" /> };

    get '/test_1_2' => 'test_1_2';

    $test->get_ok('/test_1_2')->status_is(200)->trimmed_content_is($expected_test_1_2, 'Matched trimmed content in test-1.mojo, line 12, loop: name');

    done_testing();

    __DATA__

    @@ test_1_1.html.ep

        %= link_to 'MetaCPAN', 'http://www.metacpan.org/'

    @@ test_1_2.html.ep

        %= text_field username => placeholder => 'first'

    @@ test_1_2.html.ep

        %= text_field username => placeholder => 'name'

The easiest way to put this to use is with [Dist::Zilla::Plugin::Test::CreateFromMojoTemplates](https://metacpan.org/pod/Dist::Zilla::Plugin::Test::CreateFromMojoTemplates).

`$self->exemplify(1)` returns:

    %= link_to 'MetaCPAN', 'http://www.metacpan.org/'

    <a href="http://www.metacpan.org/">MetaCPAN</a>

The easiest way to put that to use is with [Dist::Zilla::Plugin::InsertExample::FromMojoTemplates](https://metacpan.org/pod/Dist::Zilla::Plugin::InsertExample::FromMojoTemplates).

# AUTHOR

Erik Carlsson <info@code301.com>

# COPYRIGHT

Copyright 2014- Erik Carlsson

# LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.
