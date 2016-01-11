require 'rake/testtask'
require 'pathname'

Rake::TestTask.new(:test) do |t|
  t.libs << 'test'
  t.libs << 'lib'
  t.test_files = FileList['test/**/*_test.rb']
end

task default: 'test'

desc 'Fetch all feeds and print news'
task :all do
  basedir = Pathname(__dir__)
  File.new(basedir.join('feeds.txt')).each do |line|
    sh "bundle exec #{basedir.join('bin', 'feed-news')} #{line}"
  end
end
