unit class Source;

use Air::Functional :BASE;
use Air::Base;

sub source-page(&basepage, $shadow) is export {
    basepage :stub<source>, #:REFRESH(10),
        main [
            $shadow;
            div :align<center>, :style('position: relative; padding: 20px;'), [
                h1 'Source';
            ];
            dashboard [
                panel :order(1), [
                    header h3 'Engines';
                    main markdown q:to/END/;

                    #### Rakudo

                     - [rakudo/rakudo](https://github.com/rakudo/rakudo): the reference implementation, written in NQP and Raku
                     - [MoarVM/MoarVM](https://github.com/MoarVM/MoarVM): the virtual machine Rakudo runs on, with adaptive optimization and a JIT
                     - [Raku/nqp](https://github.com/Raku/nqp): NQP, the language and toolkit Rakudo's compiler is written in

                    #### Raku++

                     - [ash/rakupp](https://github.com/ash/rakupp): an independent interpreter, native compiler and toolchain, written in C++

                    #### mutsu

                     - [tokuhirom/mutsu](https://github.com/tokuhirom/mutsu): an independent interpreter with a bytecode VM, written in Rust

                    END
                ];
                panel :order(2), [
                    header h3 'The Language';
                    main markdown q:to/END/;

                     - [Raku/roast](https://github.com/Raku/roast): Roast, the official test suite; every engine is measured against it
                     - [Raku/doc](https://github.com/Raku/doc): the documentation behind [docs.raku.org](https://docs.raku.org)
                     - [Raku/doc-website](https://github.com/Raku/doc-website): the framework that builds docs.raku.org
                     - [Raku/problem-solving](https://github.com/Raku/problem-solving): where questions about the language and the community are raised and decided

                    END
                ];
                panel :order(3), [
                    header h3 'Modules & Distributions';
                    main markdown q:to/END/;

                     - [ugexe/zef](https://github.com/ugexe/zef): zef, the module manager
                     - [Raku/REA](https://github.com/Raku/REA): the Raku Ecosystem Archive, which keeps every module release
                     - [rakudo/star](https://github.com/rakudo/star): Rakudo Star, Rakudo bundled with zef and a set of modules
                     - [Raku/App-Rakubrew](https://github.com/Raku/App-Rakubrew): rakubrew, which installs Rakudo versions and switches between them

                    END
                ];
                panel :order(4), [
                    header h3 'Websites';
                    main markdown q:to/END/;

                     - [Raku/raku.org](https://github.com/Raku/raku.org): this site
                     - [rakudo/rakudo.org](https://github.com/rakudo/rakudo.org): [rakudo.org](https://rakudo.org)
                     - [ash/raku.online](https://github.com/ash/raku.online): [raku.online](https://raku.online), the Raku++ site and playground
                     - [tokuhirom/mutsu, site/](https://github.com/tokuhirom/mutsu/tree/main/site): the [mutsu site](https://tokuhirom.github.io/mutsu/) and playground

                    END
                ];
            ];
        ];
}
