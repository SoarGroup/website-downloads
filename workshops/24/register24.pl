#!/usr/bin/perl

use strict;
use CGI;

my $date = `date +\%D`;
chomp $date;
my $time = `date +\%T`;
chomp $time;
my $query = CGI->new();
my $name = $query->param("name");
my $affiliation = $query->param("affiliation");
my $phone = $query->param("phone");
my $email = $query->param("email");
my $paymethod = $query->param("paymethod");
my $ispresenting = $query->param("ispresenting");
my $pres1time = $query->param("pres1time");
my $pres1timeother = $query->param("pres1timeother");
my $pres1title = $query->param("pres1title");
my $pres2time = $query->param("pres2time");
my $pres2timeother = $query->param("pres2timeother");
my $pres2title = $query->param("pres2title");
my $pres3time = $query->param("pres3time");
my $pres3timeother = $query->param("pres3timeother");
my $pres3title = $query->param("pres3title");
my $tutorial = $query->param("tutorial");
my $otherinfo = $query->param("otherinfo");

#print $query->header(-type => 'text/plain');
print $query->header();

my $formiscomplete = "no";

#debug
#print "name $name\n";
#print "affiliation $affiliation\n";
#print "phone $phone\n";
#print "email $email\n";
#print "paymethod $paymethod\n";
#print "ispresenting $ispresenting\n";
#print "pres1time $pres1time\n";
#print "pres1timeother $pres1timeother\n";
#print "pres1title $pres1title\n";
#print "pres2time $pres2time\n";
#print "pres2timeother $pres2timeother\n";
#print "pres2title $pres2title\n";
#print "pres3time $pres3time\n";
#print "pres3timeother $pres3timeother\n";
#print "pres3title $pres3title\n";
#print "tutorial $tutorial\n";
#print "otherinfo $otherinfo\n";

#check required fields
if ($name && $email && $paymethod && $ispresenting && $tutorial) {

  $formiscomplete = "yes";

}

#display error page if required field(s) missing
if ($formiscomplete eq "no") {

  print $query->start_html("Registration Failed");
  print "<h1>Registration Failed!</h1>\n";

  print "<p>Your registration was not recorded because of one or more errors:</p>\n<ul>";

  if (!$name) {
    print "<li>A name is required.\n";
  }

  if (!$email) {
    print "<li>An email address is required.\n";
  }

  if (!$paymethod) {
    print "<li>You must select if you are going to pay via mail or at the workshop.\n";
  }

  if (!$ispresenting) {
    print "<li>You must indicate if you want to present or not.\n";
  }
  
  if (!$tutorial) {
    print "<li>You must indicate if you plan to attend the tutorials.\n"; 
  }

  print "</ul><p>Please use your browser's back button and fill in\nthe required fields, then submit the form again.  Thanks!</p>\n";

} else {

#record it unless debug
  if ($name eq "debug") {
    print "<p><strong>Hi, Debug!</strong></p>\n";
  } else {
    unless (open REGISTERLOG, ">>registerlog") {
      print $query->start_html("Registration Failed");
      print "<h1>Registration Failed!</h1>\n";
      print "<p>There was an error on the server, your registration wasn't saved, please try again later.</p>\n";
      print "<pre>(Couldn't open log: $!)</pre>";
      print $query->end_html();
      `echo "Register error: $!" | sendmail voigtjr\@umich.edu`;
      die;
    }

    print REGISTERLOG "$date\t$time\t$name\t$affiliation\t$phone\t$email\t$paymethod\t$ispresenting\t$pres1time\t$pres1timeother\t$pres1title\t$pres2time\t$pres2timeother\t$pres2title\t$pres3time\t$pres3timeother\t$pres3title\t$tutorial\t\"$otherinfo\"\n";

    close REGISTERLOG;
    
#mail me
    `echo "Someone registered for the Soar workshop!" | sendmail voigtjr\@umich.edu`;
  
  }
  
#display success and verification message if success

  print $query->start_html("Registration Successful!");
  print "<h1>Registration Successful!</h1>\n";

  print "<p>Thank you, your registration has been recorded.  Look over the following and send us an email if the information changes!</p>\n";

  print "<p>Contact information:<br>\n<ul>";
  print "<li>$name\n";
  if ($affiliation) {
    print "<li>$affiliation\n";
  }
  if ($phone) {
    print "<li>$phone\n";
  }
  print "<li>$email</ul></p>\n";

  if ($paymethod eq "willmail") {
    print "<p>You are going to mail in your registration fee of \$70 by June 1st.</p>\n";
  } 
  
  if ($paymethod eq "onarrival") {
    print "<p>You are going to pay the \$75 registration fee when you arrive at the workshop.</p>\n";
  }

  if ($paymethod eq "invited") {
    print "<p>You are an invited speaker (registration is free).</p>\n";
  }

  if ($ispresenting eq "no") {
    print "<p>You do not plan to talk at the workshop.</p>\n";
  } else {
    print "<p>You plan to talk at the workshop:<br>\n<ul>";
    
    if ($pres1time || $pres1timeother) {
      print "\tPresentation 1: $pres1title, ";
      if ($pres1time > 0) {
         print "<li>$pres1time";
      } else {
         print "<li>$pres1timeother";
      }
      print " mintues.\n";
    }
    if ($pres2time || $pres2timeother) {
      print "\tPresentation 2: $pres2title, ";
      if ($pres2time > 0) {
         print "<li>$pres2time";
      } else {
         print "<li>$pres2timeother";
      }
      print " mintues.\n";
    }
    if ($pres3time || $pres3timeother) {
      print "\tPresentation 3: $pres3title, ";
      if ($pres3time > 0) {
         print "<li>$pres3time";
      } else {
         print "<li>$pres3timeother";
      }
      print " mintues.\n";
    }
    print "</ul></p>\n";
  }

  if ($tutorial eq "beginner") {
    print "<p>You are going to attend the beginner tutorials on June 7-8.</p>\n";
  }
  if ($tutorial eq "advanced") {
    print "<p>You are going to attend the advanced tutorial on June 8.</p>\n";
  }
  if ($tutorial eq "none") {
    print "<p>You are not going to attend the Soar tutorials.</p>\n";
  }

  if ($otherinfo) {
    print "<p>Other information: \"<em>$otherinfo</em>\"</p>";
  }
  
  print "<hr>\n<a href=\"http://winter.eecs.umich.edu/workshop24\">Soar Workshop 24 home</a><br>";
  print "<a href=\"http://sitemaker.umich.edu/soar\">Soar home</a><br>";
}

print $query->end_html();

