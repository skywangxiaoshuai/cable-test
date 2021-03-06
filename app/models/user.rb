class User < ApplicationRecord
  rolify
  paginates_per 15 # 分页时每页显示15条数据

  before_destroy :validate_blocks_or_stores_present?
  validates :name, presence: true, uniqueness: true
  # validate :validate_blocks_or_stores_present, on: :destroy
  has_secure_password

  # def verify_not_exist_datas
  #   valid?(:validate_blocks_or_stores_present)
  # end

  private

    def validate_blocks_or_stores_present?
      # errors.add(:details, "该用户存在商圈或者商铺信息") if self.blocks.exists? || self.stores.exists?
      if self.has_role?(:BD_supervisor) && (!Block.where(developer_id: self.id).empty? || !Store.where(developer_id: self.id).empty? || !Enterprise.where(developer_id: self.id).empty?)
        errors.add(:details, "该BD专员存在商圈或者商铺信息")
      elsif self.has_role?(:operation_specialist ) && (!Block.where(operator_id: self.id).empty? || !Store.where(operator_id: self.id).empty? || !Enterprise.where(operator_id: self.id).empty?)
        errors.add(:details, "该BD专员存在商圈或者商铺信息")
      end
    end
end
