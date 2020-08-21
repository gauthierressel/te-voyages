# activate :sprockets
activate :livereload
activate :directory_indexes
activate :dato, live_reload: true

dato.travels.each do |travel|
  travel_slug = (travel.title).slugify
  proxy "/voyages/#{travel_slug}/index.html", "/voyage.html", :locals => { :travel => travel }
end

dato.stages.each do |stage|
  travel_slug = (stage.travel.title).slugify
  stage_slug = (stage.title).slugify
  proxy "/voyages/#{travel_slug}/#{stage_slug}/index.html", "/etape.html", :locals => { :stage => stage }
end

# enable livereload on development
# configure :development do
#   activate :livereload
# end

# Activate and configure extensions
# https://middlemanapp.com/advanced/configuration/#configuring-extensions

# activate :autoprefixer do |prefix|
#   prefix.browsers = "last 2 versions"
# end

# Layouts
# https://middlemanapp.com/basics/layouts/

# Per-page layout changes
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page '/path/to/file.html', layout: 'other_layout'

# Proxy pages
# https://middlemanapp.com/advanced/dynamic-pages/

# proxy(
#   '/this-page-has-no-template.html',
#   '/template-file.html',
#   locals: {
#     which_fake_page: 'Rendering a fake page with a local variable'
#   },
# )

# Helpers
# Methods defined in the helpers block are available in templates
# https://middlemanapp.com/basics/helper-methods/

# helpers do
#   def some_helper
#     'Helping'
#   end
# end

# Slim
set :slim, { :pretty => false }

# Build-specific configuration
# https://middlemanapp.com/advanced/configuration/#environment-specific-settings

# configure :build do
#   activate :minify_css
#   activate :minify_javascript
# end
