class Entry < ApplicationRecord
  belongs_to :user
  has_many :comments

  validates :title, presence: true, length: {maximum: Settings.max_title_leng}
  validates :user_id, presence: true
  validates :content, presence: true
  validate  :picture_size

  default_scope ->{order created_at: :desc}

  mount_uploader :picture, PictureUploader

  private
  def picture_size
    if picture.size > Settings.picture_size.megabytes
      errors.add(:picture, "should be less than 3MB")
    end
  end

end
