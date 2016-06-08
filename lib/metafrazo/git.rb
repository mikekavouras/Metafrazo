require 'octokit'

module Metafrazo
  class Git

    def initialize(token, payload, repo=nil)
      @pull_request = payload["pull_request"]
      @token = token
      @repo = repo
    end

    def comment(comment)
      client.add_comment(repo_name, issue_id, comment)
    end

    def add_label(label)
      client.add_labels_to_an_issue(repo_name, issue_id, ["translations"])
    end

    def remote_origin
      "https://#{@token}:x-oauth-basic@github.com/#{repo_name}.git"
    end

    def repo_name
      @pull_request["head"]["repo"]["full_name"]
    end

    def sha
      @pull_request["head"]["sha"]
    end

    def pull_request_url
      @pull_request["html_url"]
    end

    def master_branch
      @master_branch ||= begin
        (@repo && @repo[:base_branch]) || "master"
      end
    end

    def issue_id
      @pull_request["number"]
    end

    private

    def client
      @client ||= Octokit::Client.new(access_token: @token)
    end

  end
end
