# SeoCms

SeoCms is a simple CMS dedicated to SEO content. It allows simple management of a tree of static content page and auto-generate breadcrumbs and Rails routes.

## Setup

```
gem 'seo_cms', path: 'vendor/seo_cms'
```

```
rake seo_cms:install:migrations
```

```
rake db:migrate
```

Add the following line in `config/routes.rb`:
```ruby
mount SeoCms::Engine, at: "/"
```

```
rails s
```

Start adding content using the following link: http://127.0.0.1:3000/seo_content

## Configure

In `config/initializers/seo_cms.rb` initializer, the following options are available
```ruby
SeoCms.setup do |config|
  # layout used to render SEO pages
  config.layout = 'layouts/my_custom_layout' # default value is 'layouts/application'
  # SEO tree orphan strategy used by ancestry gem (https://github.com/stefankroes/ancestry)
  config.orphan_strategy = :destroy # default value is :adopt
  # Suffix to append to the page title ("my title | suffix")
  config.title_suffix = 'MyProject' # default is nil
  # Routes reloading startegy: whether or not the routes are reloaded on the fly whenever a new
  # article is created or edited
  config.reload_routes_on_the_fly = false # default is true
end
```

## Tests

```
rake test
```
