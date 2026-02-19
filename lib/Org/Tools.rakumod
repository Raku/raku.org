unit class Tools;

use Air::Functional :BASE;
use Air::Base;

sub tools-page(&basepage, &shadow) is export {
    basepage #:REFRESH(10),
        main [
            shadow;
            div :align<center>, :style('position: relative; padding: 20px;'), [
                h1 'Tools';
            ];
            dashboard [
                panel :order(1), [
                    header h3 'Environments';
                    main markdown q:to/END/;

                    ### Language Servers

                    Editor-agnostic tools for syntax highlighting, autocompletion, etc. Consider using a Language Server over a syntax-highlighting extension for a richer development experience.

                     - [Raku Navigator](https://github.com/bscan/RakuNavigator) Raku language support for VS Code, Emacs, neovim and others.

                    ### Editor Plugins

                    Editor-specific tools, mostly syntax highlighters.

                    #### JetBrains IntelliJ

                     - [Raku IntelliJ Plugin](https://github.com/ab5tract/raku-intellij-plugin) for use with IntelliJ [IDEs](https://www.jetbrains.com/idea/download) (scroll down for the Community Edition).

                    #### Visual Studio Code

                     - [Raku Navigator](https://github.com/bscan/RakuNavigator) LSP language server.

                    #### Vim

                     - [Raku syntax highlighting](https://github.com/Raku/vim-raku)

                    #### Emacs

                     - [raku-mode](https://github.com/Raku/raku-mode), an Emacs major mode for Raku which provides syntax highlighting (and more)
                     - [Spacemacs](https://github.com/syl20bnr/spacemacs): Emacs wrapper with vim key-bindings and extra stuff

                    #### Nano

                     - [Raku syntax highlighting](https://github.com/hankache/raku.nanorc)

                    #### Geany

                     - [Geany](https://www.geany.org) is a popular flyweight Open Source IDE - now supports Raku.

                    END
                ];
                panel :order(2), [
                    header h3 'Interact & Download';
                    main markdown q:to/END/;

                    #### Sandboxes

                     - [Raku track on exercism.io](https://exercism.io/tracks/raku)
                     - [Online Raku compiler (most up to date)](https://repl.it/languages/raku)
                     - [Online Raku REPL (glot.io)](https://glot.io/new/raku)
                     - [Online Raku REPL (tio.run)](https://tio.run/#perl6)
                     - [Online Rakudoc editor](https://pod6.in/)

                    #### Notebooks

                     - [Jupyter Chatbook](https://raku.land/zef:antononcube/Jupyter::Chatbook)
                     - [Jupyter Kernel](https://raku.land/zef:bduggan/Jupyter::Kernel)
                     - [Jupyter Binder](https://github.com/rcmlz/raku-binder-env)

                    #### Cheatsheet

                     - [Cheatsheet](https://raw.githubusercontent.com/Raku/mu/master/docs/Perl6/Cheatsheet/cheatsheet.txt)

                    #### Latest Releases

                    Check out the latest release versions at [Rakudo News](https://rakudo.org/news).

                    #### Download Options

                    Visit the [install](/nav/1/install) page for the most convenient installation option for Linux, macOS, Windows and Docker.

                    Other download, build and installation options are available at [Rakudo Downloads](https://rakudo.org/downloads).
                    END
                ];
            ];
        ];
}



