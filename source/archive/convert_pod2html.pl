use strict;
use warnings;
use File::Slurp;
use Pod::HtmlEasy;
use File::Find::Rule;

#####################
#
# This (hacked together) script converts the .pod files
# which dev.perl.org used to support into .html files
# which should just about work for mowyw and www.perl6.org
#
# To run:
# > cd source/archive/
# > perl convert_pod2html.pl 
# 
# This creates the .html files next to their .pod files
# mowyw will need to be run after that.
#####################

my %pod_opts = (
    no_index     => 1,
    only_content => 1,
);

my $podhtml = Pod::HtmlEasy->new();

my @INC   = ('./');
my @files = File::Find::Rule->file()->name('*.pod')->in(@INC);

foreach my $file (@files) {

    # TODO: many []'s or something else - needs someone to fix!
    next if $file =~ /rfc\/230\.pod$/;
    next if $file =~ /exe\/E07.pod$/;

    my $html_file = $file;
    $html_file =~ s/\.pod$/.html/;

    warn "$file -> $html_file";

    my $title = '';

    {

        # Hack to get title from POD
        my $pod = read_file($file);
        if ( $pod =~ /=head1 TITLE/i || $pod =~ /=head1 NAME/i ) {

            $pod =~ s/[\r\n]//g;
            if ( $pod =~ /=head1 TITLE/i ) {
                $pod =~ /=head1 TITLE(.+?)=/;
                $title = $1;
            } else {
                $pod =~ /=head1 NAME(.+?)=/i;
                $title = $1;
            }
        } else {

            # Just take the firse head1 (e.g some of the list summaries)
            my @pod = read_file($file);
            # S29.pod doesn't have =head1 as the first line, so loop
            foreach my $line (@pod) {
                if ( $line =~ /=head1/i ) {
                    $title = $line;
                    $title =~ s/=head1\s*//i;
                    last;
                }
            }
        }

        # cleanup
        $title =~ s/^\s+//;
        $title =~ s/\s+$//;
        $title ||= 'Unknown';
        warn "Title: $title";
    }

    my $html = "[% setvar title $title %]\n";
    $html .= $podhtml->pod2html( $file, %pod_opts );

    write_file( $html_file, $html );
}
