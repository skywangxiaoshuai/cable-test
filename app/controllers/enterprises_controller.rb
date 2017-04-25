class EnterprisesController < ApplicationController
  before_action :set_ent, only: [:show, :edit, :update, :destroy]

  # 返回数据库中所有企业
  # GET /enterprises?page[numer]=1
  def index
    if params[:page][:number] == 0
      ents = Enterprise.all.order(created_at: :desc)
    else
      ents = Enterprise.all.order(created_at: :desc).page(params[:page][:number]).per(params[:page][:size])
    end
    render status: :ok, json: ents, each_serializer: EnterpriseSerializer, meta: pagination_dict(ents)
  end

  # 模糊查询企业
  # get /enterprises/search?q=华为
  def search_ent_by_name
    ents = Enterprise.where("name like ?", "%#{params[:q]}%")
    render status: :ok, json: ents, each_serializer: EnterpriseBasicSerializer
  end

  # 查看企业信息
  # get /enterprises/:id
  def show
    render status: :ok, json: @ent, Serializer: EnterpriseSerializer
  end

  # 创建企业
  # post /enterprises
  def create
    ent = Enterprise.new(ent_params)
    if ent.save
      render status: :created, json: ent, Serializer: EnterpriseSerializer
    else
      render status: :unprocessable_entity, json: ent, serializer: ActiveModel::Serializer::ErrorSerializer
    end
  end

  # 编辑企业
  # get /enterprises/:id/edit
  def edit
    render status: :created, json: @ent, Serializer: EnterpriseSerializer
  end

  # 更新企业
  # put /enterprises/:id
  def update
    if @ent.update(ent_params)
      render status: :ok, json: @ent, Serializer: EnterpriseSerializer
    else
      render status: :unprocessable_entity, json: @ent, serializer: ActiveModel::Serializer::ErrorSerializer
    end
  end

  # 删除企业
  # delete /enterprises/:id
  def destroy
    @ent.destroy
    render status: :no_content
  end

  private

    def set_ent
      @ent = Enterprise.find(params[:id])
    end

    def ent_params
      parameters = ActiveModelSerializers::Deserialization.jsonapi_parse(params, only: [:name, :developer_id, :operator_id,
                   :district, :address, :contact, :contact_position, :contact_telephone, :contact_otherinfo, :remarks, :code])
    end
end
