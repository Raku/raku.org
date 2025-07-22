
#!/usr/bin/env raku
my $start = now;

use lib "../lib";

use Cro::HTTP::Log::File;
use Cro::HTTP::Router;
use Cro::HTTP::Server;

use Org;

my Cro::Service $http = Cro::HTTP::Server.new(
    http => <1.1>,
    host => "0.0.0.0",
    port => 3000,
    application => SITE.routes(),
    after => [
        Cro::HTTP::Log::File.new(logs => $*OUT, errors => $*ERR)
    ],
    );
$http.start;
my $elapsed = (now - $start).round(0.01);
say "Build time $elapsed sec";
say "Listening at http://0.0.0.0:3000";
react {
    whenever signal(SIGINT) {
        say "Shutting down...";
        $http.stop;
        done;
    }
}
