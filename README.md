SeoCms
-------------

# Setup

`gem 'seo_cms', git: 'https://github.com/romsssss/seo_cms.git'`

`rake seo_cms:install:migrations`

`rake db:migrate`

In `config/routes.rb` add
`mount SeoCms::Engine, at: "/"`
