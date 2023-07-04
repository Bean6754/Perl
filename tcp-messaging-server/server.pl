#!/usr/bin/perl

# Pragmas.
use IO::Socket;
#use strict;
#use warnings;

# Auto-flush socket.
$| = 1;

# Variables.
my $datestring = localtime();
my $epoch = time();
my $fh = "";
my $filename = "perlmsg_server_$epoch.txt";
my $new_socket = "";
my $socket=new IO::Socket::INET (
LocalHost => 'localhost',
LocalPort => '225522',
Proto => 'tcp',
Listen => 1,
Reuse => 1,
); die "Could not create socket: $! \nThis usually means that the port is already in use by another program on the computer.\n" unless $socket;

# Program.
print "\033[2J";    #clear the screen
while (1) {
  print "Waiting for data from client..\n";
  my $new_socket = $socket->accept();
  while(<$new_socket>) {
    print $_;

    # Write to log file.
    open $fh, '>>', $filename or die "Could not create file: $! \nThis usually means that file-permissions are broken in the current directory.\n";
    print $fh $_;
    close $fh or die "Could not close file: $! \nThis usually means that file-permissions are broken in the current directory.\n";
  }
  print "Session ended with client at ", $datestring, ".\n\n";
}

close($socket);
