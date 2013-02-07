class OrderProduct < ActiveRecord::Base
  attr_accessible :order_id, :product_id, :sell_or_buy, :price, :using_condition

  attr_accessible :order_product_id #for session only
  attr_accessor :order_product_id #for session

  scope :for_buy, :conditions => {:sell_or_buy => "buy"}
  scope :for_sell, :conditions => {:sell_or_buy => "sell"}
  ORDER_TYPES = {"sell" => "Sell", "buy" => "Buy"}
  
  belongs_to :product
  belongs_to :order
  
  def for_buy?
    sell_or_buy && sell_or_buy == "buy"
  end

  def for_sell?
    sell_or_buy && sell_or_buy == "sell"
  end
  
  def title
    result = self.product.title if self.product && !self.product.title.blank?
    result = "#{self.product.category.title} #{self.product.product_model.title}" if result.nil? && self.product && self.product.product_model
    return "#{result} (#{product.flaw_less_name})" if for_buy?
    "#{result} (#{using_condition})"
  end

end