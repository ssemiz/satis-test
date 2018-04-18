# OXID Flow Sass

The standard OXID Flow theme is based on LESS. In our development evironment we use Sass/PostCSS. This project is a simple port of the Flow theme to Sass/Scss. It should behave exactly as the original LESS version.

**Attention:** this theme _only_ reproduces the CSS. It doesn't touch the JavaScript or the Smarty templates.

It includes the Flow dependencies (installed with Bower):

- Bootstrap 3 ([sass port](https://github.com/twbs/bootstrap-sass))
- Font Awesome 4.5.0
- Photoswiper

Further the Flow `theme.less` file was splitted in smaller files.

## Features

- Can be build with libSass for faster build time
- `.editorconfig` for sane whitespaces, etc. see [EditorConfig](http://editorconfig.org/)
- `.stylelintrc` for Scss linting
- Handles Vendor-Prefixes with Autoprefixer and [`browserlist`](https://github.com/ai/browserslist#config-file) as a config
- [Include-Media](http://include-media.com/) for Breakpoint Sass-Mixin
- PostCSS inlining of images and SVGs

## Installation

You need [node](https://nodejs.org/), [grunt](http://gruntjs.com/), [bower](http://bower.io/) and [libsass](http://libsass.org/) (sassc) to run the build process.

Install node dependencies with `$ npm install` and frontend dependencies with `$ bower install`.

Inside `package.json` configure the `oxidtheme` path to which directory you want to copy the compiled CSS (see `grunt/tasks/copy.js` taks `copy:oxid`). We usally have the OXID and theme code in seperate directories, see the folder structure below.

Use `$ grunt` to build the CSS or `$ grunt watch` to listen for changes.


### Folder strucutre

For a more convenient deployment/building we usually store the Sass workflow outsite the actual OXID theme folder and copy the compiled CSS into the OXID `out/<theme>/` folder with grunt.

    ├── README.md
    ├── deploy/
    ├── docker/
    ├── docker-compose.yml
    └── src/
        ├── oxid/      # oxid is installed here
        └── flow-sass/ # oxid-flow-sass is located here

## Notes

- Twitter Bootstrap 3 is no [longer maintained](https://github.com/twbs/bootstrap/issues/20631) and 4 is still an alpha release. I thought about switching the whole theme to Bootstrap 4 (which gets us `rem`, `flexbox`, …) but the HTML differences between v3 and v4 are huge, you would need to change all Flow Smarty templates by hand which would be a huge undertaking as well a pain to incorparate future OXID updates. Additionally you lose compatibillity with popular OXID extensions. So v3 it is.


## Meta

Jonathan Ströbele ([@stroebjo](https://twitter.com/stroebjo)) - [pbi planungsbüro INTERNET GmbH](https://planungsbuero.de/)

