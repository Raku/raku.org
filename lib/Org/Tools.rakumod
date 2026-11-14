unit class Tools;

use Air::Functional :BASE;
use Air::Base;

sub tools-page(&basepage, $shadow) is export {
    basepage :stub<tools>, #:REFRESH(10),
        main [
            $shadow;
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
                     - [Raku++ language server](https://raku.online/editors/#language-server): `rakupp --lsp` underlines errors as you type, with hover, completion and go-to-definition.

                    ### Editor Plugins

                    Editor-specific tools, mostly syntax highlighters.

                    #### JetBrains IntelliJ

                     - [Raku IntelliJ Plugin](https://github.com/ab5tract/raku-intellij-plugin) for use with IntelliJ [IDEs](https://www.jetbrains.com/idea/download).

                    #### Visual Studio Code

                     - [Raku Navigator](https://github.com/bscan/RakuNavigator) LSP language server.
                     - [Raku++ extension](https://marketplace.visualstudio.com/items?itemName=DeepSoft.rakupp): highlighting and as-you-type checks through the Raku++ language server.

                    #### Vim

                     - [Raku syntax highlighting](https://github.com/Raku/vim-raku)

                    #### Emacs

                     - [raku-mode](https://github.com/Raku/raku-mode), an Emacs major mode for Raku which provides syntax highlighting (and more)
                     - [Spacemacs](https://github.com/syl20bnr/spacemacs), an Emacs wrapper with vim key-bindings and extra stuff
                     - [Raku++ for Emacs](https://raku.online/editors/#emacs): the Raku++ language server through eglot or lsp-mode, and a Raku REPL buffer

                    #### Nano

                     - [Raku syntax highlighting](https://github.com/hankache/raku.nanorc)

                    #### Geany

                     - [Geany](https://www.geany.org) is a popular flyweight Open Source IDE - now supports Raku.

                    ### Linting, Formatting and Highlighting

                     - [Raku++ linter](https://github.com/ash/rakupp/blob/main/docs/guide/LINT.md): `rakupp --lint` finds unused variables, unreachable code and similar mistakes without running the program.
                     - [Raku++ formatter](https://github.com/ash/rakupp/blob/main/docs/guide/FMT.md): `rakupp --fmt` reformats source code; `--check` and `--diff` suit CI.
                     - [Raku++ syntax highlighter](https://raku.online/#toolbox): `rakupp --highlight` turns Raku source into highlighted HTML, or terminal colours with `--ansi`; it can stand in for `pygmentize`.

                    ### AI Agents

                     - [Raku++ MCP server](https://raku.online/editors/#ai-agents): `rakupp --mcp` lets agents such as Claude Code run Raku and parse text with grammars.

                    END
                ];
                panel :order(2), [
                    header h3 'Interact & Download';
                    main markdown q:to/END/;

                    #### Sandboxes

                     - [Raku++ playground](https://raku.online/play/), in the browser with WebAssembly, with a live mode that reruns as you type
                     - [mutsu playground](https://tokuhirom.github.io/mutsu/playground.html), in the browser with WebAssembly
                     - [Raku track on exercism.org](https://exercism.org/tracks/raku)
                     - [Online Raku REPL (glot.io)](https://glot.io/new/raku)
                     - [Online Raku REPL (tio.run)](https://tio.run/#perl6)
                     - [Online Rakudoc editor using Podlite](https://pod6.in/)
                     - [Online RakuDoc v2 editor using Rakuast-RakuDoc-Render](https://raku.finanalyst.org/rakudoc_editor/)

                    #### Runnable Raku on Web Pages

                     - [Raku.js](https://raku.online/embed/js/): one script tag makes the code blocks on any page editable and runnable (Raku++ in WebAssembly)
                     - [Raku Snippets](https://raku.online/embed/wordpress/), the same for WordPress posts
                     - [mutsu-code](https://github.com/tokuhirom/mutsu/blob/main/docs/browser-embedding.md), mutsu's drop-in component for runnable examples

                    #### Notebooks

                     - [Jupyter Chatbook](https://raku.land/zef:antononcube/Jupyter::Chatbook)
                     - [Jupyter Kernel](https://raku.land/zef:bduggan/Jupyter::Kernel)
                     - [Jupyter Binder](https://github.com/rcmlz/raku-binder-env)
                     - [Raku++ Jupyter kernel](https://raku.online/editors/#jupyter): `rakupp --jupyter-install`, then pick Raku++ in JupyterLab, Notebook or VS Code
                     - [RakuppLink](https://resources.wolframcloud.com/PacletRepository/resources/AntonAntonov/RakuppLink/), a Wolfram paclet that runs Raku++ in Wolfram notebooks: install `AntonAntonov/RakuppLink` with `PacletInstall`, then call `RakuppEval`

                    #### Raku from Other Languages

                     - [Raku++ bindings](https://raku.online/bindings/) call Raku from Python and the Wolfram Language, with previews for JavaScript, Go, Rust and C++.

                    #### Cheatsheet

                     - [Cheatsheet](https://raw.githubusercontent.com/Raku/mu/master/docs/Perl6/Cheatsheet/cheatsheet.txt)

                    #### Latest Releases

                     - Rakudo: [Rakudo News](https://rakudo.org/news)
                     - Raku++: [releases](https://github.com/ash/rakupp/releases)
                     - mutsu: [releases](https://github.com/tokuhirom/mutsu/releases)

                    #### Download Options

                    Visit the [install](/install) page for the most convenient installation option for Linux, macOS, Windows and Docker.

                    Other download, build and installation options: [Rakudo Downloads](https://rakudo.org/downloads), the [Raku++ install guide](https://github.com/ash/rakupp/blob/main/docs/guide/INSTALL.md) and the [mutsu manual](https://tokuhirom.github.io/mutsu/manual.html).
                    END
                ];
            ];
        ];
}
