class ContributorsGenService
  attr_reader :objs, :repo, :top_3
  attr_accessor :sorted

  def initialize(repository)
    sorted = {}
    @top_3 = {}

    json = open(repository.api_contributors_url).read
    @objs = JSON.parse(json)
    @repo = repository

    @objs.each do |obj|
      sorted[obj["login"]] = obj["contributions"].to_i
    end

    sorted = sorted.sort_by { |key, value| value}.reverse

    sorted.each do |key, value|
      @top_3[key] = value
      break if @top_3.count == 3
    end
  end

  def call
    @top_3.each do |key, value|
      @objs.each do |obj|
        if value == obj["contributions"].to_i
          Contributor.create!(
              login: obj["login"].to_s,
              api_url: obj["url"].to_s,
              html_url: obj["html_url"].to_s,
              contributions: obj["contributions"].to_i,
              repository: @repo
          )
        end
      end
    end
  end
end
