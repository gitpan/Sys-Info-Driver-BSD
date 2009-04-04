#!/usr/bin/perl -w
use strict;
use vars qw(%PREREQ %BUILD_REQ $OK);
use ExtUtils::MakeMaker;

do 'PREREQ' or die "Error including PREREQ: $!";
die "OS unsupported\n" if ! $OK;

WriteMakefile(
   'NAME'         => 'Sys::Info::Driver::BSD',
   'VERSION_FROM' => 'lib/Sys/Info/Driver/BSD.pm',
   'PREREQ_PM'    => { %PREREQ, %BUILD_REQ },
   ($] >= 5.005 ? (
   AUTHOR   => 'Burak Gursoy <burak@cpan.org>',
   ABSTRACT => 'BSD driver for Sys::Info',
   ) : ()),
   PL_FILES => {},
);
