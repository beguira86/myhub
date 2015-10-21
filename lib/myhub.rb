require "sinatra/base"
require "httparty"
require "pry"
require "json"

require "myhub/version"
require "myhub/github"

module Myhub
  class App < Sinatra::Base
    set :logging, true

    # Your code here ...
    get "/" do
      api = Github.new
      data = api.list_issues
      stuff = data.map do |x|
        {
              title: x["title"],
              url: x["url"],
              id: x["id"],
              state: x["state"],
              created: x["created"],
              updated: x["updated"]
        }
        end 
      binding.pry
      # get stuff from github
      erb :index, locals: { issues: stuff }
    end

    post "/issue/reopen/:id" do
      api = Github.new
      api.reopen_issue(params["id"].to_i)
      "Cool cool cool"
    end

    post "/issue/close/:id" do
      api = Github.new
      api.close_issue(params["id"].to_i)

      "Cool cool cool"
    end

    run! if app_file == $0
  end
end
