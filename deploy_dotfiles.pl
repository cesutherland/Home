#!/usr/bin/perl
# quick script to install dotfiles while setting up a new system;
use strict;
use warnings;
use diagnostics;               # useful for debugging;
use feature qw/switch say/;    # beats print;

use Getopt::Long;              # for parsing command-line options;
use File::Spec 'rel2abs';      # for making sure we have absolute paths for files;
use File::Basename;            # for splitting fullpaths into filenames and directories;

my $usage = <<'END';
deploy_dotfiles.pl

Create symlinks for dotfiles when setting up a new system. This script 
assumes that all files and folders in its directory should be symlinked 
to $HOME, with a '.' prepended to the filename. It skips itself and any 
file called 'README', as well as any hidden files in the current directory.

It default mode, it won't clobber files (neither dotfiles nor symlinks 
nor directories), but rather warns about the name conflict. Use the 
nuclear option if you want to blow everything up and replace with fresh 
symlinks.

Usage: 
    deploy_dotfiles.pl --nuke            # overwrite all existing dotfiles with new ones
    deploy_dotfiles.pl --dryrun          # don't deploy anything, just talk about it
    deploy_dotfiles.pl --help            # show this usage information

Supported options:

    -k, --nuke             # it's the only way to be sure
    -d, --dryrun           # make no changes, but display the changes that would have been made
    -h, --help             # show this usage information
    -v, --verbose          # enable chatty output
END

GetOptions(
    'dryrun|n|d'     => \my $dryrun,     # option for --dryrun
    'nuclear|nuke|k' => \my $nuclear,    # option for --nuke
    'help|h|usage|?' => \my $help,       # option for --help
    'verbose|v'      => \my $verbose,    # option for --verbose
) or die "$usage";

say $usage and exit if $help;            # if user requested help/usage info, display it and exit;

my $home                 = $ENV{ 'HOME' };               # grab homedir for currently running user;
my $this_script_fullpath = File::Spec->rel2abs( $0 );    # convert path to fullpath;
my ( $this_script, $parent_dir ) = fileparse( $this_script_fullpath );    # grab name of currently running script;

my @files = grep { !/($this_script|README)$/ } ( <$parent_dir*> );        # grab all files, except this script and any README;

for my $file ( @files ) {                                                 # look at each file/dir in CWD;
    my $dotfile = $home . '/.' . basename( $file );                       # concatenate fullpath to symlink for dotfile;

    if ( $nuclear ) {                                                     # if user requested Clobberbane;
        unlink $dotfile if -e $dotfile and not $dryrun;                   # nuke that pre-existing file;
    }

    say "Would like to create symlink: '$dotfile' -> '$file'" and next if $dryrun;    # chatty output;

    say "Not overwriting symlink for dotfile at $dotfile ..." and next                # warn on error;
      if -l $dotfile;                                                                 # if symlink already exists;

    say "Not overwriting preexisting dotfile at $dotfile ..." and next                # warn on error;
      if -f $dotfile or -d $dotfile;                                                  # if file or directory exists;

    if ( symlink( $file, $dotfile ) ) {                                               # create symlink for dotfile;
        say "Created symlink: '$dotfile' -> '$file'" if $verbose;                     # chatty output;
    }
    else {                                                                            # if symlink creation failed;
        warn "Could not create symlink for dotfile at $dotfile $!";                   # warn on error;
    }
}
