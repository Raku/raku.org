unit class Install;

use Air::Functional :BASE;
use Air::Base;

sub install-page(&basepage, &shadow) is export {
    basepage #:REFRESH(10),
        main [
            shadow;
            div :align<center>, :style('position: relative; padding: 20px;'), [
                h1 'Install Raku';
                tabs :align-nav<center>, [
                    Linux   => tab linux();
                    macOS   => tab macOS();
                    Windows => tab Windows();
                    Docker  => tab Docker();
                ];
            ];

        ];
    }

sub linux {
div [

h1 'Linux';

markdown q:to/END/;
Other download and installation [options](/nav/1/info) are available.

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
]
}

sub macOS {
div [

h1 'macOS';

markdown q:to/END/;
Other download and installation [options](/nav/1/info) are available.

## Installation (Homebrew)

[Homebrew](https://brew.sh/) is a popular macOS package manager.

Just copy and paste the following lines into a console.

    brew update
    brew install rakudo-star


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
]
}

sub Windows {
div [

h1 'Windows';

markdown q:to/END/;
Other download and installation [options](/nav/1/info) are available.

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
]
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

More information on Rakubrew is available [here](https://github.com/Raku/App-Rakubrew)

END

}

sub Docker {
    div [
        h1 'Docker';

        markdown q:to/END/;
Other download and installation [options](/nav/1/info) are available.

Rakudo Star is a Raku distribution complete with the zef package manager tool.

## Installation

    docker run -it rakudo-star

# Further Info

More information on the Rakudo Star Docker images is availble on [Docker hub](https://hub.docker.com/_/rakudo-star/)

END
    ]
}

