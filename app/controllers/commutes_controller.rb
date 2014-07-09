class CommutesController < ApplicationController

before_action :authenticate_user!
before_action :set_commute, only: [:edit, :destroy, :show]
before_action :set_commute_create_update, only: [:create, :update]

  def index
    @user_commutes = current_user.commutes.all
    puts "======================================================="
    puts Time.now
  end	

  def new
  	@commute = current_user.commutes.build
  	@station_names = []
		Commute.get_stations.each do |x|
		@station_names << x['name']
		end
	end

  def create
    Commute.get_stations.each do |x|
      if @commute.station_name == x['name']
        @commute.nb_bikes = x['nbBikes']
      end
    end

    Time.zone = 'Eastern Time (US & Canada)'

    if @commute.save
			redirect_to @commute
		else
			render 'new'
		end
  end

  def edit
  	@station_names = []
		Commute.get_stations.each do |x|
		@station_names << x['name']
		end
  end

  def update
    Commute.get_stations.each do |x|
      if @commute.station_name == x['name']
        @commute.nb_bikes = x['nbBikes']
      end
    end

    if @commute.save
      redirect_to @commute
    else
      render 'new'
    end
  end

  def show
  	@commute = Commute.find params[:id]
  end

  def destroy
    @commute.destroy
    redirect_to commutes_url
  end


  private

	def commute_params
  	params.require(:commute).permit(:station_name, :commute)
	end

 	def set_commute
 		@commute = current_user.commutes.find_by(id: params[:id])
 		redirect_to root_path, notice: "Not authorized to access this section of TextBike." if @commute.nil?
 	end

  def set_commute_create_update
    @commute = current_user.commutes.build(commute_params)
  end

end