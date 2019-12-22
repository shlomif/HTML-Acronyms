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

=head1 METHODS

=head2 $acro->dict()

Returns the hash ref that serves as the dictionary for the acronyms.

=head2 $acro->abbr({ key => "SQL", no_link => 0,})

Returns a hash ref with an C<'html'> key.

=cut
