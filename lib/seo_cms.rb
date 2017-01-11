require 'seo_cms/engine'
require 'seo_cms/mounted_path'
require 'seo_cms/dynamic_router'

module SeoCms
  mattr_accessor :layout
  mattr_accessor :orphan_strategy
  mattr_accessor :title_suffix
  mattr_accessor :reload_routes_on_the_fly
  mattr_accessor :check_routes_uniqueness

  class << self
    def layout
      @@layout || 'layouts/application'
    end

    # Ancestry' orphan startegy (https://github.com/stefankroes/ancestry)
    def orphan_strategy
      @@orphan_strategy || :adopt
    end

    def reload_routes_on_the_fly
      @@reload_routes_on_the_fly.nil? ? true : @@reload_routes_on_the_fly
    end

    def check_routes_uniqueness
      @@check_routes_uniqueness.nil? ? true : @@check_routes_uniqueness
    end

    # Yield self on setup for nice config blocks
    def setup
      yield self
    end
  end
end
