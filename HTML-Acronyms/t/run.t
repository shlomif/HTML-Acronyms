#!/usr/bin/env perl

use strict;
use warnings;
use Test::More tests => 2;

use HTML::Acronyms ();

{

    my $acro = HTML::Acronyms->new(
        {
            dict => +{
                WDYM => {
                    abbr  => "WDYM",
                    title => "what do you mean",
                    url   => "https://en.wiktionary.org/wiki/WDYM",
                }
            }
        }
    );

    # TEST
    ok( $acro, "initialized" );

    # TEST
    is_deeply(
        scalar( $acro->abbr( { key => 'WDYM', no_link => 1 } )->{html} ),
        qq#<abbr title="what do you mean">WDYM</abbr>#,
        "no_link test",
    );
}
