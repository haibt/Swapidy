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

post "/create_transaction" do
  result = Braintree::Transaction.sale(
    :amount => "1000.00",
    :credit_card => {
      :number => params[:number],
      :cvv => params[:cvv],
      :expiration_month => params[:month],
      :expiration_year => params[:year]
    },
    :options => {
      :submit_for_settlement => true   #remove to just authorize
    }
  )

  if result.success?
    "<h1>Success! Transaction ID: #{result.transaction.id}</h1>"
  else
    "<h1>Error: #{result.message}</h1>"
  end
end