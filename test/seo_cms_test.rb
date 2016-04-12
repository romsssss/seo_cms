require 'test_helper'

class SeoCmsTest < ActiveSupport::TestCase
  setup do
    @default_layout = SeoCms.layout
    @default_orphan_strategy = SeoCms.orphan_strategy
  end

  test 'is a module' do
    assert_kind_of Module, SeoCms
  end

  test 'can get the path on which it is mounted' do
    assert_respond_to(SeoCms::Engine, :mounted_path)
    assert_kind_of(Journey::Path::Pattern, SeoCms::Engine.mounted_path)
  end

  # layout option
  test 'has a layout option' do
    assert_respond_to(SeoCms, :layout)
  end
  test 'layout option default to application' do
    assert_equal(SeoCms.layout, 'layouts/application')
  end
  test 'layout option can be overwritten' do
    SeoCms.layout = 'my_layout'
    assert_equal(SeoCms.layout, 'my_layout')
    SeoCms.layout = @default_layout
  end

  # orphan_strategy option
  test 'has a orphan_strategy option' do
    assert_respond_to(SeoCms, :orphan_strategy)
  end
  test 'orphan_strategy option default to adopt' do
    assert_equal(SeoCms.orphan_strategy, :adopt)
  end
  test 'orphan_strategy option can be overwritten' do
    SeoCms.orphan_strategy = :destroy
    assert_equal(SeoCms.orphan_strategy, :destroy)
    SeoCms.orphan_strategy = @default_orphan_strategy
  end

  test 'options can be set all at once' do
    assert_respond_to(SeoCms, :setup)
    SeoCms.setup do |config|
      config.layout = 'woot'
      config.orphan_strategy = :destroy
    end
    assert_equal(SeoCms.layout, 'woot')
    assert_equal(SeoCms.orphan_strategy, :destroy)
    SeoCms.setup do |config|
      config.layout = @default_layout
      config.orphan_strategy = @default_orphan_strategy
    end
  end

end
