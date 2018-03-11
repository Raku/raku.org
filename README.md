# Perl6.org
This is the source code for <https://perl6.org>.

It is rendered with [mowyw](https://perlgeek.de/en/software/mowyw)
every 15 minutes, so updates to the repository should also result in
an update of <https://perl6.org>  
If not, talk to [moritz] on
[#perl6](https://chat.mibbit.com/?channel=%23perl6&server=irc.freenode.net).

### Guidelines
Here are some guidelines that you should respect when changing this site:

  * Only link to up-to-date information. Feel free to delete outdated
    information — it is often more confusing than helpful.

  * Be nice.

  * Don't hesitate to link to pages you wrote yourself, if they are helpful to
    a broader Perl 6 audience.

  * If you have a Perl 6 blog, get it included in the planetsix.perl.org feed
    instead. Talk to \[Coke\] on [#perl6](https://chat.mibbit.com/?channel=%23perl6&server=irc.freenode.net).

  * If you intend to change the layout, consider what happens when:

      - user's viewport is small (e.g. mobile device)
      - user resizes window

  * We use [Bootstrap3](http://getbootstrap.com/) and
    [jQuery](http://jquery.com/). Whenever possible, please use the facilities
    these frameworks provide, instead of rolling out something custom.

  * We use [SASS](http://sass-lang.com/) in `style.scss` to generate
    `style.css`. You can do that by running `sass style.scss:style.css` inside
    the `source` directory (add `--watch` flag to make it watch for changes
    and re-generate the CSS file). CSS is still valid SASS; if you
    don't know SASS, just write plain CSS. If you cannot run `sass`, please
    add your changes to `style.css` and ping @zoffixznet to add your styles
    to `style.scss`.

  * We support the current and previous major releases of Chrome, Firefox,
    Internet Explorer (Edge), and Safari. Please test layout changes. Lacking actual
    browsers to test in, you can use [browsershots.org](http://browsershots.org)
    or [browserstack.com](http://browserstack.com).

  * We spell "Perl 6" consistently with a
    [non-breaking space](https://en.wikipedia.org/wiki/Non-breaking_space#Keyboard_entry_methods).
    If you don't already have one, go get an editor with decent Unicode support.

  * Speaking of which, all pages are served as UTF-8.

  * If you create a new page, please link to the URL *without* the
    ".html" extension.

### Build
To run this site locally:

  - Install the following modules:

    `cpanm App::Mowyw Text::VimColor Plack`

  - Run the following commands to populate the `./online` folder and launch a local web server for testing:
    ```
    mowyw
    plackup
    ```
  - Open http://localhost:5000/index.html in your browser

Tip: if you remove `source/archive` directory, `mowyw` generation will run a
lot faster. Useful for checking frequently-made changes.

### LICENSE

See [LICENSE](LICENSE) file for the details of the license of the code in this repository.

This repository also contains code authored by third parties that may be licensed under a different license. Such
files indicate the copyright and license terms at the top of the file. Currently these include:

* jQuery and jQuery UI libraries: Copyright 2015 jQuery Foundation and other contributors; [MIT License](http://creativecommons.org/licenses/MIT)
* The Camelia image is copyright 2009 by Larry Wall. Permission to use is granted under the [Artistic License 2.0](License), or any subsequent version
of the Artistic License.
