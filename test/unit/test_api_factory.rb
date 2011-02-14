require 'test_helper'

class TestApiFactory < TestCase
  def setup
    @log = MiniTest::Mock.new
    @factory = Edboxra::ApiFactory.new(@log)
  end

  def test_gets_version_1_api
    @log.expect :debug, "", ["found api key -- version_1_key"]
    FakeBox.fakeout_version_1
    assert_instance_of(Edboxra::V1::Api, @factory.create_api)
    @log.verify
  end

  def test_gets_version_2_api
    @log.expect :debug, "", ["found api key -- version_2_key"]
    FakeBox.fakeout_version_2
    assert_instance_of(Edboxra::V2::Api, @factory.create_api)
    @log.verify
  end

  def bench_some_stuff_for_demonstration_purposes
    assert_performance_linear 0.9999 do |n| # n is a range value
      s = ""

      n.times do
        s << "x"
      end
    end
  end
end
