axis         = require 'axis'
rupture      = require 'rupture'
autoprefixer = require 'autoprefixer-stylus'
js_pipeline  = require 'js-pipeline'
css_pipeline = require 'css-pipeline'
contentful   = require 'roots-contentful'
slugify      = require 'slug'
marked       = require 'marked'

module.exports =
  ignores: ['readme.md', '**/layout.*', '**/_*', '.gitignore', 'ship.*conf']

  locals:
    markdown: marked

  extensions: [
    js_pipeline(files: 'assets/js/*.coffee'),
    css_pipeline(files: 'assets/css/*.styl'),
    contentful
      access_token: 'bda8a51753b652b04af9190126907645f6babb6839a0e33c41a38ced1bfd5642'
      space_id: 'dir15yko1g25'
      content_types:
        blog_posts:
          id: 'blog_post'
          name: 'posts'
          template: 'views/_post.jade'
          path: (e) -> "blogging/#{e.category}/#{slugify(e.title)}"
          write: 'data.json'
          sort: (a, b) -> -1
  ]

  stylus:
    use: [axis(), rupture(), autoprefixer()]
    sourcemap: true

  'coffee-script':
    sourcemap: true

  jade:
    pretty: true
