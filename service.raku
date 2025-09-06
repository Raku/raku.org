
#!/usr/bin/env raku
my $start = now;

use lib "../lib";

use Cro::HTTP::Log::File;
use Cro::HTTP::Router;
use Cro::HTTP::Server;

use Org;

my $host = %*ENV<CRO_WEBSITE_HOST>;
my $port = %*ENV<CRO_WEBSITE_PORT>;

my Cro::Service $http = Cro::HTTP::Server.new(
    http => <1.1>,
    :$host,
    :$port,
    application => SITE.routes(),
    after => [
        Cro::HTTP::Log::File.new(logs => $*OUT, errors => $*ERR)
    ],
    );
$http.start;
my $elapsed = (now - $start).round(0.01);
say "Build time $elapsed sec";
say "Listening at http://$host:$port";
react {
    whenever signal(SIGINT) {
        say "Shutting down...";
        $http.stop;
        done;
    }
}
