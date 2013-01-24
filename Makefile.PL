
use strict;
use warnings;

use 5.006;

use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  "ABSTRACT" => "DAGOLDEN's frequently-used or favorite modules",
  "AUTHOR" => "David Golden <dagolden\@cpan.org>",
  "BUILD_REQUIRES" => {
    "File::Find" => 0,
    "File::Temp" => 0,
    "Test::More" => 0
  },
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30"
  },
  "DISTNAME" => "Task-BeLike-DAGOLDEN",
  "EXE_FILES" => [],
  "LICENSE" => "apache",
  "NAME" => "Task::BeLike::DAGOLDEN",
  "PREREQ_PM" => {
    "App::Ack" => 0,
    "App::ForkProve" => 0,
    "App::Nopaste" => 0,
    "App::Uni" => 0,
    "App::cpanminus" => 0,
    "App::grindperl" => 0,
    "App::mymeta_requires" => 0,
    "Archive::Tar" => 0,
    "Archive::Tar::Wrapper" => 0,
    "Archive::Zip" => 0,
    "Bundle::LWP" => 0,
    "CPAN::DistnameInfo" => 0,
    "CPAN::Mini" => 0,
    "CPAN::Uploader" => 0,
    "CPAN::Visitor" => 0,
    "Capture::Tiny" => 0,
    "Code::TidyAll" => 0,
    "Const::Fast" => 0,
    "DBD::SQLite" => 0,
    "DBI" => 0,
    "Daemon::Daemonize" => 0,
    "Data::Dump::Streamer" => 0,
    "Data::Stream::Bulk" => 0,
    "Devel::Cover" => 0,
    "Devel::NYTProf" => 0,
    "Dist::Zilla" => 4,
    "Dist::Zilla::PluginBundle::DAGOLDEN" => "0.018",
    "Email::MIME" => 0,
    "Email::Sender" => 0,
    "Email::Sender::Simple" => 0,
    "Email::Simple" => 0,
    "Email::Simple::Creator" => 0,
    "File::Find::Rule" => 0,
    "File::Find::Rule::Perl" => 0,
    "File::Slurp" => 0,
    "File::pushd" => 0,
    "Getopt::Lucid" => 0,
    "Git::Wrapper" => 0,
    "HTTP::Tiny" => 0,
    "IO::CaptureOutput" => 0,
    "IO::Socket::SSL" => 0,
    "IPC::Run3" => 0,
    "IPC::System::Simple" => 0,
    "Image::ExifTool" => 0,
    "JSON" => 0,
    "JSON::XS" => 0,
    "LWP::Protocol::https" => 0,
    "List::AllUtils" => 0,
    "Module::Load::Conditional" => 0,
    "Moose" => 0,
    "Net::GitHub::V3" => 0,
    "Pantry" => 0,
    "Path::Class" => 0,
    "Path::Class::Rule" => 0,
    "Path::Iterator::Rule" => 0,
    "Perl::Critic::Lax" => 0,
    "Perl::Version" => 0,
    "Plack" => 0,
    "Pod::Coverage::TrustPod" => 0,
    "Pod::Strip" => 0,
    "Pod::Usage" => 0,
    "Regexp::Common" => 0,
    "Syntax::Keyword::Junction" => 0,
    "Test::CPAN::Meta" => 0,
    "Test::Deep" => 0,
    "Test::Differences" => 0,
    "Test::Fatal" => 0,
    "Test::More" => "0.96",
    "Test::Perl::Critic" => 0,
    "Test::Pod" => "1.41",
    "Test::Pod::Coverage" => "1.08",
    "Test::Routine" => 0,
    "Time::HiRes" => 0,
    "URI" => 0,
    "Vi::QuickFix" => 0,
    "WWW::Mechanize" => 0,
    "XML::RSS" => 0,
    "XML::Simple" => 0,
    "YAML" => 0,
    "autodie" => 0,
    "namespace::autoclean" => 0,
    "strict" => 0,
    "version" => 0,
    "warnings" => 0
  },
  "VERSION" => "0.003",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.56) } ) {
  my $br = delete $WriteMakefileArgs{BUILD_REQUIRES};
  my $pp = $WriteMakefileArgs{PREREQ_PM};
  for my $mod ( keys %$br ) {
    if ( exists $pp->{$mod} ) {
      $pp->{$mod} = $br->{$mod} if $br->{$mod} > $pp->{$mod};
    }
    else {
      $pp->{$mod} = $br->{$mod};
    }
  }
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



