#!/usr/bin/perl

use Data::Dumper;
use DBI;

open FILE, '<', 'emp.csv';
my $allEmpData = [];
my $record = 0;

while(<FILE>) {
    $record++;
    next if( $record == 1 );
    # $record++;

    my $empData = {};
    my @data = split(",", $_);
    chomp $data[-1];

    ( $empData->{'First Name'} ) = $data[0];
    ( $empData->{'Last Name'} ) = $data[1];
    ( $empData->{'Age'} ) = $data[2];
    ( $empData->{'Phone Number'} ) = $data[3];

    push @$allEmpData, $empData;
}
close FILE;

# print Dumper $allEmpData;

foreach my $empData ( @$allEmpData ) {
    print Dumper $empData;
}
