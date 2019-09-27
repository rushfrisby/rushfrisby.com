
Today I’ve updated [Bundler.NET](http://bundler.codeplex.com/) to include more optimization of images. You can now take every image in your CSS and create a sprite automatically. Here is how it works… (example solution download below)

First the CSS:

.clear { clear: both; } .img { height: 48px; width: 48px; display: block; margin: 10px; float: left; } .img-browser { background: url('images/browser.png?embed') no-repeat 0 0; } .img-clock { background: url('images/clock.png?embed') no-repeat 0 0; } .img-kdf { background: url('images/kdf.png?embed') no-repeat 0 0; } .img-kservices { background: url('images/kservices.png?embed') no-repeat 0 0; } .img-lock { background: url('images/lock.png?embed') no-repeat 0 0; }

Notice the ?embed after each image reference. This identifies the image to be included in the sprite. When we create our bundle, we want to use a new type called **CssMinifySpriteEmbed**. Here is what that looks like:

var options = new BundleOptions { EnableOptimizations = true, IncludeFileExtensionInAlias = true }; var css = new Bundle("~/css", typeof(CssMinifySpriteEmbed), options); css.AddFile("~/Content/Styles.css"); BundleTable.Add(css);

What this will do is look through all of your styles and find image references. Then it will combine all images into a sprite and optimize that image to make it as small as possible. The result gets base64 encoded and added to the stylesheet as a new style called “sprite”. For every style definition that had an image reference a new definition is added with “.sprite” appended to the name.

All you have to do now is add the “sprite” class to your HTML elements. If you don’t add the class then your original style/image reference applies and not the sprite.

<div> <span class="img img-browser sprite"></span> <span class="img img-clock sprite"></span> <span class="img img-kdf sprite"></span> <span class="img img-kservices sprite"></span> <span class="img img-lock sprite"></span> <div class="clear"></div> </div>

That’s it!

If you want to change the name of the “sprite” class you can set it in the bundle options.

var options = new BundleOptions { Css = new CssOptions { SpriteClassName = "myspriteclass" } };

[Download example web solution BundlerSprites](http://rushfrisby.com/link/8742e298-acd4-4bc9-9ea8-4a2b7fe99316) [4 MB]

For more on using Bundler.NET check out the [documentation page on codeplex](http://bundler.codeplex.com/documentation).

*Update 2013-02-27: ?embed is now required to include images in the sprite. This is to avoid having images that are already sprites included which would not work well with already defined CSS for those sprites.


