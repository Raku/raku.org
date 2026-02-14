unit class HTML404;

use Air::Functional :BASE;
use Air::Base;
use Air::Plugin::Hilite;

sub html404-page(&basepage, &shadow) is export {
basepage #:REFRESH(10),
    main [
        shadow;
        div :align<center>, [
            h1 safe '404 Error';
            h2 safe 'Oops - this page does not exist.';
        ];
    ];
}

