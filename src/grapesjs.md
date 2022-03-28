# GrapesJS

<p align="center"><img src="http://grapesjs.com/img/grapesjs-front-page-m.jpg" alt="GrapesJS" width="500" align="center"/></p>


GrapesJS is a free and open source Web Builder Framework which helps building HTML templates, faster and easily, to be delivered in sites, newsletters or mobile apps. Mainly, GrapesJS was designed to be used inside a [CMS] to speed up the creation of dynamic templates. To better understand this concept check the image below

<br/>
<p align="center"><img src="http://grapesjs.com/img/gjs-concept.png" alt="GrapesJS - Style Manager" height="400" align="center"/></p>
<br/>

Generally any 'template system', that you'd find in various applications like CMS, is composed by the **structure** (HTML), **style** (CSS) and **variables**, which are then replaced with other templates and contents on server-side and rendered on client.

This demos show examples of what is possible to achieve:<br/>
Webpage Demo - http://grapesjs.com/demo.html<br/>
Newsletter Demo - http://grapesjs.com/demo-newsletter-editor.html<br/>

## Features

| Blocks | Style Manager | Layer Manager |
|--|--|--|
|<img  src="http://grapesjs.com/img/sc-grapesjs-blocks-prp.jpg"  alt="GrapesJS - Block Manager"  height="400"  align="center"/>|<img  src="http://grapesjs.com/img/sc-grapesjs-style-2.jpg"  alt="GrapesJS - Style Manager"  height="400"  align="center"/>|<img  src="http://grapesjs.com/img/sc-grapesjs-layers-2.jpg"  alt="GrapesJS - Layer Manager"  height="400"  align="center"/>|

| Code Viewer | Asset Manager |
|--|--|
|<img  src="http://grapesjs.com/img/sc-grapesjs-code.jpg"  alt="GrapesJS - Code Viewer"  height="300"  align="center"/>|<img  src="http://grapesjs.com/img/sc-grapesjs-assets-1.jpg"  alt="GrapesJS - Asset Manager"  height="250"  align="center"/>|

* Local and remote storage

* Default built-in commands (basically for creating and managing different components)


## Download

* CDNs
  * UNPKG (resolves to the latest version)
    * `https://unpkg.com/grapesjs`
    * `https://unpkg.com/grapesjs/dist/css/grapes.min.css`
  * CDNJS (replace `X.X.X` with the current version)
    * `https://cdnjs.cloudflare.com/ajax/libs/grapesjs/X.X.X/grapes.min.js`
    * `https://cdnjs.cloudflare.com/ajax/libs/grapesjs/X.X.X/css/grapes.min.css`
* NPM
  * `npm i grapesjs`
* GIT
  * `git clone https://github.com/artf/grapesjs.git`

For the development purpose you should follow instructions below.

## Usage

```html
<link rel="stylesheet" href="path/to/grapes.min.css">
<script src="path/to/grapes.min.js"></script>

<div id="gjs"></div>

<script type="text/javascript">
  var editor = grapesjs.init({
      container : '#gjs',
      components: '<div class="txt-red">Hello world!</div>',
      style: '.txt-red{color: red}',
  });
</script>
```

For a more practical example I'd suggest looking up the code inside this demo: http://grapesjs.com/demo.html

## Development

Clone the repository and install all the necessary dependencies (`yarn` is highly recommended)

```sh
$ git clone https://github.com/artf/grapesjs.git
$ cd grapesjs
$ yarn
```

Start the dev server

```sh
$ yarn start
```

Once the development server is started you should be able to reach the demo page (eg. `http://localhost:8080`)

## Documentation

Check the getting started guide here: [Documentation]

## API

API References could be found here: [API-Reference]

## Testing

```sh
$ yarn test
```
## Plugins

**IMAGES**
[GrapesJs Tui-image-editor](grapesjs/grapesjs-tui-image-editor.md) - GrapesJS TOAST UI Image Editor
[GrapesJS Aviary](grapesjs-aviary.md) - Add the Aviary Image Editor (dismissed, use the plugin below instead)

**FILES**
[Grapesjs Plugin Export](https://github.com/artf/grapesjs-plugin-export) - Export GrapesJS templates in a zip archive
[GrapesJs Plugin Filestack](grapesjs/grapesjs-plugin-filestack.md) - Add Filestack uploader in Asset Manager

**STYLES**
[GrapesJs Style-bg](grapesjs/grapesjs-style-bg.md) - Full-stack background style property type, with the possibility to add images, colors, and gradients
[GrapesJs Style-filter](grapesjs/grapesjs-style-filter.md) - Add `filter` type input to the Style Manager

**BLOCKS**
[GrapesJs Blocks-basic](grapesjs/grapesjs-blocks-basic.md) - Basic set of blocks
[GrapesJs Blocks-flexbox](grapesjs/grapesjs-blocks-flexbox.md) - Add the flexbox block
[GrapesJs Navbar](grapesjs/grapesjs-navbar.md) - Simple navbar component
[GrapesJs Lory-slider](grapesjs/grapesjs-lory-slider.md) - Slider component by using [lory](https://github.com/meandmax/lory)
[GrapesJs Tabs](grapesjs/grapesjs-tabs.md) - Simple tabs component

**FORMS**
[GrapesJs Plugin-forms](grapesjs/grapesjs-plugin-forms.md) - Set of form components and blocks

**MISC**
[GrapesJs Tooltip](grapesjs/grapesjs-tooltip.md) - Simple, CSS only, tooltip component for GrapesJS
[GrapesJs Touch](grapesjs/grapesjs-touch.md) - Enable touch support

**CODE AND DATA**
[GrapesJs Custom-code](grapesjs/grapesjs-custom-code.md) - Embed custom code
[GrapesJs Firestore](grapesjs/grapesjs-firestore.md) - Storage wrapper for [Cloud Firestore](https://firebase.google.com/docs/firestore)

**PRESETS**
[grapesjs-preset-webpage](grapesjs/grapesjs-preset-webpage.md) - Webpage Builder
[grapesjs-preset-newsletter](grapesjs/grapesjs-preset-newsletter.md) - Newsletter Builder

**MJML**
[grapesjs-mjml](grapesjs/grapesjs-mjml.md) - Newsletter Builder with MJML components


### Some other Extensions

* [grapesjs-plugin-ckeditor](https://github.com/artf/grapesjs-plugin-ckeditor) - Replaces the built-in RTE with CKEditor
* [grapesjs-aviary](https://github.com/artf/grapesjs-aviary) instead)
* [grapesjs-component-countdown](https://github.com/artf/grapesjs-component-countdown) - Simple countdown component
* [grapesjs-style-gradient](https://github.com/artf/grapesjs-style-gradient) - Add `gradient` type input to the Style Manager
* [grapesjs-indexeddb](https://github.com/artf/grapesjs-indexeddb) - Storage wrapper for IndexedDB
* [grapesjs-parser-postcss](https://github.com/artf/grapesjs-parser-postcss) - Custom CSS parser for GrapesJS by using 
* [PostCSS](https://github.com/postcss/postcss)
* [grapesjs-typed](https://github.com/artf/grapesjs-typed) - Typed component made by wrapping Typed.js library


Find out more about plugins here: [Creating plugins](https://grapesjs.com/docs/modules/Plugins.html)

[Documentation]: <https://grapesjs.com/docs/>
[API-Reference]: <https://grapesjs.com/docs/api/>
[CMS]: <https://it.wikipedia.org/wiki/Content_management_system>