#!C:/Strawberry/perl/bin/perl.exe

use strict;
use warnings;
use CGI;

my $q = CGI->new;

my $name  = $q->param('name')  // '';
my $email = $q->param('email') // '';

open(my $fh, '>>', 'C:/xampp/cgi-bin/submission.txt')
    or die "Cannot open file";

print $fh "$name\t$email\n";
close $fh;

print $q->header('text/html; charset=UTF-8');
print "<h2>Your information has successfully been registered. Thank you!</h2>";
