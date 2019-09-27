
[Bootstrap](http://getbootstrap.com/) is a handy tool and I use it a lot. I decided to use it with a WordPress plugin I am developing but when I included bootstrap’s css file in my plugin page it blew up the wordpress admin panel’s design. Thus started my journey of hacks to get it working. Here is how it’s done…

This is what my plugin folder looks like:

![](/img/post/2015-03-19-23_17_50-musicloon.png)

- Stylesheets (and a less css file as you will soon find out) live in the “css” folder.
- Bootstrap fonts in the “fonts” folder.
- Javascript in the “scripts” folder.

In your plugin file/installer/whatever you probably have a line which was loading the bootstrap css in the html head element…

`wp_enqueue_style('admin_css_bootstrap', plugins_url('/myplugin/css/bootstrap.min.css'), false, '1.0.0', 'all');`

Get rid of that. You can load the bootstrap javascript file this way but for the stylesheet we begin the hacks…

Create a script called bootstrap-hack.js and load it with your plugin.

`wp_enqueue_script('admin_js_bootstrap_hack', plugins_url('/myplugin/scripts/bootstrap-hack.js'), false, '1.0.0', false);`

The content of that file is this:

<script src="https://gist.github.com/rushfrisby/92f5338e89cfc447943f.js"></script>

As you can see first we are dynamically adding a .less (LESS CSS) file. Next we are loading the LESS Javascript to transform the .less file. Then we are loading any stylesheets that may override bootstrap styles. This is the main part of the hack but there is a little more to it as I will explain.

The content of bootstrap-wrapper.less is this:

<script src="https://gist.github.com/rushfrisby/1f6ff8e5aad43a8feaad.js"></script>

What this does is load the bootstrap css file as LESS and then outputs it with all of the styles wrapped with the “.bootstrap-wrapper” class. This means you have to add a div that wraps your content so that the bootstrap styles will be available to it. It will look something like this:

<script src="https://gist.github.com/rushfrisby/9c6c8be7a4c924d3f8fb.js"></script>

Now back to bootstrap-hack.js… It’s loading less.js file so [download](http://lesscss.org/#download-options) and include it in your scripts folder.

Make sure you load any stylesheets that override bootstrap styles in the same way bootstrap’s CSS is loaded afterwards. You don’t have load the stylesheet using less – we just did that because we needed to wrap bootstrap’s styles with another class so that they won’t conflict with wordpress’ styles. Don’t forget that your overrides must be prefixed with **.bootstrap-wrapper** now as well.


