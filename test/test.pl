#!/usr/bin/perl -Wall
use Cwd;
use Test::Simple tests => 12;

ok(&test("find ./files -name test.txt", "vi './files/test.txt'"), 'single result, no argument');
ok(&test("find ./files -name myfile", "vi './files/dir1/myfile'", "1"), 'single result, specify first');
ok(&test("find ./files -name myfile", "vi './files/dir1/myfile'"), 'multiple results, no argument, should take first');
ok(&test("find ./files -name myfile", "vi './files/dir1/myfile'", "1"), 'multiple results, select first result');
ok(&test("find ./files -name myfile", "vi './files/myfile'", "2"), 'multiple results, select second result');
ok(&test("find ./files -name myfile", "vi './files/myfile'", "4"), 'multiple results,  selection should be divided by the number of files');
ok(&test("find ./files -name myfile", "exit 1", "0"), 'selecting 0, should cause the program to exit');
ok(&test("ls -1 files/quotes", "vi 'filewith\"adoublequote'", "1"), 'result with a double quote');
ok(&test("ls -1 files/quotes", "vi 'filewith'asinglequote'", "2"), 'result with a single quote');
ok(&test("find files/spaces -name 'a file with spaces in the name'", "vi 'files/spaces/a file with spaces in the name'"), 'result with a spaces in the name');
ok(&test("find files -name test.txt", "nano 'files/test.txt'", "1", "nano"), 'Switching editor works');
ok(&test("vyl", "exit 1"), 'vyl shouldn\'t run if vyl was the last command run (things get recursive and weird creating lots of bash shells) ');

# Check the command exits when zero results are found

sub test {
	local($command, $expected, $vyl_args, $editor) = ($_[0], $_[1], $_[2], $_[3]);

	if (! defined $vyl_args) {
		$vyl_args = "";
	}


	unlink "test-result.txt";


	# send the command we want to pretend was last in history
	delete $ENV{"EDITOR"};
	if (defined $editor) {
		$ENV{"EDITOR"} = $editor;
	}
	$ENV{"VYL_TEST"} = $command;
	system("../vyl", $vyl_args);

	open FILE, "<", "test-result.txt" or die $!;

	my $result = <FILE>;

	chomp($result);

	return ($result eq $expected);
}
