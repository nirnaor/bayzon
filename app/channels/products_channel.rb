# Used to pass products from the scraping process to the client.
class ProductsChannel < ApplicationCable::Channel
  def self.broadcast(product_name, page_products)
    broadcast_to product_name, products:
      HomeController.render(partial: 'home/products',
                            locals: { products: page_products,
                                      product_name: product_name })
  end

  def subscribed
    stream_for params[:product]
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
