class Visit < ApplicationRecord
    validates :user_id, :short_url_id, presence: true

    belongs_to :visitor,
    primary_key: :id,
    foreign_key: :user_id, 
    class_name: "User"
        
    belongs_to :visited_url,
    primary_key: :id, 
    foreign_key: :short_url_id, 
    class_name: "ShortenedUrl"

    def self.record_visit!(user, short_url)
        Visit.create!(user_id: user.id, short_url_id: short_url)
        
    end 


end

