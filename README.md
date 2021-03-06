integritycheck
==============

This is a little utility program I use to check the integrity of my important
data. The binary is called `ic` because I invoke it frequently and it is much
easier to type than 'integritycheck'.

The user interface of `ic` is somewhat similar to version control systems
like `git` or `svn`. Like most version control systems, ic works on a "repository".
In ic's case, the repository is just any directory on your disk that contains the data
you want to monitor. Note that ic will never touch any of the files in the
repository - it is a read-only tool with regards to your data directory.

The command line interface should also be intuitive to use if you have used a
version control system before: There is a `status` command that displays any
unacknowledged modifications to the repository, an `ack` command that you can use
to acknowledge changes in the repository (this is the equivalent to svn or git's
`commit`) and a `log` command that displays the history of changes to the
repository.

However, unlike a version control system, ic does not actually store any copies
of your data! It merely stores an index containing the checksums of all files
as well as some other metadata. This means that it can only check the integrity
of your data and tell you if any of the files are corrupted or missing. Now, in
case there *are* corrupted or missing files, ic is *not* able to restore them on
its own; you have to retrieve them from your backup manually.

The upside of this approach is that it allows you to use ic in addition to your
existing backup or version control system. It also allows ic to handle very large
repositories, such as a photo collection or a library of gamedev assets.


Build & Installation
--------------------

Before you can compile `ic`, you have to install the rust compiler and the
cargo package manager.

To build `ic`, check out this repo and run:

    $ make

To install the `ic` binary into your system, execute this command:

    $ make install

If you have modified the source code, run the test suite:

    $ make test


Usage
-----

    usage: ic <command> [options]
    Yet another file integrity monitoring tool.

    global options:
      -d,--data_dir=PATH     Set the path of the repository/data directory
                             default: '.'
      -x,--index_dir=PATH    Set the path of the index directory. Note that this
                             path is relative to the data directory. Absolute
                             paths are allowed. default: '.fh'
      --progress=[on/off]    Turn progress reporting on stderr on or off
      --colours=[on/off]     Turn coloured terminal output on or off. default: on
      -v,--verbose           Enable verbose output,
      -h,--help              Print this help message and exit

    commands:
      init      Create a new index file.
      status    Compare the current state of the repository to the latest snapshot
      ack       Acknowledge changes to files in the repository and create a new snapshot
      log       Display a historical log of snapshots and changes to the repository
      verify    Perform a full check of the repository's integrity
      version   Print the version of this program and exit
      help      Print the help message for one of the commands and exit


License
-------

    Copyright 2018 Paul Asmuth <paul@asmuth.com>

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
