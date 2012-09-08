#!perl -T

use strict;
use warnings;
use Test::More;

eval {
    require Test::Pod;
    croak if ( $Test::Pod::VERSION < 1.22 );
    Test::Pod->import();
};

plan skip_all => "Test::Pod $min_tp required for testing POD" if $@;

all_pod_files_ok();
