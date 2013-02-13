#!/usr/bin/perl -Wall
use Cwd;
use Test::Simple tests => 6;

ok(&test("find ./files -name test.txt", "vi ./files/test.txt"), 'single result, no argument');
ok(&test("find ./files -name myfile", "vi ./files/dir1/myfile", "1"), 'single result, specify first');
ok(&test("find ./files -name myfile", "vi ./files/dir1/myfile"), 'multiple results, no argument, should take first');
ok(&test("find ./files -name myfile", "vi ./files/dir1/myfile", "1"), 'multiple results, select first result');
ok(&test("find ./files -name myfile", "vi ./files/myfile", "2"), 'multiple results, select second result');
ok(&test("ls -1 files/quotes", "vi filewith\"adoublequote", "1"), 'result with a double quote');
ok(&test("ls -1 files/quotes", "vi filewith'asinglequote", "2"), 'result with a double quote');


sub test {
	local($command, $expected, $vyl_args) = ($_[0], $_[1], $_[2]);

	if (! defined $vyl_args) {
		$vyl_args = "";
	}

	# send the command we want to pretend was last in history
	delete $ENV{"EDITOR"};
	$ENV{"VYL_DEBUG"} = $command;
	system("../vyl", $vyl_args);

	open FILE, "<", "test-result.txt" or die $!;

	my $result = <FILE>;

	chomp($result);

	return ($result eq $expected);
}
