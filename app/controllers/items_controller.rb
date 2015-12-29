class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]

  # GET /items
  # GET /items.json
  def index
    session[:report] = params['report'] || 'all'

    @classes = ["inactive", "inactive", "inactive"]
    if session[:report] == 'duplicated' then
      @items = Item.where("upc in (?)", Item.select(:upc).group(:upc).having("count(*) > 1"))
      @classes[1] = "active"
    elsif session[:report] == 'missing' then
      @items = Item.joins("left join products_stores on items.vendor_stk_nbr = products_stores.prod_num where products_stores.prod_num is null")
      @classes[2] = "active"
    else
      @items = Item.all
      @classes[0] = "active"
    end

    if params[:act] == 'delete' then
      @items.delete_all
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

  def upload
    respond_to do |format|
     if Item.importExcel(params['excel'].tempfile, params['excel'].original_filename)
       format.html { redirect_to items_url, notice: 'excel was successfully imported.' }
       format.json { head :no_content }
     else
       format.html { redirect_to items_url, notice: 'Error import file.' }
       format.json { head :no_content }
     end
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_item
      @item = Item.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def item_params
      params[:item]
    end
end
