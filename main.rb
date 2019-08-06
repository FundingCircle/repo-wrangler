#!/usr/bin/env ruby
# frozen_string_literal: true

# STEP 1: Clone the code wrangler repository
GITHUB_TOOLS_GIT_URL = 'https://github.com/FundingCircle/github-tools.git'
`git clone #{GITHUB_TOOLS_GIT_URL} ./workspace/github-tools -b find-no-codeowners`

# STEP 2: List repos with no owners
result = `cd ./workspace/github-tools/ruby && ruby -Isrc scripts/list.rb repos --no-owners`
puts result

# ...
# STEP n: PROFIT!
