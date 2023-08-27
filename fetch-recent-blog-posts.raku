#!/usr/bin/env raku

use LibXML::Reader:ver<0.10.4>:auth<zef:dwarring>:api<0.10.0>;
use HTTP::Tiny:ver<0.2.5>:auth<zef:jjatria>;
use JSON::Fast:ver<0.19>:auth<cpan:TIMOTIMO>;

my $tx = HTTP::Tiny.new.get("https://planet.raku.org/atom.xml");

unless $tx<success> {  
    warn "ERROR $tx<status> ($tx<reason>)";
    exit;
}

my $xml-content = $tx<content>.decode;

my $globalReader = LibXML::Reader.new: string => $xml-content;

my $found-posts = 0;
my @posts-data = gather while $globalReader.nextElement('entry') && $found-posts < 7 {
    my $entryString = $globalReader.readOuterXml;
    
    my $entryReader = LibXML::Reader.new: string => $entryString;
    # Look for text/html links and use the first without it if we don't find any
    my $link-href;
    while $entryReader.nextElement('link') {

        next if $entryReader.getAttribute('rel') andthen $_ eq 'replies';
        if $entryReader.getAttribute('type') andthen $_ eq 'text/html' {
            $link-href = $entryReader.getAttribute('href');
            last;
        }
        $_ = $entryReader.getAttribute('href') without $link-href;
    }
    # Hackish fix to get rid of comment entries from medium.com.
    # Only articles appear to have `category` elements, so if we detect
    # an entry from medium.com, ensure it also has `category` element
    next if $link-href.starts-with('https://medium\.com') && !LibXML::Reader.new(string => $entryString).nextElement('category');

    my $title = LibXML::Reader.new(string => $entryString).&{ .nextElement('title') && .readInnerXml };

    $found-posts++;
    take { :$title, link => $link-href }; # TODO these used to be "XML escaped" but what does that mean and is that even needed?

};

'online/recent-blog-posts.json'.IO.spurt: to-json @posts-data;
say 'Successfully wrote new blog posts';
