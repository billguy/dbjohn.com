# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile += %w( jquery.fancybox.css pick-a-color-1.2.3.min.css tinycolor-0.9.15.min.js pick-a-color-1.2.3.min.js oms.js home.js prefixfree.js _magnifier.css magnifier.js bttrlazyloading.css jquery.bttrlazyloading.js ckeditor/config.js ckeditor/plugins/syntaxhighlight/*.js ckeditor/plugins/syntaxhighlight/lang/*.js ckeditor/plugins/syntaxhighlight/dialogs/syntaxhighlight.js ckeditor/**/.js contacts.js contacts.css blank.gif light_wool.png loading.gif rails.jpgckeditor/* _caption.css _mixins.css _tags.css blogs.css home.css pages.css pics.css slogans.css style.css tags.css tags.js pics.js pages.js blogs.js)

