unit class Learn;

use Air::Functional :BASE;
use Air::Base;

sub learn-page(&basepage, &shadow) is export {
    basepage #:REFRESH(10),
        main [
            shadow;
            div :align<center>, :style('position: relative; padding: 20px;'), [
                h1 'Learn';
            ];
            dashboard [
                box :order(1), [
                    header h3 'Getting Started';
                    main markdown q:to/END/;
                    #### Raku Guide

                     - [Raku Guide](https://raku.guide/) is a quick overview to get you up and running.

                    #### Raku Docs

                     - [Raku Official Documentation](https://docs.raku.org/) has in-depth Tutorials and References.

                    #### Online Learning

                     - [Raku Essentials](https://course.raku.org/essentials/)
                     - [Learn Raku in Y minutes](https://learnxinyminutes.com/docs/raku/)
                     - [Learn Pod in Y minutes](https://learnxinyminutes.com/docs/perl6-pod/)
                     - [Raku on Exercism](https://exercism.org/tracks/raku)

                    #### Code Examples

                    Raku is well represented on [Rosetta Code](https://rosettacode.org/wiki/Category:Raku), where you can see the Raku Programming Language (and many other languages) applied to numerous programming tasks.
                    END
                ];
                box :order(2), [
                    header h3 'Books';
                    main markdown q:to/END/;
                    See [a helpful chart of Raku Books](https://perl6book.com/) or pick from the list below:

                     - [Raku Fundamentals](https://www.apress.com/gp/book/9781484261088), by Moritz Lenz *(published, print and ebook)*
                     - [Perl6 at a Glance](https://deeptext.media/perl6-at-a-glance/), by Andrew Shitov *(published, print)*
                     - [Think Raku: How to Think Like a Computer Scientist](http://greenteapress.com/wp/think-perl-6/), by Laurent Rosenfeld *(published, print)*
                     - [Parsing with Perl6 Regexes and Grammars](https://smile.amazon.com/dp/1484232275/), by Moritz Lenz *(published, print and ebook)*
                     - [Metagenomics](https://kyclark.gitbooks.io/metagenomics/content/), by Ken Youens-Clark *(published, ebook)*
                     - [Learning to program with Perl6: First Steps](https://www.amazon.com/gp/product/B07221XCVL), by JJ Merelo *(published, ebook)*
                    END
                ];
            ];
        ];
}



