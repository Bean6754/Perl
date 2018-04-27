use strict;
use warnings;

print "\n\nWARNING!\nThis program is currently untested.\n\n";
print "Press ENTER to exit:";
<STDIN>;

my $mnt = "root";

mkdir($mnt) or die "$!";
chdir($mnt) or die "$!";

if (fork()) {
    wait;
} else {
    chroot($mnt);
    exit;
}

chdir("..") or die "$!";
rmdir($mnt) or die "$!";
