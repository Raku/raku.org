#!/home/modules.perl6.org/perl5/perlbrew/perls/perl-5.22.0/bin/perl

use lib qw{
    /home/modules.perl6.org/perl5/perlbrew/perls/perl-5.22.0/lib/site_perl/5.22.0/x86_64-linux
    /home/modules.perl6.org/perl5/perlbrew/perls/perl-5.22.0/lib/site_perl/5.22.0
    /home/modules.perl6.org/perl5/perlbrew/perls/perl-5.22.0/lib/5.22.0/x86_64-linux
    /home/modules.perl6.org/perl5/perlbrew/perls/perl-5.22.0/lib/5.22.0
};

use Mojo::UserAgent;
use Mojo::JSON qw/encode_json/;
use Mojo::Util qw/spurt  xml_escape/;

my $tx = Mojo::UserAgent->new->get("http://pl6anet.org/atom.xml");

unless ( $tx->success ) {
    my $err   = $tx->error;
    warn $err->{code} ? "ERROR: $err->{code} response: $err->{message}"
                              : "Connection error: $err->{message}";
    exit;
}

my $j = $tx->res->dom->find("entry")->slice(0..6)
->map(sub{
        # Look for text/html links and use the first without it if we don't find any
        my $link = $_->at('link[type="text/html"]:not([rel="replies"])')
            // $_->at('link:not([rel="replies"])');
          +{
            title => xml_escape($_->at("title")->all_text),
            link  => xml_escape($link->{href}),
          }
    })->to_array;

spurt encode_json($j) => 'online/recent-blog-posts.json';
print "Successfully wrote new blog posts\n";

exit;
