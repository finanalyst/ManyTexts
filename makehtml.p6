#!/usr/bin/env perl6

use HTML::Template;

sub MAIN ( 
        Str :$library = 'library.csv', 
        Str :$css = "manytexts.css", 
        Str :$template = 'chinese.tmpl', 
        Str :$lib-template = 'library.tmpl',
        Str :$navbar = 'navbar.frag', 
        Str :$credits = 'credits.frag' 
    ) {
    die "Could not read template in $template" unless $template.IO.f;
    die "Could not read template in $lib-template" unless $lib-template.IO.f;
    die "Could not read navigation bar fragment in $navbar" unless $navbar.IO.f;
    die "Could not read credits part in $credits" unless $credits.IO.f;
    
    my $fn; # the file name of each page, without extension.
    my $source = 'source'; # the source directory of the page files
    my $target = '../ManyTexts_html/'; # where the html files are to go
    my $normal = HTML::Template.from_file($template);
    my $lib-tmpl = HTML::Template.from_file($lib-template);
    my $ref = 1;
    my @lib-texts;
    
    my %params = 
        style => $css, 
        navbar => $navbar.IO.slurp,
        credits => $credits.IO.slurp, # this is only ever used in first page
        credit_on => True;
        
    $fn = 'FirstPage.csv'; 
    
   %params<texts> =  render-page( $fn); # first page is in main directory
   $normal.with_params( %params );
   "$target/index.html".IO.spurt: $normal.output;
   %params<credits>:delete; # no longer needed
   %params<credit_on> = False;
    
    say "$fn -> index.html";
        
    for $library.IO.lines {
        next if m:s/ ^ \s* '#' | ^$ /; #skip comment or empty line
        if m:s/ ^ $<tmp> = ( '"' ~ '"' $<cnt>= <-["]>+ )+ % ',' / {
            if ~$<tmp>[0]<cnt> eq 'LibraryHeading' {
                @lib-texts.push: %(
                    :ref( $ref++ ), 
                    :paratype( 'LibraryHeading' ),
                    :file( False ),
                    :eng( ~$<tmp>[2]<cnt> ),
                    :zh_tr( ~$<tmp>[3]<cnt> ),
                    :zh_sm( ~$<tmp>[4]<cnt> )
                );
            } elsif ~$<tmp>[0]<cnt> eq 'LibraryText' { # so should be main text paragraph
                # possibly - no file Chinese equivalents should have placeholders
                $fn = ~$<tmp>[1]<cnt>;
                @lib-texts.push: %(
                    :ref( $ref++ ), 
                    :paratype( 'LibraryText' ),
                    :eng( ~$<tmp>[2]<cnt> ),
                    :zh_tr( ~$<tmp>[3]<cnt> ),
                    :zh_sm( ~$<tmp>[4]<cnt> ),
                    :file( $fn ne 'No file' ),
                    :link( "$fn\.html")
                ) ;
                # now render file if it exists
                if $fn ne 'No file' {
                    %params<texts> = render-page( "$source/$fn\.csv" );
                    $normal.with_params( %params );
                    "$target/$fn.html".IO.spurt: $normal.output;
                    say "$fn\.csv -> $fn.html";
                }
            } else { # otherwise an error
                die "Category not LibraryText or LibraryHeading in $library\n$_";
            }
            %params<texts> = @lib-texts;
        } else {
            die "Error in $library, so cannot proceed";
        }
    }
   $lib-tmpl.with_params( %params );
   "$target/library.html".IO.spurt: $lib-tmpl.output;
    say "library.csv -> library.html";
}

sub render-page( $fn ) { 
    state $error-ref = 1; # we need this for error references in text lines.
    my @texts;
    # file is readable, process, otherwise fail safely
    if $fn.IO.f {
        my $pt;
        for $fn.IO.lines {
            next if m:s/^ \s* '#' /; # lines with # as first character in line are comments
            $pt = .subst(/\,\"\"\"/, ',"&quot;', :g); # remove doubled quotes at start of cell
            $pt.subst-mutate(/\"\"\"\,/, '&quot;",', :g); # remove doubled quotes at end of cell
            $pt.subst-mutate(/\"\"/, '&quot;', :g); # remove doubled quotes inside cell.
            if $pt ~~ m:s/ ^ $<ref> = \d+ ',' 
                    $<tmp> = ( '"' ~ '"' $<cnt>= <-["]>+ | $<cnt>= \d+)+ % ',' / {
                $pt =  ~$<tmp>[0]<cnt>;
                @texts.push( %( 
                    :num( $pt eq 'PassageNumber'),
                    :ref( ~$<ref> ), 
                    :paratype( $pt ),
                    :eng( ~$<tmp>[1]<cnt> ),
                    :zh_tr( ~$<tmp>[2]<cnt> ),
                    :zh_sm( ~$<tmp>[3]<cnt> )
                ) );
            } else { # there is an error in an input line, so create error text.
                note "Unrecognised line in $fn\n$_";
                @texts.push( %(
                    :num( False ),
                    :ref( "ERR_$error-ref" ), 
                    :paratype( 'Title' ),
                    :eng( 'ERROR in input, please inform Site Administrators' ),
                    :zh_tr( '#####' ),
                    :zh_sm( '#####' )
                ));
                $error-ref++;
            }
        }
    } else { # no file, so create error message
        @texts.push( %(
            :num( False ),
            :ref( "ERR_$error-ref" ), 
            :paratype( 'Title' ),
            :eng( 'Text Not Available, Sorry' ),
            :zh_tr( '#####' ),
            :zh_sm( '#####' )
        ));
    }
    return @texts;
}