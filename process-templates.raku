#!/usr/bin/env raku
use v6.d;
use Path::Finder:ver<0.4.5>;
use Template6:ver<0.13.0>;


sub published-counterpart(IO::Path $source-path) {
    'online'.IO.add: $source-path.relative('source')
}

sub is-freshly-modified($_, *%) { 
    .&published-counterpart.modified < .modified
}

sub MAIN(Bool :$incremental) {

    my $wrapper-engine = Template6.new: wrappers => ['common-wrapper'];
    $wrapper-engine.add-path: 'includes';

    my $wrapped-templates = Path::Finder.skip-dir('snippets').file.ext('tt');
    $wrapped-templates.=and(&is-freshly-modified) if $incremental;
    
    for $wrapped-templates.in('source', :!loop-safe, :!sorted) {
        .&published-counterpart.spurt: $wrapper-engine.process($_);
    }

    my $raw-engine = Template6.new;
    $wrapper-engine.add-path: 'includes';

    my $raw-templates = Path::Finder.ext('tt');
    $raw-templates.=and(&is-freshly-modified) if $incremental;

    for $raw-templates.in('source/snippets', :!loop-safe, :!sorted) {
        .&published-counterpart.spurt: $wrapper-engine.process($_);
    }

}