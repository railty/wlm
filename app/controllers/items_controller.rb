class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy, :print]

  # GET /items
  # GET /items.json
  def index
    @admin = params['admin']=='true' || false

    session[:report] = params['report'] || 'all'

    @classes = ["inactive", "inactive", "inactive", "inactive", "inactive"]
    if session[:report] == 'duplicated_upc' then
      @items = Item.where("upc in (?)", Item.select(:upc).group(:upc).having("count(*) > 1"))
      @classes[1] = "active"
    elsif session[:report] == 'duplicated_prodnum' then
      @items = Item.where("vendor_stk_nbr in (?)", Item.select(:vendor_stk_nbr).group(:vendor_stk_nbr).having("count(*) > 1"))
      @classes[2] = "active"
    elsif session[:report] == 'missing' then
      @items = Item.joins("left join products_stores on items.vendor_stk_nbr = products_stores.prod_num where products_stores.prod_num is null")
      @classes[3] = "active"
    elsif session[:report] == 'priceChanging' then
      @items = Item.where("proposed_price is not null")
      @classes[4] = "active"
    else
      @items = Item.all
      @classes[0] = "active"
    end

    if params[:act] == 'delete' then
      @items.delete_all
    end

    if params['search'] != nil then
      search = "%#{params['search']}%"
      @items = @items.where("vendor_stk_nbr like ? or upc like ? or convert(char(8), id) like ?", search, search, search)
    end

    @items = @items.paginate(:page => params[:page], :per_page => 100).order('upc, id')
    @count = @items.count
  end

  # GET /items/1
  # GET /items/1.json
  def show
  end

  # GET /items/new
  def new
    @item = Item.new
  end

  # GET /items/1/edit
  def edit
  end

  # POST /items
  # POST /items.json
  def create
    @item = Item.new(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @item }
      else
        format.html { render :new }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /items/1
  # PATCH/PUT /items/1.json
  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /items/1
  # DELETE /items/1.json
  def destroy#
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def complete_price
    Item.complete_price
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Price was successfully changed.' }
      format.json { head :no_content }
    end
  end

  def print
    @item.print
    respond_to do |format|
      format.html { redirect_to items_url, notice: "#{@item.id} was send to print pool successfully." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params[:item].permit([:origin, :proposed_price])
    end
end
