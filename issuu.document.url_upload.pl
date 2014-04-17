#!/usr/bin/perl -w
######################################################################
# Libraries
# ---------
# use strict;
require LWP::UserAgent;
require Digest::MD5;
require XML::Simple;

my $xs = XML::Simple->new;
my $ua = LWP::UserAgent->new;
my $issuu_url = 'http://api.issuu.com/1_0';

my @pdfs = ("pdf1.pdf","pdf2.pdf");
foreach my $pdf_to_do (@pdfs) {
  my %issuu_params = (
    apiKey           => 'api key',
    action           => 'issuu.document.url_upload',
    slurpUrl         => 'http://www.yourdomain.com/pdfs/'.$pdf_to_do,
    name             => $pdf_to_do,
    title            => 'title',
    tags             => 'tags',
    commentsAllowed  => 'false',
    description      => 'description',
    downloadable     => 'false',
    infoLink         => 'infolink',
    language         => 'en',
    access           => 'private',
    category         => '000000',
    type             => '007000',
    ratingsAllowed   => 'false',
    format           => 'xml',
  );
  my $sig_string = 'api secret';
  foreach my $isu (sort keys %issuu_params) {
    $sig_string .= $isu . $issuu_params{$isu};
  }
  $md5 = Digest::MD5->new;
  $md5->add($sig_string);
  $issuu_params{'signature'} = $md5->hexdigest;
  my $upload_xml_res = $ua->post($issuu_url, \%issuu_params);
  my $upload_xml = $xs->XMLin($upload_xml_res->content);
  print "Issuu Response " . $upload_xml_res->content;
}
