require 'data_providers'

# Main controller of the app.
class HomeController < ApplicationController
  def sellers
    product = params[:product]
    provider.find_sellers(product)
    render text: 'done'
  end

  def search
  end

  def product_name
    query = params[:query]
    begin
      product_name = provider.product_name(query)
    rescue StandardError => ex
      logger.error ex.backtrace
      flash[:warning] = 'There was a problem fetching the product name'
      render :search && return
    end

    flash[:success] = 'Displaying sellers for product #{product_name}'
    render :index, locals: { products: [], product_name: product_name }
  end

  def index
  end
end
