#!/usr/bin/perl -T
use strict;
use warnings;

print "Content-Type: text/html; charset=UTF-8\r\n\r\n";

my $dir = '/var/www/perl6.org/online/snippets/';

opendir my $DIR, $dir
    or die "Cannot open dir '$dir': $!";

my @files = grep !/^\./, readdir $DIR;
closedir $DIR;
my $fn = @files[rand @files];

open my $file, '<:raw', "$dir$fn"
    or die "Cannot open '$dir$fn' for reading: $!";
binmode $fn;
print while <$fn>;
close $file;


# vim: ft=perl
