requires 'perl', '5.010_001';

requires 'Mojolicious', '5.00';
requires 'Path::Tiny', '0.050';
requires 'Storable', '2.24';

on test => sub {
    requires 'Test::More', '0.96';
    requires 'Test::Deep', '0.110';
    requires 'Data::Dumper', '2.130';
    requires 'MojoX::CustomTemplateFileParser', '0.04';
};


