class MoneyController < ApplicationController
  def index
    render(:index)
  end

  def get_paid
    paypal_options = {
      no_shipping: true, # if you want to disable shipping information
      pay_on_paypal: true # if you don't plan on showing your own confirmation step
    }

    request = Paypal::Express::Request.new(
      :username   => "sdk-three_api1.sdk.com",
      :password   => "QFZCWN5HZM8VBG7Q",
      :signature  => "A-IzJhZZjhg29XQ2qnhapuwxIDzyAZQ92FRP5dqBzVesOkzbdUONzmOU"
    )
    payment_request = Paypal::Payment::Request.new(
      :currency_code => :USD,   # if nil, PayPal use USD as default
      :description   => "Gimme my money. Or else.",    # item description
      :quantity      => 1,      # item quantity
      :amount        => 1.00   # item value
    )
    response = request.setup(
      payment_request,
      collect_path(result: 'money'),
      collect_path(result: 'wtf'),
      paypal_options  # Optional
    )

    redirect_to response.redirect_uri
  end

  def collect
    render json: params
  end
end
