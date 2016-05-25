module Metafrazo
  class GitDiffGenerator
    require 'fileutils'

    def initialize(git)
      @git = git
      @root_dir = Dir.pwd
    end

    def generate
      init_git unless git_init?
      get_diff
      Dir.chdir(@root_dir)
    end

    private

    def get_diff
      Dir.chdir(local_repo_dir)
      `git fetch`
      "#{`git diff --name-only origin/#{@git.master_branch}...#{@git.sha}`}".split("\n")
    end

    def init_git
      FileUtils.mkdir_p(local_repo_dir)
      Dir.chdir(local_repo_dir)
      `git init`
      `git remote add origin #{@git.remote_origin}`
    end

    def git_init?
      Dir.exist?(local_repo_dir)
    end

    def local_repo_dir
      "#{@root_dir}/git/#{@git.repo_name}"
    end

  end
end
