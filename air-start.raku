#!/usr/bin/env raku
use Org;

sub MAIN( :$host, :$port, :$scss, :$watch ) {
    $Org::site.start:
          :$host, :$port, :$scss, :$watch;
}