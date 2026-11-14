unit class Install;

use Air::Functional :BASE;
use Air::Base;

#| Engine switch inside each OS tab. All three engines' instructions are in the
#| page and the switch only shows one, so the engine picked last can be shown
#| again at once when another OS tab loads.
class EngineTabs does Tabs {
    my %label = rakudo => 'Rakudo', rakupp => 'Raku++', mutsu => 'mutsu';

    #| no routes: the panels are switched in the page, and the same engine
    #| names in every OS tab would clash as methods of this class
    method make-routes() { }

    #| engine-links, not tab-links, so that the Tabs script, which clears
    #| every .tab-links item on a click, leaves the OS tabs alone
    method HTML {
        my @links = do for @.items.kv -> $i, $item {
            li :data-engine($item.key), :class($i ?? '' !! 'active'),
                a :href<#>, %label{$item.key}
        }
        my @panels = do for @.items.kv -> $i, $item {
            div :data-engine($item.key), :class($i ?? 'engine-panel' !! 'engine-panel active'),
                $item.value
        }
        div :class<engine-tabs>, [ div(ul :class<engine-links>, @links), |@panels ];
    }

    method STYLE {
        q:to/END/;
        /* the same look as the platform tabs above */
        .engine-links {
            display: block;
            padding: 0;
            margin: 0 -0.5rem 1rem;
        }
        .engine-links > li {
            display: inline-block;
            list-style: none;
            margin: 0;
            padding: 0.5rem;
        }
        .engine-links > li > a {
            display: inline-block;
            margin: -0.5rem;
            padding: 0.5rem;
            cursor: pointer;
            user-select: none;
            text-decoration: none;
            border-radius: var(--pico-border-radius);
            border-top-left-radius: 0;
            border-top-right-radius: 0;
        }
        .engine-links > li.active > a {
            border-bottom: var(--pico-border-width) solid var(--pico-primary-hover);
        }
        .engine-panel {
            display: none;
        }
        .engine-panel.active {
            display: block;
        }
        END
    }

    #| The page address carries the choice as #platform/engine, for example
    #| /install#macos/rakupp, so that a section can be linked to. Under the
    #| Other tab the second part names a heading: /install#other/arduino.
    method SCRIPT {
        q:to/END/;
        (function () {
            let engine = null;      // the engine picked last
            let section = null;     // a heading to scroll to once its tab is in
            let applying = false;   // true while the address is being followed
            let installPage = false;  // this script is loaded on every page of the site

            const slug = text => text.trim().toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/^-|-$/g, '');
            const osLinks = () => [...document.querySelectorAll('.tab-links > li > a')];
            const activeOs = () => document.querySelector('.tab-links > li.active > a');
            // by name, as the Other tab has no engine switch to look them up in
            const isEngine = name => ['rakudo', 'rakupp', 'mutsu'].includes(name);

            function show(box, name) {
                if (!box.querySelector('.engine-panel[data-engine="' + name + '"]')) return;
                box.querySelectorAll('.engine-links > li, .engine-panel').forEach(
                    el => el.classList.toggle('active', el.dataset.engine === name));
            }

            function settle() {
                if (engine) document.querySelectorAll('.engine-tabs').forEach(box => show(box, engine));
                if (!section) return;
                const heading = [...document.querySelectorAll('.tab h2')].find(h => h.offsetParent && slug(h.textContent).includes(section));   // a visible one
                if (heading) heading.scrollIntoView();
                section = null;
            }

            function writeAddress() {
                if (applying || !installPage || !activeOs()) return;
                let hash = '#' + slug(activeOs().textContent);
                const shown = document.querySelector('.engine-links > li.active');
                if (engine && shown) hash += '/' + shown.dataset.engine;
                history.replaceState(null, '', hash);
            }

            function followAddress() {
                if (!installPage) return;
                let [os, rest] = decodeURIComponent(location.hash.slice(1)).toLowerCase().split('/');
                if (!os) return;
                if (isEngine(os)) [os, rest] = [null, os];    // #rakupp alone
                if (rest && isEngine(rest)) engine = rest; else section = rest || null;
                const link = os && osLinks().find(a => slug(a.textContent) === os);
                if (link && link !== activeOs()) {
                    applying = true;
                    link.click();           // loads the tab; settle() runs after the swap
                } else {
                    settle();
                }
            }

            document.addEventListener('click', function (e) {
                const item = e.target.closest('.engine-links > li');
                if (item) {
                    e.preventDefault();
                    engine = item.dataset.engine;
                    show(item.closest('.engine-tabs'), engine);
                    writeAddress();
                }
                else if (e.target.closest('.tab-links > li')) {
                    // the Tabs script marks the new tab active on this same click
                    setTimeout(writeAddress);
                }
            });

            // a newly loaded OS tab shows the engine picked last
            document.addEventListener('htmx:afterSwap', function () {
                settle();
                // an address that was just followed stays as it was given
                if (applying) applying = false; else writeAddress();
            });

            window.addEventListener('load', function () {
                installPage = !!document.querySelector('.engine-tabs');
                followAddress();
            });
            window.addEventListener('hashchange', followAddress);
        })();
        END
    }
}

