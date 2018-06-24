## Current emacs config.

*This config will be updated as soon as will needed.*
*This project will never be claim complete or not buggy.*

### Some features:
* Packages autoinstallation;
* Long "undo-tree" history, that not losts between sessions;
* Git support through "Magit"
* "Bongo" media player;
* Google translate;
* Indium for JavaScript development;
* all installed packages you can see in index.el ...

### Usage:
* Backup and clear your "~/.emacs.d/" directory;
* Move file "init.el" from "configs" directory, into "~/.emacs.d/" directory;
* Set in file "~/.emacs.d/init.el" full path to file "index.el", which in "configs" directory;
* Set in file "index.el", which in "configs" directory, variable "configs_dir", which is full path to "configs" directory;
* Set your prefer font, theme, and other configs in "index.el" (for apply theme completely, remove file "~/.emacs.d/emacs.desktop");
* Overview all keybindings and other stuff in each config file, and set your prefer;
* Create your custom config file, and require it in "index.el";
* If some error will occur try remove ~/.emacs.d/emacs.desktop
* Now you can walk through code;

### Overview:

* "init.el" - for load "index.el";
* "index.el" - parameters and loading other config files;
* "modes" - in this directory placed files, with some modes configuration;
* "common" - in this directory placed common config files;
* "modes/base-setup.el" - base configs;
* "modes/[some thing else].el" - other mode setup;
* "comon/indentation.el" - indentation settings;
* "common/hooks.el" - hooks and modes;
* "common/theme.el" - theme parameters;

### Screenshot:
![Image of editor](https://raw.githubusercontent.com/sashlex/emacs-config/master/img/screenshot.png)

### Theme license note:
Each theme has own license, for details see in theme file.

### Notes:

* After addition new yasnippets, make: *M-x, yas-reload-all*
