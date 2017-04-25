class CooperationSerializer < ActiveModel::Serializer
  attributes :start_date, :status, :remarks, :service_name

  def service_name
  	Service.find_by(id: object.service_id).try(:name)
  end
end
