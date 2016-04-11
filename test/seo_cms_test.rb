require 'test_helper'

class SeoCmsTest < ActiveSupport::TestCase
  test 'is a module' do
    assert_kind_of Module, SeoCms
  end

  test 'can get the path where it is mounted' do
    assert_respond_to(SeoCms::Engine, :mounted_path)
    assert_kind_of(Journey::Path::Pattern, SeoCms::Engine.mounted_path)
  end
end
