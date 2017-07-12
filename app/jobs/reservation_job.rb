class ReservationJob < ApplicationJob
  queue_as :default

  def perform(user, host, reservation_id)
    ReservationMailer.booking_email(user, host, reservation_id).deliver_now
  end
end
