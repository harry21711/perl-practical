#!/usr/bin/perl

use Data::Dumper;
use DBI;

my $length = 10; # length of random string

my $csv_file = 'emp.csv';
my $database = 'cetec1';
my $hostname = 'localhost';
my $port     = '3306';
my $username = 'root';
my $password = 'Abcd1298.';

my $dsn = "DBI:mysql:database=$database;host=$hostname;port=$port";
my $dbh = DBI->connect($dsn, $username, $password, { RaiseError => 1 });

# Prepare the SQL statement for inserting data into the employee table
my $stmt = $dbh->prepare("INSERT INTO employee (firstname, lastname, age, comments) VALUES (?, ?, ?, ?)");

# Prepare the SQL statement for inserting data into the phone table
my $phonestmt = $dbh->prepare("INSERT INTO phone (person_id, phone_number) VALUES (?, ?)");

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
    my $string = "";
    for (my $i = 0; $i < $length; $i++) {
        my $random_number = int(rand(26)); # generates random number from 0 to 25
        my $random_character = chr($random_number + 97); # converts random number to character (a-z)
        $string .= $random_character;
    }

    $stmt->execute($empData->{'First Name'}, $empData->{'Last Name'}, $empData->{'Age'}, $string);
    my $empId = $stmt->{mysql_insertid};

    $phonestmt->execute($empId, $empData->{'Phone Number'});
    # print "\n";
}

$dbh->disconnect();