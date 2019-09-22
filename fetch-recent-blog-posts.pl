#!/usr/bin/env perl

use Mojo::UserAgent;
use Mojo::JSON qw/encode_json/;
use Mojo::File qw/path/;
use Mojo::Util qw/xml_escape/;

my $tx = Mojo::UserAgent->new->get("https://pl6anet.org/atom.xml");

unless ( $tx->success ) {
    my $err   = $tx->error;
    warn $err->{code} ? "ERROR: $err->{code} response: $err->{message}"
                              : "Connection error: $err->{message}";
    exit;
}

my $j = $tx->res->dom->find("entry")->grep(sub {
    # Hackish fix to get rid of comment entries from medium.com.
    # Only articles appear to have `category` elements, so if we detect
    # an entry from medium.com, ensure it also has `category` element
    $_->at('link')->{href} =~ m{^https://medium\.com}
        ? $_->find('category')->each
        : 1
    })->slice(0..6)->map(sub{
        # Look for text/html links and use the first without it if we don't find any
        my $link = $_->at('link[type="text/html"]:not([rel="replies"])')
            // $_->at('link:not([rel="replies"])');
          +{
            title => xml_escape($_->at("title")->all_text),
            link  => xml_escape($link->{href}),
          }
    })->to_array;

path('online/recent-blog-posts.json')->spurt(encode_json($j));
print "Successfully wrote new blog posts\n";

exit;
