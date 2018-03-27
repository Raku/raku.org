use 5.026;
use strict;
use warnings;
use Module::Build;

my $build = Module::Build->new(
    module_name        => 'Perl6Org',
    dist_abstract      => 'perl6.org website',
    dist_name          => 'perl6.org',
    dist_author        => 'Perl 6 Hackers',
    license            => 'perl',
    create_makefile_pl => 'passthrough',
    dist_version => '0.1',
    recursive_test_files => 1,
    requires => {
      'CSS::Minifier::XS'                => '0.09',
      'CSS::Sass'                        => '3.4.10',
      'IO::Socket::SSL'                  => '2.056',
      'JavaScript::Minifier::XS'         => '0.11',
      'Mojo::Base'                       => '0',
      'Mojo::Collection'                 => '0',
      'Mojo::File'                       => '0',
      'Mojo::Util'                       => '0',
      'Mojolicious'                      => '7.31',
      'Mojolicious::Lite'                => '0',
      'Mojolicious::Plugin::AssetPack'   => '1.42',
      'warnings'                         => '0',
      'strict'                           => '0',
    }
);
$build->create_build_script;