class DhcpOptionsController < ApplicationController

  def index
    @network = Network.find(params[:network_id])
    @dhcp_options  = @network.dhcp_options 
  end

  def new
    @network = Network.find(params[:network_id])
    @dhcp_option  = DhcpOption.new
  end

  def create
    @dhcp_option  = DhcpOption.new(params[:dhcp_option])
    begin 
      @dhcp_option.save!
      flash[:notice] = "New dhcp option created."
      redirect_to :network_dhcp_options
    rescue
      render :action => "new"
    end
  end

  def show
  end

  def edit
  end

end
