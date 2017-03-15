## Current emacs config.

*This config will be updated as soon as will needed.*
*This project will never be claim complete or not buggy.*

### Usage:
* Move file "init.el" from "configs" directory, into "~/.emacs.d/" directory;
* Set in file "~/.emacs.d/init.el" full path to file "index.el", which in "configs" directory;
* Set in file "index.el", which in "configs" directory, variable "directory-root", which is full path to "config" directory;
* Set your prefer font, theme, and other configs in "base.el" (for apply theme completely, remove before file "~/.emacs.d/configs/emacs.desktop");
* Overview all keybindings and other stuff in file "base.el", and set your prefer;
* Create your custom config files, and require them in "index.el";
* Now you can walk through code;

### Overview:

* "init.el" - for load "index.el";
* "index.el" - for load your other config files;
* "base.el" - for common emacs configs;

### Screenshot:
![Image of editor](https://raw.githubusercontent.com/sashlex/emacs-config/master/img/screenshot.png)

### Themes license note:
Each theme has own license, for details see in theme file.