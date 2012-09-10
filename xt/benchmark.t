#!perl -T

use strict;
use warnings;
use Test::More;
use Carp;
use Data::Dumper;
use Data::Foswiki;
use Data::Foswiki::Test;

eval {
    require Benchmark;
    Benchmark->import( qw( timethese cmpthese :hireswallclock) );
};

plan skip_all => "Benchmark module needed for this test" if $@;

my @topicList = qw(
                    /var/lib/foswiki/data/System/ReleaseNotes01x01.txt
                    /var/lib/foswiki/data/System/NewUserTemplate.txt
                    );
my $topicPath = $topicList[1];
plan skip_all => 'need a foswiki install at /var/lib/foswiki' unless (-e $topicPath);

open(my $fh, '<', $topicPath) or die 'horribly';
my @topic = <$fh>;
close($fh);
# ...or in two stages
my $results = timethese(-2, 
    {
        'Foswiki::deserialise' => sub {my $data = Data::Foswiki::deserialise(@topic) },
        'Foswiki::Test::deserialise' => sub { my $data = Data::Foswiki::Test::deserialise(@topic) },
    },
    'none'
);
my $rows = cmpthese( $results ) ;
print STDERR Dumper($rows);

1;