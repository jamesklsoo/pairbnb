class ReservationMailer < ApplicationMailer
  def booking_email(customer, host, reservation_id)
    @user = customer
    @host = host
    @reservation_id = reservation_id
    @url = "localhost:3000/users/#{@host.id}"
    mail(to: "jamesklsoo@gmail.com", subject: "Your place was booked.")
  end
end
