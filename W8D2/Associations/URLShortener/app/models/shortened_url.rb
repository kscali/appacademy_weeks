class ShortenedUrl < ApplicationRecord 
  validates :short_url, :long_url, presence: true, uniqueness: true 
  validates :user_id, presence: true 

    belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: "User" 

    has_many :visits,
    primary_key: :id, 
    foreign_key: :short_url_id,
    class_name: "Visit"

    has_many :visitors,
    -> { distinct },
    through: :visits,
    source: :visitor


  def self.new_url(user, long_url)
    ShortenedUrl.create!(user_id: user.id, long_url: long_url, short_url: ShortenedUrl.random_code)

  end

  def self.random_code
    string = ""
    until string.length > 0 
     url = SecureRandom::urlsafe_base64
     string = url unless ShortenedUrl.exists?(:short_url => url) 
    end
    string 
  end

  def num_clicks 
    self.visits.select(:user_id).count 
  end 

  def num_uniques 
    self.visitors.select(:user_id).count 
  end

  def num_recent_uniques
    num_uniques.where({ created_at: 10.minutes.ago..Time.now})
  end
end
