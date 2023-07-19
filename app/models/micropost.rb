class Micropost < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  scope :newest, ->{order created_at: :desc}
  # scope :recent_post, ->{order created_at :desc}

  # default_scope { order created_at: :desc }

  validates :content, presence: true,
                      length: {maximum: Settings.digit.length_140}
  validates :image, content_type: {
    in: %w(image/jpeg image/gif image/png),
    message: "valid_format_require",
    size: {less_than: 5.megabytes, message: "size_limit"}
  }

  def display_image
    image.variant resize_to_limit: [300, 300]
  end
end
