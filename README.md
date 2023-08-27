# raku.org
This is the source code for <https://raku.org>.

It is rendered every 15 minutes, so updates to the repository should also result in
an update of <https://raku.org>
If not, talk to [moritz] on
[#raku](https://kiwiirc.com/client/irc.libera.chat/#raku).

### Guidelines
Here are some guidelines that you should respect when changing this site:

  * Only link to up-to-date information. Feel free to delete outdated
    information — it is often more confusing than helpful.

  * Be nice.

  * Don't hesitate to link to pages you wrote yourself, if they are helpful to
    a broader Raku audience.

  * If you have a Raku blog, get it included in the https://planet.raku.org feed.
    See the [github repo](https://github.com/raku/planet.raku.org)

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

  * Speaking of which, all pages are served as UTF-8.

  * If you create a new page, please link to the URL *without* the
    ".html" extension.
 
  * When referenced the first time in a section, use Raku®, but Rakudo™ or Camelia™.

### Build
To run this site locally:

  - libxml2 is a native binary dependency; make sure to install it as your platform requires (except Windows where it's baked into the Raku dist)

  - for content generation, install this repository as a module:
    `zef install .`

  - Install the following Perl modules for setting up the server:

    `cpanm Plack IO::Socket::SSL`

  - Run the following commands to populate the `./online` folder and launch a local web server for testing:
    ```sh
    ./fetch-recent-blog-posts.raku
    ./publish-sources.raku
    plackup
    ```
  - Open http://localhost:5000/index.html in your browser

### LICENSE

See [LICENSE](LICENSE) file for the details of the license of the code in this repository.

This repository also contains code authored by third parties that may be licensed under a different license. Such
files indicate the copyright and license terms at the top of the file. Currently these include:

* jQuery and jQuery UI libraries: Copyright 2015 jQuery Foundation and other contributors; [MIT License](http://creativecommons.org/licenses/MIT)
* The Camelia image is copyright 2009 by Larry Wall. Permission to use is granted under the [Artistic License 2.0](License), or any subsequent version
of the Artistic License
