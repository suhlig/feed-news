require 'test_helper'
require 'tempfile'
require 'vcr'

class FeedNewsTest < Minitest::Test
  def setup
    @repo_path = Tempfile.new(name).path

    VCR.configure do |config|
      config.cassette_library_dir = 'test/fixtures/vcr'
      config.hook_into :webmock
    end
  end

  def teardown
    File.unlink(@repo_path)
  end

  def test_new
    out, err = start('https://github.com/cloudfoundry/bosh/releases.atom')

    assert_empty(err)
    assert_includes(out, 'stable-3173')
  end

  def test_existing
    # seed, so that the entry is present
    start('https://github.com/cloudfoundry/cf-release/releases.atom')

    # run again, so that the entry is not new
    out, err = start('https://github.com/cloudfoundry/cf-release/releases.atom')

    assert_empty(out)
    assert_includes(err, 'Nothing new')
  end

  def dump
    require 'pstore'
    store = PStore.new(@repo_path)
    store.transaction(true) do
      store.roots.each do |root|
        puts(root => store[root])
      end
    end
  end

  def start(uri)
    capture_io do
      VCR.use_cassette(name) do
        FeedNews::CLI.new(@repo_path).start(uri)
      end
    end
  end
end
