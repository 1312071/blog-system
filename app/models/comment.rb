class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :entry

  validates :user_id, presence: true
  validates :content, presence: true
  validates :entry_id, presence: true

  default_scope ->{order created_at: :desc}
end
