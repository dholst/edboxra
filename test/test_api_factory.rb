require 'minitest/autorun'
require 'edboxra'
require 'fake_box'

module Edboxra
  class TestApiFactory < MiniTest::Unit::TestCase
    def test_gets_version_1_api
      FakeBox.fakeout_version_1
      assert_instance_of(Version1Api, ApiFactory.create_api)
    end

    def test_gets_version_2_api
      FakeBox.fakeout_version_2
      assert_instance_of(Version2Api, ApiFactory.create_api)
    end
  end
end
