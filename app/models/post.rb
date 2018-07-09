class Post < ActiveRecord::Base
  belongs_to :group, counter_cache: true
  belongs_to :author, class_name: "User", foreign_key: :user_id

  has_many :messages

  validates :content, presence: true

  scope :recent, -> { order("updated_at DESC") }
end
