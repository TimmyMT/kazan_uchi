class Repository < ApplicationRecord
  has_many :contributors, dependent: :destroy
  has_many_attached :files

  before_create :already_exists?
  before_create :set_user_with_repo
  after_create :checked_url
  validate :corrected_url

  validates :url, presence: true

  # self.file.attach(io: File.open("#{Rails.root}/app/file_for_attach.rb"), filename: 'file_for_attach.rb')

  def checked_url
    uri = URI.parse(self.api_contributors_url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(uri.request_uri)
    res = http.request(request)

    if res.code == "200"
      transaction do
        self.valid_api_url = true
        self.save!
      end
    end
  end

  def corrected_url
    return if self.url.nil?
    htpp_url = self.url.include?("http://github.com")
    https_url = self.url.include?("https://github.com")
    default_url = self.url.include?("github.com")

    # github_url = htpp_url || https_url || default_url
    return errors[:url] << "Is not Github" unless default_url

    if htpp_url
      cut_str = url.to_s
      cut_str = cut_str.remove("http://github.com/")
    elsif https_url
      cut_str = url.to_s
      cut_str = cut_str.remove("https://github.com/")
    elsif default_url
      cut_str = url.to_s
      cut_str = cut_str.remove("github.com/")
    end

    cut_str[0] = '' if cut_str[0] == '/'
    cut_str[cut_str.length - 1] = '' if cut_str[cut_str.length - 1] == '/'

    errors[:url] << "wrong path for repo" unless cut_str.split('/').count == 2
  end

  def set_user_with_repo
    if self.valid?
      htpp_url = self.url.include?("http://github.com")
      https_url = self.url.include?("https://github.com")
      default_url = self.url.include?("github.com")

      if htpp_url
        cut_str = url.to_s
        cut_str = cut_str.remove("http://github.com/")
      elsif https_url
        cut_str = url.to_s
        cut_str = cut_str.remove("https://github.com/")
      elsif default_url
        cut_str = url.to_s
        cut_str = cut_str.remove("github.com/")
      end

      cut_str[0] = '' if cut_str[0] == '/'
      cut_str[cut_str.length - 1] = '' if cut_str[cut_str.length - 1] == '/'

      self.user = cut_str.split('/').first
      self.repo = cut_str.split('/').last
      self.api_contributors_url = "https://api.github.com/repos/#{self.user}/#{self.repo}/contributors"
    end
  end

  def already_exists?
    already_have = Repository.find_by(url: self.url)
    already_have.destroy if already_have.present?
  end
end
