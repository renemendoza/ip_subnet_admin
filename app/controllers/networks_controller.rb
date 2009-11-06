class NetworksController < ApplicationController
  def index
    @networks  = Network.all
  end

  def new
    @network = Network.new
  end

  def create
    @network = Network.new(params[:network])
    begin 
      @network.save!
      flash[:notice] = "New network created."
      redirect_to networks_path
    rescue
      render :action => "new"
    end
  end

  def show
    @network  = Network.find(params[:id])
  end

  def edit
    @network  = Network.find(params[:id])
  end

  def update
    @network = Network.find(params[:id])

    if @network.update_attributes(params[:network])
      flash[:notice] = "Network updated."
      redirect_to networks_path
    else 
      render :action => "edit"
    end

  end

  def destroy

    @network = Network.find(params[:id])
    @network.destroy

    flash[:notice] = "Network deleted."
    redirect_to :networks
  end


end
