# Database.

use strict;
use warnings;

my $random_number = rand();
my $filename = 'database.txt';
open(my $fh, '>', $filename) or die "Could not open file '$filename' $!";
print $fh $random_number;
close $fh;
print "Your ID is: ", $random_number;

print "\n";

if (open(my $fh, '<:encoding(UTF-8)', $filename)) {
  while (my $row = <$fh>) {
    chomp $row;
    print "$row\n";
  }
} else {
  warn "Could not open file '$filename' $!";
}
