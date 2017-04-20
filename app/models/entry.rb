class Entry < ApplicationRecord
  belongs_to :user

  validates :title, presence: true, length: {maximum: Settings.max_title_leng}
  validates :user_id, presence: true
  validates :content, presence: true
  validates :description, presence: true,
    length: {minimum: Settings.min_desc_leng, maximum: Settings.max_desc_leng}
  validate  :picture_size

  mount_uploader :picture, PictureUploader

  private
  def picture_size
    if picture.size > Settings.picture_size.megabytes
      errors.add(:picture, "should be less than 3MB")
    end
  end

end
