# raku-org-25-proto
a prototype upgrade to the raku.org website

the process is:

1. Gather Requirments

all interested folk invited to comment and input on [Requirements.md](https://github.com/librasteve/raku-org-25-proto/blob/main/Requirements.md)
 - open an Issue for discussion of a point
 - when agreed, make a PR for review and merge

the aim was to get all feedback within 5 days - ie by 4th June - so that it can be incorporated into the prototype build
[now closed for new requirements]

2. Build Initial Prototype

done - yay!
spike01 now available at
https://proto25.harcstack.org

(you can also follow instructions below to install and hack locally)

3. Summit Folks Review

initially summit participants and Damian are invited to review
see ./Review.md for what to do

...


---

# Installation

Install raku - eg. from rakubrew, then:

Install Cro & Air (branch hilite)

```
zef install --/test cro
git clone https://github.com/librasteve/Air.git 
cd Air
git checkout hilite
zef install . --force-install
cd ..
```

Red is not used in this build.

Clone and install this repo

```
git clone https://github.com/librasteve/raku-org-25-proto.git
cd raku-org-25-proto
zef install . --force-install
```

Run and view it

```
raku -Ilib service.raku
Open a browser and go to http://localhost:3000
```

~librasteve
