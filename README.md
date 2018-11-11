## Current emacs config.

*This config will update as needed.*
*This project never claim complete or not buggy.*

### Some features:
* Packages autoinstallation;
* Long "undo-tree" history, which not lost between sessions;
* Git support with "Magit"
* "Bongo" media player;
* Google translate;
* Indium for JavaScript development;
* All packages you can see in index.el;

### Usage:
* Backup and clear "~/.emacs.d/" directory;
* Move file "configs/init.el", into "~/.emacs.d/";
* Set in "~/.emacs.d/init.el" full path to "configs/index.el";
* Set in "configs/index.el", variable "configs_dir", which full path to "configs" directory;
* Set your prefer font, theme, and other parameters in "index.el" (for apply theme completely, remove file "~/.emacs.d/emacs.desktop");
* Overview keybindings and other stuff in files, set your prefer;
* Create your config file, and require in "index.el";
* If error occur try remove "~/.emacs.d/emacs.desktop";

### Overview:

* "init.el" - for load "index.el";
* "index.el" - parameters and load other config files;
* "modes" - modes configuration;
* "common" - common config files;
* "modes/base-setup.el" - base config;
* "modes/[some thing else].el" - other mode parameters;
* "comon/indentation.el" - indentation settings;
* "common/hooks.el" - hooks and modes;
* "common/theme.el" - theme parameters;
* "common/projects.el" - project specific configs;

### Screenshot:
![Image of editor](https://raw.githubusercontent.com/sashlex/emacs-config/master/img/screenshot.png)

### Theme license note:
Each theme has own license, for details see in theme file.
