class BlocksController < ApplicationController
  before_action :set_user, only: [:index_user_blocks]
  before_action :set_block, only: [:edit, :update, :destroy]
  skip_before_action :current_user

  # 模糊查询商圈
  # get /blocks/search?q=华为
  def search_block_by_name
    blocks = Block.where("name like ?", "%#{params[:q]}%")
    render status: :ok, json: blocks, each_serializer: EnterpriseBasicSerializer
  end

  # 返回数据库中所有商圈
  # get /blocks?page[number]=1
  def index_all_blocks
    if params[:page][:number] == 0
      blocks = Block.all.order(created_at: :desc)
    else
      blocks = Block.all.order(created_at: :desc).page(params[:page][:number]).per(params[:page][:size])
    end
    render status: :ok, json: blocks, EachSerializer: BlockSerializer, meta: pagination_dict(blocks)
  end

  # 返回用户(运营专员/BD专员)的所有商圈
  # get /users/:user_id/blocks
  def index_user_blocks
    user = User.find_by(id: params[:user_id])
    if user.has_role?(:BD_specialist)
      blocks = Block.where(developer_id: user.id)
    elsif
      blocks = Block.where(operator_id: user.id)
    end
    render status: :ok, json: blocks, EachSerializer: BlockSerializer
  end

  # 创建新的区块
  def create
    parameters = block_params
    block = Block.new(parameters)
    if block.save
      render status: :created, json: block, Serializer: BlockSerializer
    else
      render status: :unprocessable_entity, json: block, serializer: ActiveModel::Serializer::ErrorSerializer
    end
  end

  # 编辑
  def edit
    render status: :ok, json: @block, Serializer: BlockSerializer
  end

  # 提交编辑
  def update
    if @block.update(block_params)
      render status: :ok, json: @block
    else
      render status: :unprocessable_entity, json: @block, serializer: ActiveModel::Serializer::ErrorSerializer
    end
  end

  # 删除
  def destroy
    if @block.destroy
      render status: :no_content
    else
      render status: :unprocessable_entity, json: @block, serializer: ActiveModel::Serializer::ErrorSerializer
    end
  end



  private

    def set_user
      @user = User.find(params[:user_id])
    end

    def set_block
      @block = Block.find(params[:id])
    end

    def block_params
      parameters = ActiveModelSerializers::Deserialization.jsonapi_parse(params, only: [:developer_id, :operator_id, :code, :name, :description])
    end

end
