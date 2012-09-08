use strict;
use warnings;
use Test::More;

eval {
    require Test::Pod::Coverage;
    croak if ( $Test::Pod::Coverage::VERSION < 1.08 );
    Test::Pod::Coverage->import();
};

plan skip_all => "Test::Pod::Coverage $min_tpc required for testing POD coverage"
    if $@;

# Test::Pod::Coverage doesn't require a minimum Pod::Coverage version,
# but older versions don't recognize some common documentation styles
eval {
    require Pod::Coverage;
    croak if ( $Pod::Coverage::VERSION < 0.18 );
    Pod::Coverage->import();
};


plan skip_all => "Pod::Coverage $min_pc required for testing POD coverage"
    if $@;

all_pod_coverage_ok();
