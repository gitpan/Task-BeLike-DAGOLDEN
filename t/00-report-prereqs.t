#!perl

use strict;
use warnings;

use Test::More tests => 1;

use ExtUtils::MakeMaker;
use File::Spec::Functions;
use List::Util qw/max/;

my @modules = qw(
  Acme::require::case
  App::Ack
  App::ForkProve
  App::Nopaste
  App::Uni
  App::cpanminus
  App::grindperl
  App::mymeta_requires
  Archive::Tar
  Archive::Tar::Wrapper
  Archive::Zip
  Benchmark::Forking
  Bundle::LWP
  CPAN::DistnameInfo
  CPAN::Mini
  CPAN::Uploader
  CPAN::Visitor
  Capture::Tiny
  Code::TidyAll
  Const::Fast
  DBD::SQLite
  DBI
  Daemon::Daemonize
  Data::Dump::Streamer
  Data::Stream::Bulk
  Devel::Cover
  Devel::NYTProf
  Dist::Zilla
  Dist::Zilla::PluginBundle::DAGOLDEN
  Dumbbench
  Email::MIME
  Email::Sender
  Email::Sender::Simple
  Email::Simple
  Email::Simple::Creator
  ExtUtils::MakeMaker
  File::Find
  File::Find::Rule
  File::Find::Rule::Perl
  File::Slurp
  File::Spec::Functions
  File::Temp
  File::pushd
  Getopt::Lucid
  Git::Wrapper
  HTTP::CookieJar
  HTTP::Tiny
  IO::CaptureOutput
  IO::Socket::SSL
  IPC::Run3
  IPC::System::Simple
  Image::ExifTool
  JSON
  JSON::XS
  LWP::Protocol::https
  List::AllUtils
  List::Util
  Module::Load::Conditional
  Moose
  MooseX::Types
  MooseX::Types::Path::Tiny
  Mozilla::CA
  Net::GitHub
  Pantry
  Path::Class
  Path::Class::Rule
  Path::Iterator::Rule
  Path::Tiny
  Perl::Critic::Lax
  Perl::Version
  Plack
  Pod::Coverage::TrustPod
  Pod::Strip
  Pod::Usage
  Regexp::Common
  Syntax::Keyword::Junction
  Test::CPAN::Meta
  Test::Deep
  Test::Differences
  Test::FailWarnings
  Test::Fatal
  Test::More
  Test::Perl::Critic
  Test::Pod
  Test::Pod::Coverage
  Test::Roo
  Test::Routine
  Time::HiRes
  URI
  Unicode::UTF8
  Vi::QuickFix
  WWW::Mechanize
  XML::RSS
  XML::Simple
  YAML
  autodie
  namespace::autoclean
  perl
  strict
  version
  warnings
);

# replace modules with dynamic results from MYMETA.json if we can
# (hide CPAN::Meta from prereq scanner)
my $cpan_meta = "CPAN::Meta";
if ( -f "MYMETA.json" && eval "require $cpan_meta" ) { ## no critic
  if ( my $meta = eval { CPAN::Meta->load_file("MYMETA.json") } ) {
    my $prereqs = $meta->prereqs;
    delete $prereqs->{develop};
    my %uniq = map {$_ => 1} map { keys %$_ } map { values %$_ } values %$prereqs;
    $uniq{$_} = 1 for @modules; # don't lose any static ones
    @modules = sort keys %uniq;
  }
}

my @reports = [qw/Version Module/];

for my $mod ( @modules ) {
  next if $mod eq 'perl';
  my $file = $mod;
  $file =~ s{::}{/}g;
  $file .= ".pm";
  my ($prefix) = grep { -e catfile($_, $file) } @INC;
  if ( $prefix ) {
    my $ver = MM->parse_version( catfile($prefix, $file) );
    $ver = "undef" unless defined $ver; # Newer MM should do this anyway
    push @reports, [$ver, $mod];
  }
  else {
    push @reports, ["missing", $mod];
  }
}

if ( @reports ) {
  my $vl = max map { length $_->[0] } @reports;
  my $ml = max map { length $_->[1] } @reports;
  splice @reports, 1, 0, ["-" x $vl, "-" x $ml];
  diag "Prerequisite Report:\n", map {sprintf("  %*s %*s\n",$vl,$_->[0],-$ml,$_->[1])} @reports;
}

pass;

# vim: ts=2 sts=2 sw=2 et:
