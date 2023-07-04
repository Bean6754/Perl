#!/usr/bin/perl

# Pragmas.
use IO::Socket;
#use strict;
#use warnings;

# Auto-flush socket.
$| = 1;

# Variables.
my $data = "";
my $data_raw = "";
my $datestring = localtime();
my $epoch = time();
my $fh = "";
my $filename = "perlmsg_client_$epoch.txt";
my $socket=new IO::Socket::INET (
PeerHost => 'localhost',
PeerPort => '225522',
Proto => 'tcp',
); die "Could not create socket: $! \nThis usually means that the server has not been started yet.\n" unless $socket;

# Program.
print "\033[2J";    #clear the screen
print "Connected at ", $datestring, ".\n";
print "Enter data to send.\n";
while (1) {
  my $data = <STDIN>;
  $data_raw = $data; # Preserve raw data (with line-endings before chomp removes them) for the log file.
  chomp $data;
  print $socket "Data received from user: '$data'\n";

  # Write to log file.
  open $fh, '>>', $filename or die "Could not create file: $! \nThis usually means that file-permissions are broken in the current directory.\n";
  print $fh $data_raw;
  close $fh or die "Could not close file: $! \nThis usually means that file-permissions are broken in the current directory.\n";
}

close($socket);
