# NAME

MojoX::CustomTemplateFileParser - Parses a custom Mojo template file format

<div>
    <p><a style="float: left;" href="https://travis-ci.org/Csson/p5-mojox-customtemplatefileparser"><img src="https://travis-ci.org/Csson/p5-mojox-customtemplatefileparser.svg?branch=master">&nbsp;</a>
</div>

# SYNOPSIS

    use MojoX::CustomTemplateFileParser;

    my $parser = MojoX::CustomTemplateFileParser->new(path => '/path/to/file.mojo', output => [qw/Html Pod Test]);

    print $parser->to_html;
    print $parser->to_pod;
    print $parser->to_test;

# STATUS

Unstable.

# DESCRIPTION

MojoX::CustomTemplateFileParser parses files containing [Mojo::Templates](https://metacpan.org/pod/Mojo::Template) mixed with the expected rendering.

The parsing creates a data structure that can be output in various formats using plugins.

Its purpose is to facilitate development of tag helpers.

## Options

**`path`**

The path to the file that should be parsed. Parsing occurs at object creation.

**`output`**

An array reference to plugins in the `::Plugin::To` namespace.

## Methods

No public methods. See plugins for output options.

# PLUGINS

Currently available plugins:

- [MojoX::CustomTemplateFileParser::To::Html](https://metacpan.org/pod/MojoX::CustomTemplateFileParser::To::Html)
- [MojoX::CustomTemplateFileParser::To::Pod](https://metacpan.org/pod/MojoX::CustomTemplateFileParser::To::Pod)
- [MojoX::CustomTemplateFileParser::To::Test](https://metacpan.org/pod/MojoX::CustomTemplateFileParser::To::Test)

# SEE ALSO

- [Dist::Zilla::Plugin::Test::CreateFromMojoTemplates](https://metacpan.org/pod/Dist::Zilla::Plugin::Test::CreateFromMojoTemplates)
- [Dist::Zilla::Plugin::InsertExample::FromMojoTemplates](https://metacpan.org/pod/Dist::Zilla::Plugin::InsertExample::FromMojoTemplates)

# AUTHOR

Erik Carlsson <info@code301.com>

# COPYRIGHT

Copyright 2014- Erik Carlsson

# LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.
