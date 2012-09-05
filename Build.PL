use 5.006;
use strict;
use warnings;
use Module::Build;

my $builder = Module::Build->new(
    module_name         => 'Data::Foswiki',
    license             => 'perl',
    dist_author         => q{Sven Dowideit <SvenDowideit@fosiki.com>},
    dist_version_from   => 'lib/Data/Foswiki.pm',
    build_requires => {
        'Test::More' => 0,
    },
    requires => {
        'perl' => 5.006,
    },
    add_to_cleanup      => [ 'Data-Foswiki-*' ],
    create_makefile_pl => 'traditional',
);

$builder->create_build_script();
