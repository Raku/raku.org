unit class Community;

use Air::Functional :BASE;
use Air::Base;

sub community-page(&basepage, &shadow) is export {
    basepage #:REFRESH(10),
        main [
            shadow;
            div :align<center>, :style('position: relative; padding: 20px;'), [
                h1 'Community';
            ];
            dashboard [
                box :order(1), [
                    header h3 'Get in touch!';
                    main markdown q:to/END/;
                    _for help and friendly advice_

                    #### Discord

                    You are [invited](https://discord.gg/VzYpdQ6) to join us at the Raku Discord server, which is is also bridged to the IRC.

                    #### Internet Relay Chat (IRC)

                    Much discussion happens on [#raku, our IRC channel](/community/irc). This is the fastest way to get help.

                    #### Weekly

                    The [Rakudo Weeky News](https://rakudoweekly.blog/blog-feed/) is a great way to keep up to date on the latest core developments and module releases.

                    #### Stack Overflow

                    Many questions and answers are marked with the [Raku tag](https://stackoverflow.com/questions/tagged/raku).
                    END
                ];
                box :order(2), [
                    header h3 'Social & Blogs';
                    main markdown q:to/END/;
                    Social:

                     - Bluesky: [#rakulang](https://bsky.app/search?q=%23rakulang)
                     - Mastodon: [@rakulang](https://fosstodon.org/@rakulang)
                     - Reddit: [Join the r/rakulang subreddit](https://www.reddit.com/r/rakulang/)
                     - Facebook: [Join the Raku Group](https://www.facebook.com/groups/raku.perl6/)
                     - Twitter: [Follow @raku_news](https://twitter.com/raku_news)

                    Blogs:

                     - [Perl and Raku Weekly Challenge](https://perlweeklychallenge.org/)
                     - [Raku Blog Aggregator](https://planet.raku.org/)
                     - [Rakudo Weekly News](https://rakudoweekly.blog/) – Weekly changes in and around Rakudo
                     - [Raku Advent Calendar](https://rakuadventcalendar.wordpress.com/) - [help for contributors](https://github.com/Raku/advent/blob/master/CONTRIBUTING.md)
                    END
                ];
                box :order(3), [
                    header h3 'Artistic License';
                    main markdown q:to/END/;
                    The Raku core development teams release the specification, compilers, and documentation they develop under the [Artistic 2.0 license](https://spdx.org/licenses/Artistic-2.0.html).

                    This is the same license established by Perl and most CPAN modules and has been adopted by almost all OS distributions.

                    The broader development community is of course not required to use this license, but there is a [large uptake](https://raku.land/stats) among the community.
                    END
                ];
                box :order(4), [
                    header h3 'Raku Steering Council (RSC)';
                    main markdown q:to/END/;
                    The [Steering Council](https://github.com/Raku-Steering-Council/Papers) is a 7-person committee with many responsibilities, including maintaining the quality and stability of the Raku language, its compilers, and its ecosystem. Also to make contributing and learning Raku as accessible, inclusive, and sustainable as possible.

                    The [Problem Solving](https://github.com/Raku/problem-solving) repository contains issues that impact Raku which require consensus to resolve. The RSC is responsible for guiding any deadlocked issues to completion.
                    END
                ];
            ];
        ];
}



