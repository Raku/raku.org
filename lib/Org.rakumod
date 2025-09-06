unit class Org;

use Air::Functional :BASE;
use Air::Base;
use Air::Plugin::Hilite;

use Org::Home;
use Org::Community;
use Org::Install;
use Org::Learn;
use Org::Tools;

my @tools = [Analytics.new: :provider(Umami), :key<FIXME>,];  # fixme

my &basepage = &page.assuming(
    title       => 'Raku®',
    description => 'The Raku® programming language.',
    footer      =>  footer [
        hr;
        p safe Q|
            Hypered with <a href="https://htmx.org" target="_blank">htmx</a>.
            Aloft on <a href="https://harcstack.org" target="_blank"><b>&Aring;ir</b></a>.
            Constructed in <a href="https://cro.raku.org" target="_blank">cro</a>.
            Written in <a href="https://raku.org" target="_blank">raku</a>.
            &nbsp;&amp;&nbsp;
            Styled by <a href="https://picocss.com" target="_blank">picocss</a>.
        |;
        p safe 'The Raku® Programming Language';
    ],
    );

my &shadow = &background.assuming
    :url<https://upload.wikimedia.org/wikipedia/commons/f/fd/Butterfly_bottom_PSF_transparent.gif>;


my Page $home      = home-page      &basepage, &shadow;
my Page $community = community-page &basepage, &shadow;
my Page $install   = install-page   &basepage, &shadow;
my Page $learn     = learn-page     &basepage, &shadow;
my Page $tools     = tools-page     &basepage, &shadow;

my Nav $nav =
    nav
        logo => (
            span a :href</>, :target<_self>, :style("display: flex; align-items: center; gap: 0.5rem; text-decoration: none;"),
            [
                img :src</img/camelia-logo.png>, :width<60px>,
                :title('Hi, my name is Camelia. I\'m the spokesbug for the Raku Programming Language. Raku has been developed by a team of dedicated and enthusiastic open source volunteers, and continues to be developed. You can help too. The only requirement is that you know how to be nice to all kinds of people (and butterflies).');
                p :style("margin:0"),"Raku®";
            ]
        ),
        :widgets[lightdark],
        [
            community => $community,
            learn     => $learn,
            tools     => $tools,
            docs      => (external :href<https://docs.raku.org>),
            modules   => (external :href<https://raku.land>),
            git       => (external :href<https://github.com/rakudo/rakudo>),
            install   => $install,
        ];


my Page @pages = [$home, $community, $learn, $install, $tools];
{ .nav = $nav } for @pages;

sub SITE is export {
    site
        :@tools,
        :register[Air::Plugin::Hilite.new, Tabs.new, Home::Buttabs.new, Background.new,
              Dashboard.new, Box.new],
        :theme-color<pink>,
        :bold-color<springgreen>,
        :@pages,
}



=begin pod

=head1 AUTHOR

librasteve <librasteve@furnival.net>

=head1 COPYRIGHT AND LICENSE

Copyright 2025 librasteve

This library is free software; you can redistribute it and/or modify it under the Artistic License 2.0.

=end pod
