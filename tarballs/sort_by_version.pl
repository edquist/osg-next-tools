#!/usr/bin/env perl

use warnings;
use strict;


sub compare {
    if ($a && ! $b) {
        return 1;
    } elsif (! $a && $b) {
        return -1;
    } elsif (! $a && ! $b) {
        return 0;
    }
    my (@a_split) = split /\b/, $a;
    my (@b_split) = split /\b/, $b;

    while (@a_split || @b_split) {
        if (@a_split && ! @b_split) {
            return 1; # a is longer
        } elsif (! @a_split && @b_split) {
            return -1; # b is longer
        } else {
            my ($a_token) = shift @a_split;
            my ($b_token) = shift @b_split;
            if ($a_token =~ /^\d+$/ && $b_token =~ /^\d+$/) {
                my ($comparison) = $a_token <=> $b_token;
                return $comparison if $comparison != 0;
            } else {
                my ($comparison) = $a_token cmp $b_token;
                return $comparison if $comparison != 0;
            }
        }
    }
}


my @lines = <>;
chomp foreach (@lines);
print join ("\n", sort compare @lines) . "\n";
