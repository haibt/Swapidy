require "rubygems"
require "sinatra"
require "braintree"

Braintree::Configuration.environment = :sandbox
Braintree::Configuration.merchant_id = "98k6p9mfy8dt3jh3"
Braintree::Configuration.public_key = "9f5jykf6btqdrftx"
Braintree::Configuration.private_key = "6af781e6e0bf8f2bcfdc7f59bb353e87"

get "/" do
  erb :braintree
end

post '/create_customer' do
  result = Braintree::Customer.create(
    :first_name => params[:first_name],
    :last_name => params[:last_name],
    :credit_card => {
      :billing_address => {
        :postal_code => params[:postal_code]
      },
      :number => params[:number],
      :expiration_month => params[:month],
      :expiration_year => params[:year],
      :cvv => params[:cvv]
    }
  )
  if result.success?
    "<h1>Customer created with name: #{result.customer.first_name} #{result.customer.last_name}</h1>"
  else
    "<h1>Error: #{result.message}</h1>"
  end
end