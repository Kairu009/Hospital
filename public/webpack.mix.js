const mix = require('laravel-mix');

mix.js('resources/js/app.js', 'public/js')
   .copy('resources/css/app.css', 'public/css/app.css');
