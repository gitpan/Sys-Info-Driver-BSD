use strict;
use vars qw(%PREREQ %RECOMMEND %BUILD_REQ $OK);
use Module::Build;

do 'PREREQ' or die "Error including PREREQ: $@";
die "OS unsupported\n" if ! $OK;

Module::Build->new(
   module_name    => 'Sys::Info::Driver::BSD',
   license        => 'perl',
   requires       => \%PREREQ,
   build_requires => \%BUILD_REQ,
   recommends     => \%RECOMMEND,
   sign           => 0,
   dist_author    => 'Burak Gursoy <burak@cpan.org>',
)->create_build_script;
