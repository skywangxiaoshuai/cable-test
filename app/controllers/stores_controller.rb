class StoresController < ApplicationController
  before_action :set_store, only: [:show, :edit, :update, :destroy]

  # 模糊查询商铺
  # get /stores/search?q=华为
  def search_store_by_name
    stores = Store.where("name like ?", "%#{params[:q]}%").includes(:pictures)
    render status: :ok, json: stores, each_serializer: StoreBasicSerializer
  end

  # 根据地址筛选商铺
  # GET /district/stores?level=1&id=110000
  def search_store_by_district
    level = params[:level].to_i
    stores = Store.where("district->'#{level}'->>'id' = ?", params[:id]).page(params[:page][:number]).per(params[:page][:size])
    render status: :ok, json: stores, EachSerializer: StoreSerializer, meta: pagination_dict(stores)
  end

  # 根据类别筛选商铺
  # GET /category/stores?level=1&id=100001
  def search_store_by_category
    level = params[:level].to_i
    stores = Store.where("category->'#{level}'->>'id' = ?", params[:id]).page(params[:page][:number]).per(params[:page][:size])
    render status: :ok, json: stores, EachSerializer: StoreSerializer, meta: pagination_dict(stores)
  end

  # # 根据类别和地址综合筛选商铺,如果没有筛选条件,则返回所有商铺
  # # GET /stores?district_lev=1&district_id=100010&category_lev=1&category_id=100020&page[number]=1&page[size]=10
  # def search_store_by_category_and_district
  #   district_lev = params[:district_lev].to_i
  #   category_lev = params[:category_lev].to_i
  #   if district_lev != 0 && category_lev !=0   #根据地区和类别综合筛选
  #     stores = Store.where("district->'#{district_lev}'->>'id' = ? and category->'#{category_lev}'->>'id' = ?",
  #              params[:district_id], params[:category_id]).page(params[:page][:number]).per(params[:page][:size])
  #   elsif district_lev != 0 && category_lev == 0  #根据地区筛选
  #     stores = Store.where("district->'#{district_lev}'->>'id' = ?", params[:district_id])
  #               .page(params[:page][:number]).per(params[:page][:size])
  #   elsif district_lev == 0 && category_lev !=0   #根据类别筛选
  #     stores = Store.where("category->'#{category_lev}'->>'id' = ?", params[:category_id])
  #               .page(params[:page][:number]).per(params[:page][:size])
  #   else    #没有筛选条件就返回所有的商铺
  #     stores = Store.all.page(params[:page][:number]).per(params[:page][:size])
  #   end
  #   render status: :ok, json: stores, EachSerializer: StoreSerializer, meta: pagination_dict(stores)
  # end

  # 返回数据库中所有商铺
  # GET /stores?page[number]=1&page[size]=10
  def index_all_stores
    stores = Store.all.page(params[:page][:number]).per(params[:page][:size])
    render status: :ok, json: stores, EachSerializer: StoreSerializer, meta: pagination_dict(stores)
  end

  # 查看商铺信息
  # get /stores/:id
  def show
    render status: :ok, json: @store, Serializer: StoreSerializer
  end

  # 创建商铺
  def create
    # binding.pry
    store = Store.new(store_params)
    if store.save
      render status: :created, json: store, Serializer: StoreSerializer
    else
      render status: :unprocessable_entity, json: store, serializer: ActiveModel::Serializer::ErrorSerializer
    end
  end

  # 编辑商铺
  def edit
    render status: :created, json: @store, Serializer: StoreSerializer
  end

  # 更新商铺
  def update
    if @store.update(store_params)
      render status: :ok, json: @store, Serializer: StoreSerializer
    else
      render status: :unprocessable_entity, json: @store, serializer: ActiveModel::Serializer::ErrorSerializer
    end
  end

  # 删除商铺
  def destroy
    @store.destroy
    render status: :no_content
  end

  private

    def set_store
      @store = Store.find(params[:id])
    end

    def store_params
      parameters = ActiveModelSerializers::Deserialization.jsonapi_parse(params, only: [:name, :developer_id, :operator_id,
                  :block_id, :district, :category, :address, :contact, :contact_position, :contact_telephone, :remarks,
                  :enterprise_id, :contact_otherinfo, :code, :product])
    end
end
