class Block < ApplicationRecord
  paginates_per 15 # 分页时每页显示20条数据

  before_destroy :validate_stores_present?

  # belongs_to :user
  has_many :stores, dependent: :restrict_with_error

  validates :name, presence: true
  validates :code, uniqueness: true

  private

    def validate_stores_present?
      errors.add(:details, "该商圈下有商铺数据，请把商铺数据转移到其他商圈")
    end
end
