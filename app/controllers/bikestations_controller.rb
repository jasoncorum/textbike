class BikestationsController < ApplicationController

before_action :authenticate_user!
before_action :set_bikestation, only: [:edit, :destroy, :show]

  def index
    @user_bikestations = current_user.bikestations.all
  end	

  def new
  	@bikestation = current_user.bikestations.build
  	@station_names = []
		Bikestation.get_stations.each do |x|
		@station_names << x['name']
		end
	end

  def create
  	@bikestation = current_user.bikestations.build(bikestation_params)

    Bikestation.get_stations.each do |x|
      if @bikestation.station_name == x['name']
        @bikestation.nb_bikes = x['nbBikes']
      end
    end

    if @bikestation.save
			redirect_to @bikestation
		else
			render 'new'
		end
  end

  def edit
  	@station_names = []
		Bikestation.get_stations.each do |x|
		@station_names << x['name']
		end
  end

  def update
    @bikestation = current_user.bikestations.build(bikestation_params)

    Bikestation.get_stations.each do |x|
      if @bikestation.station_name == x['name']
        @bikestation.nb_bikes = x['nbBikes']
      end
    end

    if @bikestation.save
      redirect_to @bikestation
    else
      render 'new'
    end
  end

  def show
  	@bikestation = Bikestation.find params[:id]
  end

  def destroy
    @bikestation.destroy
    redirect_to bikestations_url
  end


  private

 # 	def link_params
	# 	params.require(:bikestation).permit(:string)
	# end

	def bikestation_params
  	params.require(:bikestation).permit(:station_name, :commute)
	end

 	def set_bikestation
 		@bikestation = current_user.bikestations.find_by(id: params[:id])
 		redirect_to root_path, notice: "Not authorized to access this section of Text Bike." if @bikestation.nil?
 	end

end