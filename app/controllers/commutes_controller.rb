class CommutesController < ApplicationController

before_action :authenticate_user!
before_action :correct_user, only: [:edit, :update, :destroy, :show]
before_action :set_commute_create, only: [:create]

  def index
    @user_commutes = current_user.commutes.all

  end	

  def new
  	@commute = current_user.commutes.build
  	@station_names = []
		Commute.get_stations.each do |x|
		@station_names << x['name']
		end
	end

  def create
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
    if @commute.update(commute_params)
      redirect_to @commute, notice: 'Commute was successfully updated.'
    else
      render action: 'edit'
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

 	def correct_user
 		@commute = current_user.commutes.find_by(id: params[:id])
 		redirect_to root_path, notice: "Not authorized to access this section of TextBike." if @commute.nil?
 	end

  def set_commute_create
    @commute = current_user.commutes.build(commute_params)
  end

end