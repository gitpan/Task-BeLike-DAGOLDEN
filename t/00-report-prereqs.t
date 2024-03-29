#!perl

use strict;
use warnings;

# This test was generated by Dist::Zilla::Plugin::Test::ReportPrereqs 0.011

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
  App::grindperl
  App::mymeta_requires
  Archive::Tar
  Archive::Tar::Wrapper
  Archive::Zip
  Benchmark::Forking
  Bundle::LWP
  CPAN::DistnameInfo
  CPAN::Meta
  CPAN::Meta::Requirements
  CPAN::Mini
  CPAN::Uploader
  CPAN::Visitor
  Capture::Tiny
  Code::TidyAll
  Const::Fast
  DBD::SQLite
  DBI
  Daemon::Daemonize
  Data::Stream::Bulk
  Devel::Cover
  Devel::NYTProf
  Dist::Zilla
  Dist::Zilla::PluginBundle::DAGOLDEN
  Dist::Zooky
  Dumbbench
  Email::MIME
  Email::Sender
  Email::Sender::Simple
  Email::Simple
  Email::Simple::Creator
  ExtUtils::MakeMaker
  File::Find::Rule
  File::Find::Rule::Perl
  File::Slurp
  File::Spec::Functions
  File::pushd
  Getopt::Lucid
  Git::Wrapper
  HTTP::CookieJar
  HTTP::Tiny
  IO::CaptureOutput
  IO::Prompt::Tiny
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
  TAP::Harness::Restricted
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
  superclass
  version
  warnings
);

my %exclude = map {; $_ => 1 } qw(

);

my ($source) = grep { -f $_ } qw/MYMETA.json MYMETA.yml META.json/;
$source = "META.yml" unless defined $source;

# replace modules with dynamic results from MYMETA.json if we can
# (hide CPAN::Meta from prereq scanner)
my $cpan_meta = "CPAN::Meta";
my $cpan_meta_req = "CPAN::Meta::Requirements";
my $all_requires;
if ( -f $source && eval "require $cpan_meta" ) { ## no critic
  if ( my $meta = eval { CPAN::Meta->load_file($source) } ) {

    # Get ALL modules mentioned in META (any phase/type)
    my $prereqs = $meta->prereqs;
    delete $prereqs->{develop} if not $ENV{AUTHOR_TESTING};
    my %uniq = map {$_ => 1} map { keys %$_ } map { values %$_ } values %$prereqs;
    $uniq{$_} = 1 for @modules; # don't lose any static ones
    @modules = sort grep { ! $exclude{$_} } keys %uniq;

    # If verifying, merge 'requires' only for major phases
    if ( 1 ) {
      $prereqs = $meta->effective_prereqs; # get the object, not the hash
      if (eval "require $cpan_meta_req; 1") { ## no critic
        $all_requires = $cpan_meta_req->new;
        for my $phase ( qw/configure build test runtime develop/ ) {
          $all_requires->add_requirements(
            $prereqs->requirements_for($phase, 'requires')
          );
        }
      }
    }
  }
}

my @reports = [qw/Version Module/];
my @dep_errors;
my $req_hash = defined($all_requires) ? $all_requires->as_string_hash : {};

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

    if ( 1 && $all_requires ) {
      my $req = $req_hash->{$mod};
      if ( defined $req && length $req ) {
        if ( ! defined eval { version->parse($ver) } ) {
          push @dep_errors, "$mod version '$ver' cannot be parsed (version '$req' required)";
        }
        elsif ( ! $all_requires->accepts_module( $mod => $ver ) ) {
          push @dep_errors, "$mod version '$ver' is not in required range '$req'";
        }
      }
    }

  }
  else {
    push @reports, ["missing", $mod];

    if ( 1 && $all_requires ) {
      my $req = $req_hash->{$mod};
      if ( defined $req && length $req ) {
        push @dep_errors, "$mod is not installed (version '$req' required)";
      }
    }
  }
}

if ( @reports ) {
  my $vl = max map { length $_->[0] } @reports;
  my $ml = max map { length $_->[1] } @reports;
  splice @reports, 1, 0, ["-" x $vl, "-" x $ml];
  diag "\nVersions for all modules listed in $source (including optional ones):\n",
    map {sprintf("  %*s %*s\n",$vl,$_->[0],-$ml,$_->[1])} @reports;
}

if ( @dep_errors ) {
  diag join("\n",
    "\n*** WARNING WARNING WARNING WARNING WARNING WARNING WARNING WARNING ***\n",
    "The following REQUIRED prerequisites were not satisfied:\n",
    @dep_errors,
    "\n"
  );
}

pass;

# vim: ts=2 sts=2 sw=2 et:
