#!/usr/bin/env ruby
# frozen_string_literal: true

# STEP 1: List repos with no owners
def list_of_repos
  directory = File.join(Dir.pwd, 'artifacts', 'STEP-1')
  Dir.mkdir(directory) unless Dir.exist?(directory)

  file_path = File.join(directory, 'repos.rbb')

  if File.exist?(file_path)
    content = File.read(file_path)

    state = Marshal.load(content)
  else
    state = `cd ./workspace/github-tools/ruby && ruby -Isrc scripts/list.rb repos --all`
    content = Marshal.dump(state)

    File.write(file_path, content)
  end

  state
end

result_all = list_of_repos.lines(chomp: true)

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

result_no_owners = list_of_repos_with_no_owners.lines(chomp: true)

# ...
# STEP n: PROFIT!

percentage = result_no_owners.size.to_f / result_all.size.to_f * 100

require 'slack-ruby-client'
Slack.configure do |config|
  config.token = ENV['SLACK_API_TOKEN']
end

client = Slack::Web::Client.new
client.auth_test

channel_name = '#pe-offsites'

require 'date'
date = Date.today.to_s

text = <<~HEREDOC
  These are the repos without a codeowner:
  #{percentage.round(2)}% have no codeowner

  ```
  #{result_no_owners.join(',')}
  ```
HEREDOC

client.chat_postMessage(channel: channel_name, text: text)
# client.files_upload(
#   channels: channel_name,
#   content: text,
#   as_user: true,
#   title: "SHAME! #{date}",
#   filename: "shamelist-#{date}.txt",
#   initial_comment: 'These are the repos without a codeowner'
# )
