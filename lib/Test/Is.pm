use strict;
use warnings;
package Test::Is;
{
  $Test::Is::VERSION = '20130414';
}

sub import
{
    shift;
    die "missing arguments for Test::Is" unless @_;

    # TODO: check if a Test::Builder exists. If this is the case,
    # this means we are running too late and this is wrong!

    while (@_) {
	if ($_[0] eq 'interactive') {
	    skip_all($_[0]) if env('NON_INTERACTIVE');
	} elsif ($_[0] eq 'extended') {
	    skip_all($_[0]) unless env('EXTENDED_TESTING');
	} else {
	    die "invalid Test::Is argument";
	}
	shift;
    }
}

sub env
{
    exists $ENV{$_[0]} && $ENV{$_[0]} eq '1'
}


sub skip_all
{
    my $kind = shift;
    print "1..0 # SKIP $kind test";
    exit 0
}

1;

=encoding UTF-8

=head1 NAME

Test::Is - Skip test in a declarative way, following the Lancaster Consensus

=head1 VERSION

version 20130414

=head1 SYNOPSIS

I want that this runs only on interactive environments:

    use Test::Is 'interactive';

This test is an extended test: it takes much time to run or may have special
running conditions that may inconvenience a user that just want to install the
module:

    use Test::Is 'extended';

Both:

    use Test::Is 'interactive', 'extended';

=head1 DESCRIPTION

This module is a simple way of following the specifications of the environment
variables available for Perl tests as defined as one of the
"Lancaster Consensus" at Perl QA Hackathon 2013. Those variables
(C<NON_INTERACTIVE>, C<EXTENDED_TESTING>) define which tests should be
skipped.

If the environment does not match what the author of the test expected, the
complete test is skipped (in the same way as C<use L<Test::More> skip_all =E<gt>
...>).

As an author, you can also expect that you will automatically benefit of later
evolutions of this specification just by upgrading the module.

As a CPAN toolchain author (CPAN client, smoker...) you may want to ensure at
runtime that the installed version of this module matches the environment
you set yourself.

=head1 SEE ALSO

L<Test::DescribeMe> by WOLFSAGE, also created at Perl QA Hackathon 2013.

=head1 AUTHOR

Olivier Mengué, L<mailto:dolmen@cpan.org>

=head1 COPYRIGHT & LICENSE

Copyright E<copy> 2013 Olivier Mengué.

This library is free software; you can redistribute it and/or modify it under
the same terms as Perl 5 itself.

=cut

# vim: set et sw=4 sts=4 :
