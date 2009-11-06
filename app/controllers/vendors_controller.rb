class VendorsController < ApplicationController
  def index
    @vendors  = Vendor.all
  end

  def new
    @vendor  = Vendor.new
  end

  def create
    @vendor = Vendor.new(params[:vendor])
    begin 
      @vendor.save!
      flash[:notice] = "New vendor created."
      redirect_to vendors_path
    rescue
      render :action => "new"
    end
  end

  def edit
    @vendor = Vendor.find(params[:id])
  end

  def show
    @vendor = Vendor.find(params[:id])
  end

  def update
    @vendor = Vendor.find(params[:id])

    if @vendor.update_attributes(params[:vendor])
      flash[:notice] = "Vendor updated."
      redirect_to vendors_path
    else 
      render :action => "edit"
    end

  end

  def destroy

    @vendor = Vendor.find(params[:id])
    @vendor.destroy

    flash[:notice] = "Vendor deleted."
    redirect_to :vendors
  end

end
