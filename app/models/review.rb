class Review < ApplicationRecord
  validates_presence_of :user_id,
                        :description,
                        :rating,
                        :reviewable_type,
                        :reviewable_id

  belongs_to :user
  belongs_to :reviewable, polymorphic: true

  def reviewable_feed_name
    reviewable_type.downcase
  end

  def report_review
    attrs = {
      :user_id       => user_id,
      :target_type   => reviewable_type,
      :target_id     => reviewable_id,
      :target_feed   => reviewable_feed_name,
      :message       => description
    }
    Feed.new(attrs).review
  end
end
