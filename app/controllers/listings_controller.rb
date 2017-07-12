class ListingsController < ApplicationController
  def new
    if current_user.customer?
      @listing = Listing.new
    else
      flash[:error] = "You are not a customer of Blairbnb"
      redirect_back(fallback_location: root_path)
    end
  end

  def index
    if params[:@number]
      @number = params[:@number]
    else
      @number ||= 0 unless @number
    end

    if params[:@number]
      @listings = Listing.order(:id).limit(10).offset(params[:@number])
    else
      @listings = Listing.order(:id).limit(10).offset(@number)
    end

    filtering_params(params).each do |key, value|
      @listings = @listings.public_send(key, value) if value.present?
    end

    # if params[:search]
    #   @listings = Listing.search(params[:search]).order("created_at DESC")
    # end
  end

  def create
    @listing = current_user.listings.new(listing_params)
    # @listing = Listing.new(listing_params)
    # @listing.user_id = current_user.id
    respond_to do |format|
      if @listing.save
        format.html {
          flash[:notice] = "Listing is created!"
          redirect_to root_path
        }
      else
        # format.html {
        #   flash[:notice] = "Some fields are not correct"
        #   redirect_to new_listing_path
        # }
        format.js
      end
    end
  end

  def update
    listing = Listing.find(params[:id])
    if params[:verification]
      if allowed?(action: "verify", user: current_user)
        if listing.update(verification: true)
          flash[:notice] = "Listing verified"
        else
          flash[:error] = "There was an error verifying your property."
        end
      else
        flash[:notice] = "You do not have permission"
      end
      redirect_back(fallback_location: root_path)
    else
      if listing.update(listing_params)
        flash[:notice] = "Listing is successfully updated!"
        redirect_to root_path
      else
        flash[:notice] = "There was an error updating your listing"
        redirect_to user_path
      end
    end
  end

  def edit
    @listing = Listing.find(params[:id])
  end

  def destroy
    listing = Listing.find(params[:id])

    if listing.destroy
      flash[:notice] = "Listing destroyed"
      redirect_to root_path
    else
      flash[:error] = "Listing can't be destroyed"
      redirect_to user_path
    end
  end

  def show
    @listing = Listing.find(params[:id])
    @booking = Booking.new
  end


  private
  def listing_params
    params.require(:listing).permit({photos: []},:verification, :tag_list, :name, :description, :house_rules, :number_of_beds, :number_of_guests, :number_of_bedrooms, :number_of_bathrooms, :street, :city, :country, :price, :state, :date_start, :date_end, :category_list)
  end

  def filtering_params(params)
    params.slice(:search)
  end
end
