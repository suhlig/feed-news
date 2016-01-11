require 'nokogiri'
require 'open-uri'

module FeedNews
  class CLI
    def initialize(repo_path = 'feed-news.pstore')
      @repo_path = repo_path
    end

    def start(args = ARGV)
      args = Array(args)

      case args.size
      when 0
        fail 'Missing feed URI.'
      when 1
        feed = args.first
        repo = Repository.new(@repo_path)
        doc = Nokogiri::XML(open(feed))
        doc.remove_namespaces!

        latest_entry = Feed.map(doc).latest

        if repo.seen?(latest_entry)
          warn "Nothing new in #{feed} since '#{latest_entry}'"
        else
          puts "New entry in #{latest_entry.feed.title}: #{latest_entry}"
        end
      else
        fail "Superfluous argument #{args[1..-1]}. Only a single feed can be processed."
      end
    end
  end
end
