# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class ProductsChannel < ApplicationCable::Channel
  def self.broadcast(product_name, page_products)
    broadcast_to product_name, products:
      HomeController.render(partial: "home/products", locals: {products: page_products, product_name: product_name})
  end
    
  def subscribed
    stream_for params[:product]
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
