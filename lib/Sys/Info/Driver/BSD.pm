package Sys::Info::Driver::BSD;
use strict;
use vars qw( $VERSION @ISA @EXPORT );
use BSD::Sysctl qw( sysctl sysctl_exists );
use Exporter ();
use Carp qw( croak );

$VERSION = '0.70';
@ISA     = qw( Exporter );
@EXPORT  = qw( fsysctl nsysctl );

sub fsysctl {
    my $key = shift || croak "Key is missing";
    my $val = sysctl_exists($key) ? sysctl($key)
                                  : croak "Can not happen: $key is not defined";
    return $val;
}

sub nsysctl {
    my $key = shift || croak "Key is missing";
    return if ! sysctl_exists($key);
    return sysctl($key);
}

1;

__END__

=head1 NAME

Sys::Info::Driver::BSD - BSD driver for Sys::Info

=head1 SYNOPSIS

    use Sys::Info::Driver::BSD;

=head1 DESCRIPTION

This is the main module in the C<BSD> driver collection.

=head1 METHODS

None.

=head1 FUNCTIONS

=head2 fsysctl

f(atal)sysctl(). Implemented via L<BSD::Sysctl>.

=head2 nsysctl

n(ormal)sysctl. Implemented via L<BSD::Sysctl>.

=head1 AUTHOR

Burak Gürsoy, E<lt>burakE<64>cpan.orgE<gt>

=head1 COPYRIGHT

Copyright 2009 Burak Gürsoy. All rights reserved.

=head1 LICENSE

This library is free software; you can redistribute it and/or modify 
it under the same terms as Perl itself, either Perl version 5.10.0 or, 
at your option, any later version of Perl 5 you may have available.

=cut
