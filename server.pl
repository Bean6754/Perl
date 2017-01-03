use strict;
use warnings;
use Term::ANSIColor;
use IO::Socket::INET;
 
# auto-flush on socket
$| = 1;
 
# creating a listening socket
my $socket = new IO::Socket::INET (
    LocalHost => '127.0.0.1',
    LocalPort => '80',
    Proto => 'tcp',
    Listen => 5,
    Reuse => 1
);
die "cannot create socket $!\n" unless $socket;
print color('red');
print "Server waiting for client connection on port '80'\n";
print color('reset'); 

while(1)
{
    # waiting for a new client connection
    my $client_socket = $socket->accept();
 
    # get information about a newly connected client
    my $client_address = $client_socket->peerhost();
    my $client_port = $client_socket->peerport();
    print color('green');
    print "connection from $client_address:$client_port\n";
    print color('reset'); 

    # read up to 1024 characters from the connected client
    my $data = "";
    $client_socket->recv($data, 1024);
    print "received data: $data\n";
 
    # write response data to the connected client
    $data =
	localtime() . 
	"\nHello from Perl";
    $client_socket->send($data);
 
    # notify client that response has been sent
    shutdown($client_socket, 1);
}
 
$socket->close(); 
