unit class Learn;

use Air::Functional :BASE;
use Air::Base;

sub learn-page(&basepage, $shadow) is export {
    basepage :stub<learn>, #:REFRESH(10),
        main [
            $shadow;
            div :align<center>, :style('position: relative; padding: 20px;'), [
                h1 'Learn Raku';
            ];
            dashboard [
                panel :order(1), [
                    header h3 'Getting Started';
                    main markdown q:to/END/;
                    #### Raku Guide

                     - [Raku Guide](https://raku.guide/) is a quick overview to get you up and running.

                    #### Raku Docs

                     - [Raku Official Documentation](https://docs.raku.org/) has in-depth Tutorials and References.

                    #### Online Learning

                     - [A Tour of Raku](https://learn.raku.online/tour/), interactive lessons you can run in the browser
                     - [Raku as a Foreign Language](https://learn.raku.online/foreign-language/), learn Raku by comparing it with the language you already know
                     - [The Complete Course of the Raku Programming Language](https://course.raku.org/)
                     - Learn Raku app for [iOS](https://apps.apple.com/app/learn-raku/id6788222934) and [Android](https://play.google.com/store/apps/details?id=online.deepsoft.learnraku), the Course and a playground on your phone
                     - [mutsu's hands-on Raku tutorial](https://tokuhirom.github.io/mutsu/tutorial.html)
                     - [Learn Raku in Y minutes](https://learnxinyminutes.com/docs/raku/)
                     - [Learn Pod in Y minutes](https://learnxinyminutes.com/docs/perl6-pod/)

                    #### Try in the Browser

                     - [Raku++ playground](https://raku.online/play/), a Raku playground that runs in the browser
                     - [Raku Playground](https://fco.github.io/Raku-Playground/), with a choice of runtimes
                     - [mutsu playground](https://tokuhirom.github.io/mutsu/playground.html)
                     - [glot.io](https://glot.io/new/raku)

                    #### Practice

                     - [Raku Drills](https://learn.raku.online/drills/), graded questions from beginner to advanced
                     - [Raku Koans](https://hankache.github.io/raku-koans/), fix the tests one by one
                     - [Raku on Exercism](https://exercism.org/tracks/raku)
                     - [Raku on Codewars](https://www.codewars.com/kata/search/raku)
                     - [The Weekly Challenge](https://theweeklychallenge.org/), two new tasks every week

                    #### Advent Calendars

                     - [Raku Advent Calendar](https://raku-advent.blog/): [2019](https://raku-advent.blog/2019/) [2020](https://raku-advent.blog/2020/) [2021](https://raku-advent.blog/2021/) [2022](https://raku-advent.blog/2022/) [2023](https://raku-advent.blog/2023/) [2024](https://raku-advent.blog/2024/) [2025](https://raku-advent.blog/2025/)
                     - [Perl 6 Advent Calendar](https://perl6advent.wordpress.com/): [2009](https://perl6advent.wordpress.com/2009/) [2010](https://perl6advent.wordpress.com/2010/) [2011](https://perl6advent.wordpress.com/2011/) [2012](https://perl6advent.wordpress.com/2012/) [2013](https://perl6advent.wordpress.com/2013/) [2014](https://perl6advent.wordpress.com/2014/) [2015](https://perl6advent.wordpress.com/2015/) [2016](https://perl6advent.wordpress.com/2016/) [2017](https://perl6advent.wordpress.com/2017/) [2018](https://perl6advent.wordpress.com/2018/)
                     - [Perl 6 One-Liner Advent Calendar](https://andrewshitov.com/2018/12/24/overview-of-the-perl-6-one-liner-advent-calendar-2018/) (2018)
                     - [Advent of Code 2020 in Raku](https://andrewshitov.com/category/advent-calendar-2020/)

                    #### Code Examples

                     - Raku is well represented on [Rosetta Code](https://rosettacode.org/wiki/Category:Raku), where you can see the Raku Programming Language (and many other languages) applied to numerous programming tasks.
                     - [Raku by Example](https://learn.raku.online/examples/), complete programs you can run in the browser
                    END
                ];
                panel :order(2), [
                    header h3 'Books';
                    main markdown q:to/END/;
                    Books about Raku, newest first:

                     - [Raku Fundamentals](https://link.springer.com/book/10.1007/978-1-4842-6109-5) by _Moritz Lenz_ (2020, print and ebook)
                     - [Raku Recipes: A Problem-Solution Approach](https://link.springer.com/book/10.1007/978-1-4842-6258-0) by _J.J. Merelo_ (2020, print and ebook)
                     - [Beginning Raku: A Two Day Course](https://arnesom.github.io/Beginning-v1.00.pdf) by _Arne Sommer_ (2019, free ebook)
                     - [Raku One-Liners](https://andrewshitov.com/raku-books/raku-one-liners) by _Andrew Shitov_ (2019, free ebook)
                     - [Using Raku: 100 Programming Challenges Solved with the Raku Programming Language](https://andrewshitov.com/raku-books/using-raku) by _Andrew Shitov_ (2019, free ebook)
                     - [Perl 6 Quick Syntax Reference: A Pocket Guide to the Language, the Core Modules, and the Community](https://link.springer.com/book/10.1007/978-1-4842-4956-7) by _J.J. Merelo_ (2019, print and ebook)
                     - [Learning Perl 6: Keeping the Easy, Hard, and Impossible Within Reach](https://www.oreilly.com/library/view/learning-perl-6/9781491977675/) by _brian d foy_ (2018, print and ebook)
                     - [Parsing with Perl6 Regexes and Grammars](https://link.springer.com/book/10.1007/978-1-4842-3228-6) by _Moritz Lenz_ (2017, print and ebook)
                     - [Perl 6 Deep Dive](https://www.packtpub.com/en-us/product/perl-6-deep-dive-9781787282049) by _Andrew Shitov_ (2017, print and ebook)
                     - [Think Raku: How to Think Like a Computer Scientist](http://greenteapress.com/wp/think-perl-6/) by _Laurent Rosenfeld_ with _Allen B. Downey_ (2017, print and free ebook)
                     - [Perl 6 at a Glance](https://andrewshitov.com/raku-books/perl-6-at-a-glance) by _Andrew Shitov_ (2017, print)
                     - [Learning to program with Perl6: First Steps](https://www.amazon.com/gp/product/B07221XCVL) by _J.J. Merelo_ (2017, ebook)
                     - [Metagenomics](https://kyclark.gitbooks.io/metagenomics/content/) by _Ken Youens-Clark_ (ebook)

                    See also [a helpful chart of Raku Books](https://perl6book.com/).
                    END
                ];
            ];
        ];
}
