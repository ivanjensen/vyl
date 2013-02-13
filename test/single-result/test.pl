#!/usr/bin/perl -Wall
use Cwd;

my $expected = "vi ./files/test.txt";
my $command = "find ./files -name test.txt";

# send the command we want to pretend was last in history
delete $ENV{"EDITOR"};
$ENV{"VYL_DEBUG"} = $command;
system("../../vyl");

open FILE, "<", "test-result.txt" or die $!;

my $result = <FILE>;

chomp($result);

if ($result eq $expected) {
	print ".";
	exit 0;
} else {
	print "\nF\t" . cwd() . "/$0\n";
	print "expected:" . $expected;
	print "result:  " . $result;
	exit 1;
}
