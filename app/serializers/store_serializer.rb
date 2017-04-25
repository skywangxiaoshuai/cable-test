class StoreSerializer < ActiveModel::Serializer
  attributes :name, :operator, :developer, :block, :address, :contact, :contact_position, :contact_otherinfo,
             :contact_telephone, :product, :remarks, :district, :category, :enterprise, :pictures, :code

  def operator
    user = User.find_by(id: object.operator_id)
    user.attributes.extract!("id", "name") if user
  end

  def developer
    user = User.find_by(id: object.developer_id)
    user.attributes.extract!("id", "name") if user
  end

  def block
    object.block.attributes.extract!("id", "name")
  end

  def enterprise
    ent = Enterprise.find_by(id: object.enterprise_id)
    ent.attributes.extract!("id", "name") if ent
  end

  def pictures
    object.pictures.map do |picture|
      hash = { id: picture.id, url: picture.picture}
    end
  end

end
