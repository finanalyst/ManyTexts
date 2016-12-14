#!/usr/bin/env perl6

use HTML::Template;

sub MAIN ( Str $fn, Str :$css = "manytexts.css", Str :$template = "chinese.tmpl", Int :$langs = 3 ) {
    die "Could not read source in $fn" unless $fn.IO.f;
    die "Could not read template in $template" unless $template.IO.f;
    
    my $outname = '../ManyTexts_html/index.html';
    
    my $templ = HTML::Template.from_file($template);
    my %params = style => $css;
    my $pt;

    for $fn.IO.lines {
        m:s/ ^ $<ref> = \d+ ',' 
            $<tmp> = ( '"' ~ '"' $<cnt>= <-["]>+ | $<cnt>= \d+)+ % ',' /;
        $pt =  "$<tmp>[0]<cnt>".subst(/ \s /, '_',:g);
        %params<texts>.push( %( 
            :num( $pt eq 'Subheader_number'),
            :ref( ~$<ref> ), 
            :paratype( $pt ),
            :eng( ~$<tmp>[1]<cnt> ),
            :zh_tr( ~$<tmp>[2]<cnt> ),
            :zh_sm( ~$<tmp>[3]<cnt> )
       ) );
    }    
    $templ.with_params( %params );
    $outname.IO.spurt: $templ.output;
}