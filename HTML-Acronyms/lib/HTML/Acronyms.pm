package HTML::Acronyms;

use strict;
use warnings;
use 5.014;

use Carp ();

use Moo;

has 'dict' => (
    is       => 'ro',
    required => 1,
);

sub abbr
{
    my ( $self, $args ) = @_;

    my $key     = $args->{key};
    my $no_link = $args->{no_link};
    if ( exists $args->{link} )
    {
        $no_link = ( !$args->{link} );
    }

    my $rec = $self->dict->{$key};

    if ( !defined $rec )
    {
        Carp::confess("unknown key '$key'!");
    }

    my $tag = qq{<abbr title="$rec->{title}">$rec->{abbr}</abbr>};

    return +{ html => ( $no_link ? $tag : qq{<a href="$rec->{url}">$tag</a>} ),
    };
}

1;

__END__

=head1 NAME

HTML::Acronyms - Generate HTML5/etc. markup for acronyms

=head1 SYNOPSIS

    my $acro = HTML::Acronyms->new(
        {
            dict => +{
                SQL => {
                    abbr  => "SQL",
                    title => "Structured Query Language",
                    url   => qq#https://en.wikipedia.org/wiki/SQL#,
                },
                WDYM => {
                    abbr  => "WDYM",
                    title => "what do you mean",
                    url   => "https://en.wiktionary.org/wiki/WDYM",
                },
            }
        }
    );

    is(
        scalar( $acro->abbr( { key => 'WDYM', no_link => 1 } )->{html} ),
        qq#<abbr title="what do you mean">WDYM</abbr>#,
        "no_link test",
    );

    is(
        scalar( $acro->abbr( { key => 'SQL', no_link => 0 } )->{html} ),
        qq#<a href="https://en.wikipedia.org/wiki/SQL"><abbr title="Structured Query Language">SQL</abbr></a>#,
        "no_link test",
    );

=head1 DESCRIPTION

Acronyms and other abbreviations can be quite cryptic ("What do you mean by
'WDYM'?") and this module aims to help expanding them in HTML5/XHTML5
documents.

=head1 METHODS

=head2 $acro->dict()

Returns the hash ref that serves as the dictionary for the acronyms.

=head2 $acro->abbr({ key => "SQL", link => 1, no_link => 0,})

Returns a hash ref with an C<'html'> key.

=cut
