#!/usr/bin/env raku
use v6.d;
use Path::Finder:ver<0.4.6>;
use Template6:ver<0.14.0>;


sub published-counterpart(IO::Path $source-path, Bool :$safe-path) {
    my $same-under-online = 'online'.IO.add: $source-path.relative('source');
    mkdir $same-under-online.parent if $safe-path;
    $same-under-online.extension eq 'tt' ?? $same-under-online.extension('html') !! $same-under-online
}

sub is-freshly-modified($_, *%) { 
    .&published-counterpart.modified < .modified
}

sub MAIN(Bool :$incremental) {

    my $non-templates = Path::Finder.file.ext(none('tt'));
    $non-templates.=and(&is-freshly-modified) if $incremental;
    
    for $non-templates.in('source', :!loop-safe, :!sorted).race {
        print "Copying '$_'..." if %*ENV<VERBOSE>;
        .copy: .&published-counterpart(:safe-path);
        say 'Done.' if %*ENV<VERBOSE>;
    }

    my $wrapper-engine = Template6.new: wrappers => ['common-wrapper'], :reset;
    $wrapper-engine.add-path: 'includes';

    my $wrapped-templates = Path::Finder.skip-dir('snippets').file.ext('tt');
    $wrapped-templates.=and(&is-freshly-modified) if $incremental;
    
    for $wrapped-templates.in('source', :!loop-safe, :!sorted).race {
        print "Processing '$_'..." if %*ENV<VERBOSE>;
        .&published-counterpart(:safe-path).spurt: $wrapper-engine.process($_);
        say 'Done.' if %*ENV<VERBOSE>;
    }

    my $raw-engine = Template6.new: :reset;
    $raw-engine.add-path: 'includes';

    my $raw-templates = Path::Finder.ext('tt');
    $raw-templates.=and(&is-freshly-modified) if $incremental;

    for $raw-templates.in('source/snippets', :!loop-safe, :!sorted).race {
        print "Processing '$_'..." if %*ENV<VERBOSE>;
        .&published-counterpart(:safe-path).spurt: $raw-engine.process($_);
        say 'Done.' if %*ENV<VERBOSE>;
    }

}
