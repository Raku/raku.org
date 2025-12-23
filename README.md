[![Build and Test](https://github.com/Raku/raku.org/actions/workflows/ci.yml/badge.svg)](https://github.com/Raku/raku.org/actions/workflows/ci.yml)
[![License: Artistic-2.0](https://img.shields.io/badge/License-Artistic%202.0-0298c3.svg)](https://opensource.org/licenses/Artistic-2.0)

yo

# raku.org
This is the source code for <https://raku.org>.

It is a complete rewrite bringing many of the best parts of the old site. The old site can still be viewed [here](https://web.archive.org/web/20250821232603/https://raku.org/).

It is rendered every 15 minutes, so commits to the repository's main branch should also result in an update of <https://raku.org>. If not, please report an issue for the infra team on [#raku](https://raku.org/community/irc), our IRC channel.

### Guidelines
Here are some guidelines that you should respect when changing this site:

* Only link to up-to-date information. Feel free to delete outdated information — it is often more confusing than helpful.

* Be nice.

* Don't hesitate to link to pages you wrote yourself, if they are helpful to a broader Raku audience.

* If you have a Raku blog, get it included in the https://planet.raku.org feed instead. You can request this on [#raku](https://raku.org/community/irc), our IRC channel.

* If you intend to change the layout, consider what happens when:

    - user's viewport is small (e.g. mobile device)
    - user resizes window

* We support Chrome, Safari and Edge (HTML5).

* Please test your changes locally before committing.

* We use latest Raku.

### hArc Stack
We use the raku [hArc stack](https://harcstack.org) to make the site. hArc stack combines HTMX, Air, Red and Cro. Red is not used in this case so there is no database to worry about. The raku Air module is the glue for the stack and the documentation is [here](https://librasteve.github.io/Air/), if you would like to read some introductory blogs on hArc, then go [here](https://rakujourney.wordpress.com/all-posts/) and find 'HARC' on page. Please ping me - librasteve - on Discord or IRC if you would like any help.

Yeah, Raku on Raku. ;-)

---

# Docker Installation

Checkout the [quay.io](https://quay.io/repository/chroot.club/proto-25?tab=tags&tag=latest) repo 

```
docker run -it -p 4000:4000 quay.io/chroot.club/proto-25  [:tag]
Open a browser and go to http://localhost:4000
```

---

# Local Installation

Install raku - eg. from rakubrew, then:

Install Cro & Air

```
zef install --/test cro Air
```

Red is not used in this build.

Clone and install this repo

```
git clone https://github.com/Raku/raku.org.git
cd raku.org
zef install . --deps-only   #e.g. Air::Plugin::Hilite
```

Run and view it

```
export CRO_WEBSITE_HOST=0.0.0.0
export CRO_WEBSITE_PORT=4000
raku -I. service.raku
Open a browser and go to http://localhost:4000
```

# Server Installation

Make a directory structure like this:

```
my_webapp/
├── docker-compose.yml
└── Caddyfile
```

Populate the files from the examples given.

Point your domain name to this IP address (ie. match the Caddyfile).

Then go:

```
sudo docker-compose up -d
sudo docker-compose down
```

~librasteve

# git fsck

See https://github.com/Raku/raku.org/issues/50

Please note that there is a git fsck issue with this repository. If you have
enabled fsckObjects, you will see this error when cloning:

```
error: object 552c801ce329aab35ec7a165998e114da4edbd8e: zeroPaddedFilemode: contains zero-padded file modes
```

This warning stems from a change in git where that used to be treated as a
different representation than non zero padded, and so you might have a
slightly larger repository (it couldn't tell they were the same). This doesn't
seem like a true corruption of the repository, even though fsck has been
updated to complain about it.

For now, you can disable fsckObjects when interacting with this repository
or use something like '--depth 1' for your clone.

