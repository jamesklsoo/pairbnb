class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :listing

  def overlap?(x,y) #x is listing , y is booking
    if (Date.strptime(x.date_start, '%m/%d/%Y') - Date.strptime(y.date_end, '%m/%d/%Y')) * (Date.strptime(y.date_start, '%m/%d/%Y') - Date.strptime(x.date_end, '%m/%d/%Y')) > 0
      return true
    else
      return false
    end
    # if y.date_start < x.date_start
    #   flash[:error1] = "The place is not yet available at this date yet."
    #   return true
    # elsif y.date_end > x.date_end
    #   flash[:error1] = "The place is not available until your end date"
    #   return true
  end

  def check_pax

  end


  def check_overlapping_dates
    self.listing.bookings.each do |x|
      if overlap?(self, x)
        return false
      end
    end
    return true
  end

  def host_id
    return self.listing.user_id
  end
end
