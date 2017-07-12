class BookingsController < ApplicationController
  def create
    @booking = current_user.bookings.new(booking_params)
    @booking.listing_id = params[:listing_id]
    if @booking.check_overlapping_dates
      if @booking.save
        ReservationJob.perform_now(current_user, User.find(Listing.find(@booking.listing_id).user_id), @booking.listing_id)
        # ReservationMailer.booking_email(current_user, User.find(@booking.host_id) , @booking.listing_id).deliver_now
        flash[:notice] = "Your bookings have been saved!"
        redirect_to user_path(current_user)
      else
        flash[:error] = "There was an error with your booking!"
        redirect_back(fallback_location: listings_path)
      end
    else
      flash[:error] = "The dates you chose are overlapped"
      redirect_back(fallback_location: listings_path)
    end
  end

  def destroy
    @booking = Booking.find(params[:id])
    if @booking.destroy
      flash[:success] = "Congrats, your booking has been destroyed."
      redirect_to user_path
    else
      flash[:error] = "There was a problem in deleting your bookings."
      redirect_back(fallback_location: root_path)
    end
  end


  private
  def booking_params
    params.require(:booking).permit(:date_start, :date_end)
  end
end
