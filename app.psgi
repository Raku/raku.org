use Plack::App::Directory;
my $app = Plack::App::Directory->new({ root => "./online/" })->to_app;

print 'x' x 20 . "\n";
print "https://perl6.org/\n";
print 'x' x 20 . "\n";

return $app;
