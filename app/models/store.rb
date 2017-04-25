class Store < ApplicationRecord
  paginates_per 15  # 分页时每页显示15条数据
  default_scope {order(created_at: :desc)}  #默认按照创建时间从大大小排序

  belongs_to :enterprise, foreign_key: :enterprise_id
  belongs_to :block
  has_many :pictures, as: :imageable, dependent: :destroy
  has_many :cooperations
  has_many :services, through: :cooperations
  has_many :trades, dependent: :destroy

  validates :category, presence: true
  validates :district, presence: true
  validates :code, uniqueness: true

end
