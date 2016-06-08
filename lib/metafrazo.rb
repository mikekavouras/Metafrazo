require_relative 'metafrazo/version'
require_relative 'metafrazo/config'
require_relative 'metafrazo/slack'
require_relative 'metafrazo/git'
require_relative 'metafrazo/git_diff_generator'

module Metafrazo

  class << self
    attr_writer :config
  end

  # returns true if your files
  def self.run(payload)
    token = config.token
    repo = subject_repo(payload)

    git = Git.new(token, payload, repo)
    diff = GitDiffGenerator.new(git).generate
    changes = local_changes(diff, diff_paths(repo))

    unless changes.empty?
      if slack_enabled?
        m = message(changes, git.pull_request_url, git.issue_id)
        Slack.send_message(m, config.slack_webhook_url)
      else
        git.comment(message(changes))
      end
      # git.add_label("bug")
    end

    !changes.empty?
  end

  def self.config
    @config ||= Config.new
  end

  def self.configure
    yield(config)
  end

  private

  def self.local_changes(diffs, paths)
    changes = []
    paths.each do |path|
      diffs.each do |diff|
        if diff.match(/^#{path}/)
          changes << diff
        end
      end
    end

    return changes
  end

  def self.diff_paths(repo)
    paths = config.paths || []
    paths = [config.path] if config.path
    paths = [repo[:path]] if repo && repo[:path]
    paths = repo[:paths] if repo && repo[:paths]
    paths
  end

  def self.subject_repo(payload)
    return nil unless config.repos

    name = payload["pull_request"]["head"]["repo"]["full_name"].downcase
    parts = name.split('/')

    names = config.repos.keys.select do |key|
      key = key.downcase
      key == name || (parts.count > 1 && parts[1] == key)
    end

    config.repos[names.first]
  end

  def self.message(changes, url = nil, number = nil)
    messages = [
      "ci sono nuove stringhe que sono in disperato bisogno di traduzione",
      "hay nuevas cadenas que están en desesperada necesidad de una traducción",
      "Que há novas cordas estão em necessidade desesperada de tradução",
      "il y a des nouvelles chaînes Que sont dans le besoin désespéré de la traduction",
      "gibt es neue Saiten que sind in einer verzweifelten Notwendigkeit Übersetzung"
    ]

    message = "#{config.usernames.join(' ')}: #{messages.sample} – "
    message += changes.map { |change| "`#{change}`" }.join(' ')
    message += " \n\n<#{url}| ##{number} - 👉> \n" if url&& number
  end

  private

  def self.slack_enabled?
    config.slack_webhook_url.present?
  end


end
