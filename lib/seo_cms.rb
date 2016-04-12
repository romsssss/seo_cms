require 'seo_cms/engine'
require 'seo_cms/mounted_path'
require 'seo_cms/dynamic_router'

module SeoCms
  mattr_accessor :layout
  mattr_accessor :orphan_strategy

  class << self
    def layout
      @@layout || 'layouts/application'
    end

    # Ancestry' orphan startegy (https://github.com/stefankroes/ancestry)
    def orphan_strategy
      @@orphan_strategy || :adopt
    end

    # Yield self on setup for nice config blocks
    def setup
      yield self
    end
  end
end
