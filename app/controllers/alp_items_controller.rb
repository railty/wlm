class AlpItemsController < ApplicationController
  before_action :set_alp_item, only: [:show, :edit, :update, :destroy]

  # GET /alp_items
  # GET /alp_items.json
  def index
    @items = AlpItem.all
    if params['search'] != nil then
      search = "%#{params['search']}%"
      @items = @items.where("code like ? or name like ? or alias like ? or description like ?", search, search, search, search)
    end

    @items = @items.paginate(:page => params[:page], :per_page => 100).order('code, name')
    @count = @items.count
  end

  # GET /alp_items/1
  # GET /alp_items/1.json
  def show
  end

  # GET /alp_items/new
  def new
    @alp_item = AlpItem.new
  end

  # GET /alp_items/1/edit
  def edit
  end

  # POST /alp_items
  # POST /alp_items.json
  def create
    @alp_item = AlpItem.new(alp_item_params)

    respond_to do |format|
      if @alp_item.save
        format.html { redirect_to @alp_item, notice: 'Alp item was successfully created.' }
        format.json { render :show, status: :created, location: @alp_item }
      else
        format.html { render :new }
        format.json { render json: @alp_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /alp_items/1
  # PATCH/PUT /alp_items/1.json
  def update
    respond_to do |format|
      if @alp_item.update(alp_item_params)
        format.html { redirect_to @alp_item, notice: 'Alp item was successfully updated.' }
        format.json { render :show, status: :ok, location: @alp_item }
      else
        format.html { render :edit }
        format.json { render json: @alp_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /alp_items/1
  # DELETE /alp_items/1.json
  def destroy
    @alp_item.destroy
    respond_to do |format|
      format.html { redirect_to alp_items_url, notice: 'Alp item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_alp_item
      @alp_item = AlpItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def alp_item_params
      params[:alp_item]
    end
end
