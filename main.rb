#!/usr/bin/env ruby
# frozen_string_literal: true

# STEP 2: List repos with no owners
def list_of_repos_with_no_owners
  directory = File.join(Dir.pwd, 'artifacts', 'STEP-2')
  Dir.mkdir(directory) unless Dir.exist?(directory)

  file_path = File.join(directory, 'repos.rbb')

  if File.exist?(file_path)
    content = File.read(file_path)

    state = Marshal.load(content)
  else
    state = `cd ./workspace/github-tools/ruby && ruby -Isrc scripts/list.rb repos --no-owners`
    content = Marshal.dump(state)

    File.write(file_path, content)
  end

  state
end

result = list_of_repos_with_no_owners
puts result

# ...
# STEP n: PROFIT!

require 'slack-ruby-client'
Slack.configure do |config|
  config.token = ENV['SLACK_API_TOKEN']
end

client = Slack::Web::Client.new
client.auth_test

channel_name = '#pe-offsites'
text = <<~HEREDOC
  These are the repos without a codeowner:

  ```
  #{result}
  ```
HEREDOC

client.chat_postMessage(channel: channel_name, text: text)
