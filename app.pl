#!/usr/bin/env perl

use lib qw<lib>;
use 5.026;
use Mojolicious::Lite;
use Mojo::Util qw/xml_escape/;

plugin Config => { file => 'conf.conf' };

plugin AssetPack => { pipes => [qw/Sass  JavaScript  Combine/] };
app->asset->process('app.css' => qw{
    https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css

    sass/open-iconic-bootstrap.css
    sass/main.scss
});
app->asset->process('app.js' => qw{
    https://code.jquery.com/jquery-3.3.1.min.js
    https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js
    https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js

    js/platform.js
    js/main.js
});

### Routes
get '/' => 'home';

### Helpers
helper make_crumbs => sub {
    my ($self, @raw_crumbs) = @_;
    my @crumbs;
    my $current;
    for (grep !($_ % 2), 0..$#raw_crumbs) {
        $_ < $#raw_crumbs-1
            ? push(@crumbs, [$raw_crumbs[$_], $raw_crumbs[$_+1]])
            : ($current = $raw_crumbs[$_])
    }
    $current // die 'Missing "current" page in breadcrumbs helper';

    my $c = join "\n",
        '<nav aria-label="breadcrumb" class="breadcrumbs">'
        . '<ol class="breadcrumb bg-dark">',
        (map '<li class="breadcrumb-item"><a href="'
            . xml_escape($self->url_for($_->[0]))
            . '">' . xml_escape($_->[1]) . '</a></li>', @crumbs),

        '<li class="breadcrumb-item active" aria-current="page">'
        . xml_escape($current) . '</li></ol></nav>';
    $self->stash(crumbs => $c);
};
helper p6 => sub { '<span class="nb">Perl 6</span>' };
helper nav_active => sub {
    my ($self, $nav) = @_;
    $self->url_for('current')->to_abs eq $self->url_for($nav)->to_abs
        ? ' active' : ''
};
helper items_in => sub {
    my ($self, $what ) = @_;
    return unless defined $what;
    $what = $self->stash($what) // [] unless ref $what;
    return @$what;
};
helper code_block => sub {
    my ($self, $code) = @_;
    '<pre class="code-block"><code>' . xml_escape($code) . '</code></pre>'
};

####
app->start;