sub engine-tabs(*@a, *%h) { EngineTabs.new( |@a, |%h ) }

sub install-page(&basepage, $shadow) is export {
    basepage :stub<install>, #:REFRESH(10),
        main [
            $shadow;
            div :align<center>, :style('position: relative; padding: 20px;'), [
                h1 'Install Raku';
                markdown q:to/END/;
                Raku has three engines: [Rakudo](https://rakudo.org), the reference implementation;
                [Raku++](https://raku.online), an independent interpreter and native compiler written in C++;
                and [mutsu](https://tokuhirom.github.io/mutsu/), an independent interpreter written in Rust.
                They install side by side: the commands are
                `raku`, `rakupp` and `mutsu`.

                Pick your system, then an engine.
                END
                tabs :align-nav<center>, [
                    Linux   => tab linux();
                    macOS   => tab macOS();
                    Windows => tab Windows();
                    Docker  => tab Docker();
                    Browser => tab browser();
                    Other   => tab other();
                ];
            ];
        ];
    }

sub linux {
div [

h1 'Linux';

engine-tabs [
rakudo => tab [
markdown q:to/END/;
Other download and installation [options](/tools) are available.

Rakubrew is a Raku installation tool. It allows you to have multiple versions of different Raku implementations installed in parallel and switch between them. It's a [perlbrew](https://perlbrew.pl/) and [plenv](https://github.com/tokuhirom/plenv) look alike and supports both flavours of commands.

## Installation

Just copy and paste the following piece of code into a console.

    curl https://rakubrew.org/install-on-perl.sh | sh


## Bare Bones Installation

If the above installation script somehow doesn't work for you, you can install
Rakubrew manually.

First download the Rakubrew executable:

    https://rakubrew.org/perl/rakubrew

Then give that file executable permissions:

    chmod +x rakubrew

Add the Rakubrew and shim folders to your `PATH`:

    # Bash & ZSH
    export PATH=/path/where/rakubrew/is:$PATH
    export PATH=$(rakubrew home)/shims:$PATH

    # Fish
    fish_add_path -g /path/where/rakubrew/is
    fish_add_path -g (rakubrew home)/shims

Finally run

    rakubrew mode shim

That's all!
END

md-tail;

modules 'rakudo';
];

rakupp => tab [
markdown q:to/END/;
Raku++ runs as `rakupp`. Its installer offers to add the name `raku` too; say no if you want `raku` to stay Rakudo.

    curl -fsSL https://raku.online/install.sh | sh

On Debian and Ubuntu there is also a `.deb` (`rakupp-linux-aarch64.deb` on ARM64):

    curl -fLO https://github.com/ash/rakupp/releases/latest/download/rakupp-linux-x86_64.deb
    sudo apt install ./rakupp-linux-x86_64.deb

Open a new terminal and check:

    rakupp -e 'say 6 * 7'
END

modules 'rakupp';
];

mutsu => tab [
markdown q:to/END/;
mutsu runs as `mutsu` and comes with `mzef` for modules. Prebuilt binaries for
x64 and ARM64 install with [mise](https://mise.jdx.dev):

    mise use -g github:tokuhirom/mutsu

Then check:

    mutsu -e 'say 6 * 7'
END

modules 'mutsu';
];
];
]
}

sub macOS {
div [

h1 'macOS';

engine-tabs [
rakudo => tab [
markdown q:to/END/;
Other download and installation [options](/tools) are available.

## Installation (Homebrew)

[Homebrew](https://brew.sh/) is a popular macOS package manager.

Just copy and paste the following lines into a console.

    brew update
    brew install rakudo-star


## Installation (MacPorts)

[MacPorts](https://www.macports.org/) is a popular macOS package manager.

Just copy and paste the following lines into a console.

    sudo port install rakudo


## Installation (Rakubrew)

Rakubrew is a Raku installation tool. It allows you to have multiple versions of different Raku implementations installed in parallel and switch between them. It's a [perlbrew](https://perlbrew.pl/) and [plenv](https://github.com/tokuhirom/plenv) look alike and supports both flavours of commands.

Just copy and paste the following piece of code into a console.

    curl https://rakubrew.org/install-on-macos.sh | sh


## Bare Bones Installation

If the above installation script somehow doesn't work for you, you can install
Rakubrew manually.

First download the Rakubrew executable:

    https://rakubrew.org/macos/rakubrew     # Intel Mac
    https://rakubrew.org/macos_arm/rakubrew # ARM Mac

Then give that file executable permissions:

    chmod +x rakubrew

Now you first need to open it according to the instructions at https://support.apple.com/guide/mac-help/open-a-mac-app-from-an-unidentified-developer-mh40616 to tell MacOS' security system that you are actually sure you want to open the file.

Add the Rakubrew and shim folders to your `PATH`:

    # Bash & ZSH
    export PATH=/path/where/rakubrew/is:$PATH
    export PATH=$(rakubrew home)/shims:$PATH

    # Fish
    fish_add_path -g /path/where/rakubrew/is
    fish_add_path -g (rakubrew home)/shims

Finally run

    rakubrew mode shim

That's all!
END

md-tail;

modules 'rakudo';
];

rakupp => tab [
markdown q:to/END/;
Raku++ runs as `rakupp`. Its installer offers to add the name `raku` too; say no if you want `raku` to stay Rakudo.

    curl -fsSL https://raku.online/install.sh | sh

Or with [Homebrew](https://brew.sh/):

    brew tap ash/rakupp
    brew install rakupp

Open a new terminal and check:

    rakupp -e 'say 6 * 7'
END

modules 'rakupp';
];

mutsu => tab [
markdown q:to/END/;
mutsu runs as `mutsu` and comes with `mzef` for modules. Prebuilt binaries for
Intel and Apple Silicon install with [mise](https://mise.jdx.dev):

    mise use -g github:tokuhirom/mutsu

Then check:

    mutsu -e 'say 6 * 7'
END

modules 'mutsu';
];
];
]
}

sub Windows {
div [

h1 'Windows';

engine-tabs [
rakudo => tab [
markdown q:to/END/;
Other download and installation [options](/tools) are available.

Rakubrew is a Raku installation tool. It allows you to have multiple versions of different Raku implementations installed in parallel and switch between them. It's a [perlbrew](https://perlbrew.pl/) and [plenv](https://github.com/tokuhirom/plenv) look alike and supports both flavours of commands.

## Installation

On `CMD` you need to download https://rakubrew.org/install-on-cmd.bat and then
execute that script in a CMD terminal.

On `PowerShell` just copy and paste the following piece of code into a
Powershell window (Don't forget the "." at the start of the command!):

    . {iwr -useb https://rakubrew.org/install-on-powershell.ps1 } | iex

## Bare Bones Installation

First download the Rakubrew executable:

    https://rakubrew.org/win/rakubrew.exe

Add the rakubrew and shim folders to your `PATH`:

    # Powershell
    $Env:Path = "/path/where/rakubrew/is;$Env:Path"
    $Env:Path = "$(rakubrew home)/shims;$Env:Path"

    # CMD
    SET PATH=/path/where/rakubrew/is;%PATH%
    FOR /F "delims=" %i IN ('"rakubrew" home') DO SET PATH=%i/shims;%PATH%

Finally run

    rakubrew mode shim

That's all!
END

md-tail;

modules 'rakudo';
];

rakupp => tab [
markdown q:to/END/;
Raku++ runs as `rakupp`. Run the
[setup wizard](https://github.com/ash/rakupp/releases/latest/download/rakupp-setup-windows-x64.exe),
or paste the following line into a PowerShell window. Both offer to add the name
`raku` too; say no if you want `raku` to stay Rakudo.

    irm https://raku.online/install-windows.ps1 | iex

Open a new terminal and check:

    rakupp -e 'say 6 * 7'
END

modules 'rakupp';
];

mutsu => tab [
markdown q:to/END/;
On Windows, mutsu runs in Docker (see the [Docker tab](#docker/mutsu)) or under
[WSL](https://learn.microsoft.com/windows/wsl/), where the [Linux instructions](#linux/mutsu) apply.
END

modules 'mutsu';
];
];
]
}

#| How one engine installs modules; the last section of its panel
sub modules($engine, :$docker) {

my %text =
rakudo => q:to/END/,
## Modules

Rakudo installs modules from the [Raku ecosystem](https://raku.land) with
[zef](https://github.com/ugexe/zef). Rakudo Star comes with it; under Rakubrew, add it with `rakubrew build-zef`.

    zef install JSON::Fast

Rakudo and Raku++ share one module store: a module installed with zef or
`rakupp install` works in both.
END
rakupp => q:to/END/,
## Modules

Raku++ installs modules from the [Raku ecosystem](https://raku.land) with its built-in
installer, and `rakupp test` runs a distribution's own tests.

    rakupp install JSON::Fast
    rakupp test JSON::Fast

Raku++ and Rakudo share one module store: a module installed with `rakupp install`
or zef works in both.
END
mutsu => q:to/END/;
## Modules

mutsu installs modules from the [Raku ecosystem](https://raku.land) with `mzef`,
which is zef running under mutsu.

    mzef install JSON::Fast
END

my %more =
rakudo => '',
rakupp => "\nMore at [raku.online](https://raku.online).\n",
mutsu  => "\nMore at [tokuhirom.github.io/mutsu](https://tokuhirom.github.io/mutsu/).\n";

my $container = q:to/END/;

In a container, installed modules last as long as the container does. To keep them,
build your own image on top of this one, or mount a volume at the home directory.
END

markdown %text{$engine} ~ ($docker ?? $container !! '') ~ %more{$engine};
}

sub md-tail {

markdown q:to/END/;

### Shell Hook

If you want to use `env` mode, the `shell` command or have auto-completion, you need to install the shell hook. To get the instructions on how to do that type

    rakubrew init


### Installation Path

To make Rakubrew use a different directory to store its files set the `RAKUBREW_HOME` environment variable prior to calling it. Put the following into your `.bashrc` or similar:

    export RAKUBREW =~/rakubrew # or some other path


## How

    # list available versions
    rakubrew available

    # download and install the latest Rakudo on MoarVM version
    rakubrew download

    # switch to use that version (substitute the version you just installed)
    rakubrew switch moar-2025.05

    raku -e 'say "Now running {$*RAKU.compiler.version}!"'


## Global, Shell, Local

Rakubrew knows three different versions that can be set separately.

The `global` version is the one that is selected when neither the `shell` version nor the `local` version are active.

The `shell` version changes the active raku version just in the current shell. Closing the current shell also looses the `shell` version.

The `local` version is specific to a folder. When CWD is in that folder or a sub folder that version of raku is used. Only works in `shim` mode. To unset a local version one must delete the `.RAKU_VERSION` file in the respective folder.


## Modes

Rakubrew can work in two distinct modes: `env` and `shim`

In `env` mode Rakubrew modifies the `$PATH` variable as needed when switching between versions. This is neat because one then runs the executables directly. This is the default mode on *nix.

In `shim` mode Rakubrew generates wrapper scripts called shims for all executables it can find in all the different raku installations. These shims forward to the actual executable when called. This mechanism allows for some advanced features, such as local versions. When installing a module that adds scripts one must make Rakubrew aware of these new scripts. This is done with

    rakubrew rehash

In `env` mode this is not necessary.


## Registering External Versions

To add a raku installation to Rakubrew that was created outside of Rakubrew one
should do:

    rakubrew register name-of-version /path/to/raku/install/directory


## Upgrading

    rakubrew self-upgrade


## Uninstall

To remove Rakubrew and any raku implementations it has installed on your
system, delete the  `~/.rakubrew` and `~/.local/share/rakubrew` directories.

# Further Info

More information on Rakubrew is available [here](https://rakubrew.org/).

END

}

sub Docker {
div [

h1 'Docker';

engine-tabs [
rakudo => tab [
markdown q:to/END/;
Other download and installation [options](/tools) are available.

Rakudo Star is a Raku distribution complete with the zef package manager tool.

## Installation

    docker run -it rakudo-star

# Further Info

More information on the Rakudo Star Docker images is availble on [Docker hub](https://hub.docker.com/_/rakudo-star/)

END

modules 'rakudo', :docker;
];

rakupp => tab [
markdown q:to/END/;
    docker run --rm -it ghcr.io/ash/rakupp

That is the REPL. To run a file from the current directory:

    docker run --rm -v "$PWD:/work" ghcr.io/ash/rakupp script.raku
END

modules 'rakupp', :docker;
];

mutsu => tab [
markdown q:to/END/;
    docker run --rm -it ghcr.io/tokuhirom/mutsu

That is the REPL. To run a file from the current directory:

    docker run --rm -v "$PWD:/work:ro" ghcr.io/tokuhirom/mutsu mutsu script.raku
END

modules 'mutsu', :docker;
];
];
]
}

sub browser {
div [

h1 'Browser';

engine-tabs [
rakupp => tab markdown q:to/END/;
Raku.js is the Raku++ interpreter compiled to WebAssembly. Programs run in the visitor's
browser: there is nothing to install and no server to run.

## Try it

Open the [playground](https://raku.online/play/) and run a program.

## Runnable Raku on your page

Add one script tag, and mark the code that should become an editor with a Run button:

    <script src="https://raku.online/raku.js"></script>
    <pre data-raku>say "Hello from an embedded editor!";</pre>

With `data-auto` on the script tag, the `language-raku` code blocks that Markdown
produces become runnable as they are.

## From your own site

Copy three files into one directory of your site and point the script tag at your copy of `raku.js`:

    curl -O https://raku.online/raku.js
    curl -O https://raku.online/rakujs.js
    curl -O https://raku.online/rakujs.wasm

More in the [Raku.js guide](https://raku.online/embed/js/); the
[builder](https://raku.online/builder/) makes a ready snippet from your code.
END

mutsu => tab markdown q:to/END/;
mutsu is published as a WebAssembly npm package, `@tokuhirom/mutsu`. Programs run in the
visitor's browser: there is nothing to install and no server to run.

## Try it

Open the [playground](https://tokuhirom.github.io/mutsu/playground.html) and run a program.

## Runnable Raku on your page

Put the code in a `<mutsu-code>` element and load the component:

    <mutsu-code autorun>
      <script type="text/raku">
    say "Hello from mutsu!";
      </script>
    </mutsu-code>

    <script type="module"
      src="https://cdn.jsdelivr.net/npm/@tokuhirom/mutsu@latest/embed.js"></script>

## From JavaScript

    npm install @tokuhirom/mutsu

Then, in a module:

    import init, { evaluate } from '@tokuhirom/mutsu';
    await init();
    console.log(evaluate('say "Hello"'));

More in mutsu's [browser guide](https://github.com/tokuhirom/mutsu/blob/main/docs/browser-embedding.md).
END
];
]
}

sub other {
div [

h1 'Other platforms';

h2 'What runs where';

table :thead[['', 'Rakudo', 'Raku++', 'mutsu'],], [
    ['Linux, x86-64 and ARM64', 'Rakubrew', 'installer, .deb', 'mise'],
    ['Linux, RISC-V', 'Debian package', 'installer', ''],
    ['macOS', 'Homebrew, MacPorts, Rakubrew', 'installer, Homebrew', 'mise'],
    ['Windows', 'Rakubrew', 'setup wizard, PowerShell', 'under WSL or Docker'],
    ['BSD', '', 'installer on OpenBSD, else from source', ''],
    ['Docker', 'rakudo-star', 'ghcr.io/ash/rakupp', 'ghcr.io/tokuhirom/mutsu'],
    ['Arduino', '', '--target=arduino', ''],
    ['Web browser', '', 'Raku.js, playground', 'npm package, playground'],
];

markdown q:to/END/;
## Linux on RISC-V

Raku++ has a prebuilt riscv64 archive, and the installer from the [Linux tab](#linux/rakupp) picks it.
It needs glibc 2.35 or newer: Ubuntu 22.04, Debian 13.

    curl -fsSL https://raku.online/install.sh | sh

Debian packages Rakudo for riscv64:

    sudo apt install rakudo

## BSD

Raku++ has a prebuilt archive for OpenBSD, which the same installer finds. On FreeBSD
and NetBSD the installer prints the commands to
[build it from source](https://github.com/ash/rakupp/blob/main/docs/guide/INSTALL.md#build-from-source).

    curl -fsSL https://raku.online/install.sh | sh

## Arduino

Raku++ turns a Raku program into an Arduino sketch, which the Arduino IDE or
`arduino-cli` builds and flashes. Install Raku++ on your computer first; there is nothing to
install on the board.

    rakupp --target=arduino blink.raku -o blink.ino

Without a board, `rakupp blink.raku` runs the same program on a simulated one.
More in the [Arduino guide](https://github.com/ash/rakupp/blob/main/docs/guide/ARDUINO.md).
END
]
}
