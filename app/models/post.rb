class Post < ApplicationRecord
  
    validates :name, :content, presence: true
    # validates :content, presence: true
    has_one_attached :image

    scope :draft, ->{where(published_at: nil)}
    scope :published, ->{ where("published_at <= ?", Time.current)}
    scope :scheduled, -> { where("published_at >?", Time.current)} 

    def draft?
        published_at.nil?
    end

    def published?
        published_at? && published_at <= Time.current
    end

    def scheduled?
        published_at? && published_at > Time.current
    end
end
