# GrapesJS Filestack

## Usage

```html
<link href="path/to/grapes.min.css" rel="stylesheet"/>
<link href="path/to/grapesjs-plugin-filestack.css" rel="stylesheet"/>

<script src="path/to/grapes.min.js"></script>
<script src="path/to/grapesjs-plugin-filestack.min.js"></script>

<div id="gjs"></div>

<script type="text/javascript">
  var editor = grapesjs.init({
      container : '#gjs',
      plugins: ['gjs-plugin-filestack'],
      pluginsOpts: {
        'gjs-plugin-filestack': {/* ...options */}
      }
  });
</script>
```

