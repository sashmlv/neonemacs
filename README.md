## Current emacs config.

*This config will be updated as soon as will needed.*
*This project will never be claim complete or not buggy.*

### Features:
* Packages autoinstallation;
* Long undo-tree history, that not losts between sessions;
* Tern mode for javascript development (now support only linux systems);
* Multiple cursors;
* ...

### Requirements:
* Emacs >= 25

### Usage:
* Clean your "~/.emacs.d/" directory;
* Move file "init.el" from "configs" directory, into "~/.emacs.d/" directory;
* Set in file "~/.emacs.d/init.el" full path to file "index.el", which in "configs" directory;
* Set in file "index.el", which in "configs" directory, variable "configs_dir", which is full path to "configs" directory;
* Set your prefer font, theme, and other configs in "index.el" (for apply theme completely, remove file "~/.emacs.d/emacs.desktop");
* Overview all keybindings and other stuff in each config file, and set your prefer;
* Create your custom config file, and require it in "index.el";
* Now you can walk through code;
* If some error will occurred try remove ~/.emacs.d/emacs.desktop

### Overview:

* "init.el" - for load "index.el";
* "index.el" - parameters and loading other config files;
* "modes-setup" - in this directory placed files, with some modes configuration;
* "common" - in this directory placed common config files;
* "modes-setup/base-modes-setup.el" - available modes setup;
* "modes-setup/custom-modes-setup.el" - custom modes setup;
* "comon/indentation.el" - indentation settings;
* "common/hooks.el" - hooks and modes;

### Screenshot:
![Image of editor](https://raw.githubusercontent.com/sashlex/emacs-config/master/img/screenshot.png)

### Themes license note:
Each theme has own license, for details see in theme file.

### Some keybindings:

##### Move line:
* "M-P" - move-line-up;
* "M-N" - move-line-down;

##### Multiple cursors:
* "C->" - mark-next-like-this;
* "C-<" - mark-previous-like-this;
* "C-S-c C-S-c" - edit-lines;

##### Undo redo:
* "C-_, C-/" -  undo changes;
* "M-_, C-?" -  redo changes;
* "M-x undo-tree-save-history" - manually save undo history to file;
* "M-x undo-tree-load-history" - manually load undo history from file;