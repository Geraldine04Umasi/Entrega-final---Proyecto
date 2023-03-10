#!/usr/bin/perl -w
use strict;
use warnings;
use CGI;
use DBI;

my $q = CGI->new;

print $q->header('text/XML');
my $user = 'alumno';
my $password = 'pweb1';
my $dsn = "DBI:MariaDB:database=pweb1;host=192.168.3.28";
my $dbh = DBI->connect($dsn, $user, $password) or die("No se pudo conectar!");
my $userName = $q->param("userName");
my $title = $q->param("title");

my $sth = $dbh->prepare("DELETE FROM Articles WHERE owner=? AND title=?");
$sth->execute($userName,$title);
$sth->finish;
print "<?xml version='1.0' encoding='UTF-8'?>\n";
print" <article>\n";
print "   <owner>$userName</owner>\n";
print "   <title>$title</title>\n";
print "</article>\n";
$dbh->disconnect;
