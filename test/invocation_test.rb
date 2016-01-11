require 'test_helper'
require 'tempfile'

class InvocationTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::FeedNews::VERSION
  end

  def test_no_file
    assert_raises do
      FeedNews::CLI.start([])
    end
  end

  def test_superfluous_argument
    assert_raises do
      FeedNews::CLI.start(['one', 'two'])
    end
  end
end
