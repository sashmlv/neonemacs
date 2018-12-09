## Current emacs config.

*This config will update as needed.*
*This project never claim complete or not buggy.*

### Some features:
* Package autoinstallation;
* Long "undo-tree" history, not lost between sessions;
* "Magit" for git support;
* "Bongo" player;
* Google translate;
* Indium for JavaScript development;
* Full package list in index.el;

### Installation:
* Backup and clear "~/.emacs.d/" directory;
* Move "configs/init.el", into "~/.emacs.d/";
* Set in "~/.emacs.d/init.el" path to "configs/index.el";
* Set in "configs/index.el", variable "configs_dir", which is full path to "configs" directory;
* Set your font, theme, and other in "index.el" ( to apply theme completely, remove "~/.emacs.d/emacs.desktop" );
* View files, and set your parameters;

### Overview:
* "init.el" - load "index.el";
* "index.el" - parameters and load other files;
* "modes" - mode configuration;
* "common" - common config files;
* "modes/base-setup.el" - base config;
* "modes/[some thing else].el" - mode parameters;
* "comon/indentation.el" - indentation settings;
* "common/hooks.el" - hooks and modes;
* "common/theme.el" - theme parameters;
* "common/projects.el" - project specific configs;

### Screenshot:
![Image of editor](https://raw.githubusercontent.com/sashlex/emacs-config/master/img/screenshot.png)

### Theme license note:
Each theme have own license, for details see in theme file.
