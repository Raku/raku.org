#!/usr/bin/env raku
use Org;

sub MAIN( :$host, :$port, :$scss, :$watch ) {
    $Org::site.serve:
          :$host, :$port, :$scss, :$watch;
}