class PathsController < ApplicationController
  before_action :set_path, only: [:show, :edit, :update, :destroy]

  # GET /paths
  # GET /paths.json
  def index
    @info_pattern = "Sampa, A, B, 10\r\nSampa, B, D, 15\r\nSampa, A, C, 20\r\nSampa, C, D, 30\r\nSampa, B, E, 50\r\nSampa, D, E, 30"
    @paths = Path.all
  end

  # GET /paths/1
  # GET /paths/1.json
  def show
  end

  # GET /paths/new
  def new
    @path = Path.new
  end

  # GET /paths/1/edit
  def edit
  end

  # POST /paths
  # POST /paths.json
  def create
    @path = Path.new(path_params)

    respond_to do |format|
      if @path.save
        format.html { redirect_to @path, notice: 'Path was successfully created.' }
        format.json { render action: 'show', status: :created, location: @path }
      else
        format.html { render action: 'new' }
        format.json { render json: @path.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_massive
    paths = []
    params[:massive_paths].split(/\r\n/).each do |line|
      paths << Path.massive_new(*line.split(','))
    end
    Path.import(paths)
    redirect_to({action: :index }, notice: "Paths was successfully created.")
  end

  # PATCH/PUT /paths/1
  # PATCH/PUT /paths/1.json
  def update
    respond_to do |format|
      if @path.update(path_params)
        format.html { redirect_to @path, notice: 'Path was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @path.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /paths/1
  # DELETE /paths/1.json
  def destroy
    @path.destroy
    respond_to do |format|
      format.html { redirect_to paths_url }
      format.json { head :no_content }
    end
  end

  # Ajax: get the best route
  def figure
    #@real, @cstime, @cutime, @stime, @utime, @total
    # Benchmark
    report = Benchmark.benchmark do |x|
      f = x.report("selecting map:"){ @routes = Path.where(local:params[:map_id]) }
      s = x.report("analysing routes:"){ @analyse_routes = Path.analyse_paths(@routes.as_json)}
      t = x.report("taking the best:"){ @top_result = Path.mount_result(@analyse_routes, params[:begin_point], params[:end_point], params[:autonomy], params[:price]) }
    end
    #render text:@top_result.inspect
    rows = {db_rows:@routes.size, analyse_rows:@analyse_routes.size}
    render action: 'figure', locals: {top_result: @top_result, report:report, rows:rows}
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_path
      @path = Path.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def path_params
      params.require(:path).permit(:local, :begin_point, :end_point, :distance)
    end
end
