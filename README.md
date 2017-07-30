# dotfiles-example

Example use of dotfiles https://github.com/neechbear/dotfiles.git project to
selectively symlink files into your home directory.


## Installation

  1. First, fork this repository to your own GitHub account.

  2. Optionally (reccomended), set the repository to be private.

  3. Clone your forked repository, and then run the installation.

```bash
git clone https://github.com/$YOUR_USERNAME/dotfiles-example.git ~/src/rcfiles
~/src/rcfiles/bin/dotfiles.sh install
~/src/rcfiles/bin/dotfiles-symlink-files ~/src/rcfiles ~
```

  4. If clone the repository in to a different location, you should modify
     either (or both) `bin/rcup`, `.profile.d/010-environment-common.sh` files
     to reflect the new path.
     
  5. Running the `bin/rcup` command will pull any updates from your upstream
     origin Git repository, and then run `bin/dotfiles-symlink-files` for you.
     It is used in combination with the `.profile.d/999-rcup.bash` profile
     script, which will periodically run the `bin/rcup` command for you upon
     login, to ensure that your rcfiles are always kept up-to-date.


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

