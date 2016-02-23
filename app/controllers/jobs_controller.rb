class JobsController < ApplicationController
  before_action :set_job, only: [:show, :edit, :update, :destroy, :download]
  # GET /jobs
  # GET /jobs.json
  def index
    @jobs = Job.all
  end

  # GET /jobs/1
  # GET /jobs/1.json
  def show
  end

  # GET /jobs/new
  def new
    @job = Job.new
  end

  # GET /jobs/1/edit
  def edit
  end

  # POST /jobs
  # POST /jobs.json
  def create
    @job = Job.new(job_params)

    respond_to do |format|
      if @job.save
        format.html { redirect_to @job, notice: 'Job was successfully created.' }
        format.json { render :show, status: :created, location: @job }
      else
        format.html { render :new }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /jobs/1
  # PATCH/PUT /jobs/1.json
  def update
    respond_to do |format|
      if @job.update(job_params)
        format.html { redirect_to @job, notice: 'Job was successfully updated.' }
        format.json { render :show, status: :ok, location: @job }
      else
        format.html { render :edit }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /jobs/1
  # DELETE /jobs/1.json
  def destroy
    @job.destroy
    respond_to do |format|
      format.html { redirect_to jobs_url, notice: 'Job was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def upload_excel
    respond_to do |format|
     if Job.uploadExcel(params['excel'].tempfile, params['excel'].original_filename) then
       format.html { redirect_to jobs_url, notice: 'excel was successfully imported.' }
       format.json { head :no_content }
     else
       format.html { redirect_to jobs_url, notice: 'Error import file.' }
       format.json { head :no_content }
     end
    end
  end

  def price_guide
    respond_to do |format|
     if Job.priceGuide(params['excel'].tempfile, params['excel'].original_filename) then
       format.html { redirect_to jobs_url, notice: 'excel was successfully imported.' }
       format.json { head :no_content }
     else
       format.html { redirect_to jobs_url, notice: 'Error import file.' }
       format.json { head :no_content }
     end
    end
  end

  def delete_wm_items
    respond_to do |format|
     if Job.delete_wm_items() then
       format.html { redirect_to jobs_url, notice: 'all wm_items were successfully deleted.' }
       format.json { head :no_content }
     else
       format.html { redirect_to jobs_url, notice: 'Error delete wm_items.' }
       format.json { head :no_content }
     end
    end
  end

  def download_stores_products
    respond_to do |format|
     if Job.download_stores_products() then
       format.html { redirect_to jobs_url, notice: 'download stores products successful.' }
       format.json { head :no_content }
     else
       format.html { redirect_to jobs_url, notice: 'Error download stores products.' }
       format.json { head :no_content }
     end
    end
  end

  def download
    if params[:file] == "output" then
      respond_to do |format|
        format.xlsx do
          send_data File.read(@job.output), type: "application/xlsx", filename: Pathname.new(@job.output).basename.to_s, disposition: 'inline'
        end
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_job
      @job = Job.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def job_params
      params[:job]
    end
end
