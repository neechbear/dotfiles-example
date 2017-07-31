# dotfiles-example

Example use of dotfiles https://github.com/neechbear/dotfiles.git project to
selectively symlink files into your home directory.

Only the `bin/dotfiles.sh` contains the actual `dotfiles` software (as sourced
from https://github.com/neechbear/dotfiles). All other files in this project are
purely optional example files indented to demonstrate one possible use case.


## Installation

  1. Create a new repository named `rcfiles` on your preferred Git hosting
     solution. A private repository is reccomended if you plan to customise
     your rcfiles with any sensitive data.

  2. Download the `dotfiles-example` files.

```bash
$ mkdir -p ~/src/rcfiles
$ cd ~/src/rcfiles
$ curl -sSL https://github.com/neechbear/dotfiles-example/archive/master.tar.gz | tar -zxvf - --strip=1
```

  3. Add the files to your new `rcfiles` Git repository.

```bash
$ cd ~/src/rcfiles
$ git add -A .
$ git commit -a -m 'Initial import from dotfiles-example'
$ git remote add origin ssh://git@github.com/$YOUR_GITHUB_USERNAME/rcfiles.git
$ git push -u origin master
```

  4. Run the installation command, and create the symlinks into your home
     directory.

```bash
$ ~/src/rcfiles/bin/dotfiles.sh install
$ ~/src/rcfiles/bin/dotfiles-symlink-files ~/src/rcfiles ~
```

  4. If you clone the repository in to a different location, you should modify
     either (or both) `bin/rcup`, `.profile.d/010-environment-common.sh` files
     to reflect the new path.


## Usage
     
Simply add and commit files to your Git repository, which will be symlinked in
to your target directory for you. (In this example, symlinks will be placed into
your home directory, pointing to the rcfiles and scripts located under
`~/src/rcfiles`).

Running the `bin/rcup` command will pull any updates from your upstream origin
Git repository, and then run `bin/dotfiles-symlink-files` for you. It is used
in combination with the `.profile.d/999-rcup.bash` profile script, which will
periodically run the `bin/rcup` command for you upon login, to ensure that your
rcfiles are always kept up-to-date.

See the other symlinked commands in `bin`, and example files in this repository
for further guidance.

More examples can be found at https://github.com/neechbear/dotfiles
[README.md](https://github.com/neechbear/dotfiles/blob/master/README.md).


## YouTube Video Demonstration

TODO: Embed video here.


## License

MIT License

Copyright (c) 2016 Nicola Worthington <nicolaw@tfb.net>

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

