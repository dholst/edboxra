require 'test_helper'

class TestApiFactory < TestCase
  def test_gets_version_1_api
    FakeBox.fakeout_version_1
    assert_instance_of(Edboxra::Version1Api, Edboxra::ApiFactory.create_api)
  end

  def test_gets_version_2_api
    FakeBox.fakeout_version_2
    assert_instance_of(Edboxra::Version2Api, Edboxra::ApiFactory.create_api)
  end
end
