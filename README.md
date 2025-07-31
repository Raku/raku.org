[![Build and Test](https://github.com/Raku/raku.org/actions/workflows/ci.yml/badge.svg)](https://github.com/Raku/raku.org/actions/workflows/ci.yml)

# raku.org proto-25
a prototype upgrade to the raku.org website

the process:

1. Gather Requirments

all interested folk invited to comment and input on [Requirements.md](https://github.com/librasteve/raku-org-25-proto/blob/main/Requirements.md)
 - open an Issue for discussion of a point
 - when agreed, make a PR for review and merge

the aim was to get all feedback within 5 days - ie by 4th June - so that it can be incorporated into the prototype build
[now closed for new requirements]

2. Build Initial Prototype

done - yay!
spike02 now available at
https://proto25.harcstack.org

(you can also follow instructions below to install and hack locally)

3. Summit Folks Review

initially summit participants and Damian are invited to review
see ./Review.md for what to do
[now complete]

4. Move Proto to Dev

the code has been moved from https://github.com/librasteve/raku-org-25-proto to here
Dockerfile and GHA has been written and checked

5. Final Check

6. Go Live

7. Continuous Improvement

...

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
zef install --/test cro
zef install Air
```

Red is not used in this build.

Clone and install this repo

```
git clone https://github.com/Raku/raku.org.git
git checkout proto-25
cd raku.org
zef install . --force-install
```

Run and view it

```
export CRO_WEBSITE_HOST=0.0.0.0
export CRO_WEBSITE_PORT=4000
raku -Ilib service.raku
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
