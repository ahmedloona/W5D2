class Post < ApplicationRecord
  validates :title, :author_id, presence: true

  belongs_to :author,
  primary_key: :id,
  foreign_key: :author_id,
  class_name: :User

  has_many :post_subs,
  primary_key: :id,
  foreign_key: :post_id,
  class_name: :PostSub, 
  inverse_of: :post,
  dependent: :destroy

  has_many :subs,
  through: :post_subs,
  source: :sub

  

end
