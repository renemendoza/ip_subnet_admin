class DevicesController < ApplicationController

  require "lib/phone_investigator"

  def index
    @network = Network.find(params[:network_id])
    @devices  = @network.devices 
    @discoverer = Discoverer.new(@network.address_list, APP_CONFIG[:pwdless_user], APP_CONFIG[:arping_path], APP_CONFIG[:run_as_root]).run.identify_macs(Vendor.vendors_list).result
    #@endors = Vendor.all

  end

  def new
    @network = Network.find(params[:network_id])
      if params[:device].nil?
        @device = Device.new(params[:device])
      else
        @vendor_name = params[:device].delete(:vendor_name)

        if @vendor_name == "other" or @vendor_name == "unknown"
          params[:device].delete(:mac_address) if @vendor_name == "unknown"
          @device = Device.new(params[:device])
        else
          @device = Device.new(params[:device])
          @device.vendor = Vendor.find_by_name(@vendor_name)
          @phone =  PhoneInvestigatorFactory.build(@device.ip_address, @vendor_name)
          @phone.start
          @device.name = @phone.display_name
          @device.host = "ext#{@phone.user_id}"
        end
      end
    @vendors = Vendor.all
  end


  def create
    @device = Device.new(params[:device])
    begin 
      @device.save!
      flash[:notice] = "New device created."
      redirect_to :network_devices
    rescue
      render :action => "new"
    end
  end

  def show
    @device = Device.find(params[:id])
    @network = Network.find(params[:network_id])
  end

  def edit
    @device = Device.find(params[:id])
    @network = Network.find(params[:network_id])
    @vendors = Vendor.all
  end

  def update
    @device = Device.find(params[:id])

    if @device.update_attributes(params[:device])
      flash[:notice] = "Device updated."
      redirect_to devices_path
    else 
      render :action => "edit"
    end

  end

  def destroy

    @device = Device.find(params[:id])
    @device.destroy

    flash[:notice] = "Device deleted."
    redirect_to :network_devices
  end

end
