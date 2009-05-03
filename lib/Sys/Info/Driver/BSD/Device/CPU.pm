package Sys::Info::Driver::BSD::Device::CPU;
use strict;
use vars qw($VERSION);
use base qw(Sys::Info::Base);
use Unix::Processors;
use POSIX ();
use Carp qw( croak );
use Sys::Info::Constants qw( LIN_MACHINE );
use Sys::Info::Driver::BSD;

$VERSION = '0.72';

sub identify {
    my $self = shift;

    if ( ! $self->{META_DATA} ) {
        my $up   = Unix::Processors->new;
        my $mach = (POSIX::uname)[LIN_MACHINE] || fsysctl('hw.machine_arch'); # hw.machine?
        my $arch = $mach =~ m{ i [0-9] 86 }xmsi ? 'x86'
                 : $mach =~ m{ ia64       }xmsi ? 'IA64'
                 : $mach =~ m{ x86_64     }xmsi ? 'AMD-64'
                 :                                 $mach
                 ;
        my $name = fsysctl('hw.model');
        $name =~ s{\s+}{ }xms;
        my $byteorder = nsysctl('hw.byteorder');
        my @flags;
        push @flags, 'fpu' if nsysctl('hw.floatingpoint');

        $self->{META_DATA} = [];

        push @{ $self->{META_DATA} }, {
            architecture                 => $arch,
            processor_id                 => 1,
            data_width                   => undef,
            address_width                => undef,
            bus_speed                    => undef,
            speed                        => $up->max_clock,
            name                         => $name,
            family                       => undef,
            manufacturer                 => undef,
            model                        => undef,
            stepping                     => undef,
            number_of_cores              => $up->max_physical,
            number_of_logical_processors => $up->max_online,
            L2_cache                     => {max_cache_size => undef},
            flags                        => @flags ? [ @flags ] : undef,
            ( $byteorder ? (byteorder    => $byteorder):()),
        } for 1..fsysctl('hw.ncpu');
    }
    #$VAR1 = 'Intel(R) Core(TM)2 Duo CPU     P8600  @ 2.40GHz';
    return $self->_serve_from_cache(wantarray);
}

sub load {
    my $self  = shift;
    my $level = shift;
    my $loads = fsysctl('vm.loadavg') || 0;
    return $loads->[$level];
}

sub bitness {
    my $self = shift;
}

1;

__END__

=head1 NAME

Sys::Info::Driver::BSD::Device::CPU - BSD CPU Device Driver

=head1 SYNOPSIS

-

=head1 DESCRIPTION

This document describes version C<0.72> of C<Sys::Info::Driver::BSD::Device::CPU>
released on C<3 May 2009>.

This document describes version C<0.72> of C<Sys::Info::Driver::BSD::Device::CPU>
released on C<3 May 2009>.

Identifies the CPU with L<Unix::Processors>, L<POSIX>.

=head1 METHODS

=head2 identify

See identify in L<Sys::Info::Device::CPU>.

=head2 load

See load in L<Sys::Info::Device::CPU>.

=head2 bitness

See bitness in L<Sys::Info::Device::CPU>.

=head1 SEE ALSO

L<Sys::Info>,
L<Sys::Info::Device::CPU>,
L<Unix::Processors>, L<POSIX>.

=head1 AUTHOR

Burak Gürsoy, E<lt>burakE<64>cpan.orgE<gt>

=head1 COPYRIGHT

Copyright 2009 Burak Gürsoy. All rights reserved.

=head1 LICENSE

This library is free software; you can redistribute it and/or modify 
it under the same terms as Perl itself, either Perl version 5.10.0 or, 
at your option, any later version of Perl 5 you may have available.

=cut
