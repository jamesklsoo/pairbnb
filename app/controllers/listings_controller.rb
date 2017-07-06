class ListingsController < ApplicationController
  before_action :find_user, except: :index
  before_action :find_listing, only: [:show, :edit, :update, :destroy]

  def index
    @listings = Listing.all
  end

  def new
    @listing = @user.listings.new
  end

  def show
  end

  def create
    @listing = @user.listings.new(listing_params)
    if @listing.save
      redirect_to [@user, @listing]
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @listing.update(listing_params)
      redirect_to [@user, @listing]
    else
      render :new
    end
  end

  def destroy
    @listing.destroy
    redirect_to root_path
  end
  private

  def listing_params
    params.require(:listing).permit(:name, :property_type, :room_number, :bed_number, :guest_number, :country, :city, :state, :zipcode, :address, :price, :description, :start_date, :end_date)
  end
  def find_user
    @user = User.find(params[:user_id])
  end

  def find_listing
    @listing = @user.listings.find(params[:id])
  end
end
