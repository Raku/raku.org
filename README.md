This is the source code for <http://perl6.org/>.

It is rendered with [mowyw](http://perlgeek.de/en/software/mowyw)
every 15 minutes, so updates to the repository should also result in
an update of perl6.org. If not, talk to moritz on
[#perl6](irc://irc.freenode.net/perl6).

Here are some guidelines that you should respect when changing this site:

  * Only link to up-to-date information. Feel free to delete outdated
    information — it is often more confusing than helpful.

  * Be nice.

  * Don't hesitate to link to pages you wrote yourself, if they are helpful to
    a broader Perl 6 audience.

  * If you have a Perl 6 blog, get it included in the planetsix.perl.org feed
    instead. Talk to \[Coke\] on [#perl6](irc://irc.freenode.net/perl6).

  * If you intend to change the layout, consider what happens when:

      - user's viewport is small (e.g. 800x600)
      - user resizes window

  * We use [Bootstrap3](http://getbootstrap.com/) and
    [jQuery](http://jquery.com/). Whenever possible, please use the facilities
    these frameworks provide, instead of rolling out something custom.

  * We use [SASS](http://sass-lang.com/) in `style.scss` to generate
    `style.css`. You can do that by running
    `sass --watch style.scss:style.css`. CSS is still valid SASS; if you
    don't know SASS, just write plain CSS. If you cannot run `sass`, please
    add your changes to `style.css` and ping @zoffixznet to add your styles
    to `style.scss`.

  * We support the current and previous major releases of Chrome, Firefox,
    Internet Explorer, and Safari. Please test layout changes. Lacking actual
    browers to test in, you can use [browsershots.org](http://browsershots.org)
    or [browserstack.com](http://browserstack.com).

  * We spell "Perl 6" consistently with a
    [non-breaking space](https://en.wikipedia.org/wiki/Non-breaking_space#Keyboard_entry_methods).
    If you don't already have one, go get an editor with decent Unicode support.

  * Speaking of which, all pages are served as UTF-8.

  * If you create a new page, please link to the URL *without* the
    ".html" extension.

To run this site locally, install mowyw
(`cpanm App::Mowyw Text::VimColor Plack`) then:

    mowyw
    plackup app.psgi

This populates the `./online` folder, and launches a local web server for
testing, e.g. http://localhost:5000/index.html
