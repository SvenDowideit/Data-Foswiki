#!perl -T

use strict;
use warnings;
use Test::More;
use Carp;
use Data::Dumper;
use Data::Foswiki;
use Data::Foswiki::Test;
use Data::Foswiki::Test2;
use Data::Foswiki::Test3;
use Data::Foswiki::Test3;
use Data::Foswiki::Test4;

eval {
    require Benchmark;
    Benchmark->import(qw( timethese cmpthese :hireswallclock));
};

plan skip_all => "Benchmark module needed for this test" if $@;

my @topicList = qw(
  /var/lib/foswiki/data/System/ReleaseNotes01x01.txt
  /var/lib/foswiki/data/System/NewUserTemplate.txt
  /var/lib/foswiki/data/System/WebHome.txt
  /var/lib/foswiki/data/System/WebPreferences.txt
  /var/lib/foswiki/data/System/DefaultPreferences.txt
  /var/lib/foswiki/data/Main/WebPreferences.txt
  /var/lib/foswiki/data/Main/SitePreferences.txt
  /var/lib/foswiki/data/System/FAQDownloadSources.txt
);
my $topicPath = $topicList[0];
plan skip_all => 'need a foswiki install at /var/lib/foswiki'
  unless ( -e $topicPath );

my @topics;
foreach my $file (@topicList) {
    open( my $fh, '<', $topicPath ) or die 'horribly';
    my @topic = <$fh>;
    close($fh);
    push( @topics, \@topic );
}

# ...or in two stages
my $results = timethese(
    -10,
    {
        'Foswiki::deserialise' => sub {
            foreach my $topic (@topics) {
                my $data = Data::Foswiki::deserialise(@$topic);
            }
        },
#        'Foswiki::Test::deserialise' =>
#          sub { 
#            foreach my $topic (@topics) {
#                my $data = Data::Foswiki::Test::deserialise(@$topic);
#            }
#        },
#        'Foswiki::Test2::deserialise' =>
#          sub { 
#            foreach my $topic (@topics) {
#                my $data = Data::Foswiki::Test2::deserialise(@$topic);
#            }
#        },
        'Foswiki::Test3::deserialise' =>
          sub { 
            foreach my $topic (@topics) {
                my $data = Data::Foswiki::Test3::deserialise(@$topic);
            }
        },
        'Foswiki::Test4::deserialise' =>
          sub { 
            foreach my $topic (@topics) {
                my $data = Data::Foswiki::Test4::deserialise(@$topic);
            }
        },
    },
    'none'
);
my $rows = cmpthese($results);
print STDERR Dumper($rows);

1;
