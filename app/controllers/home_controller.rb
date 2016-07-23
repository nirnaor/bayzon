require 'data_providers'

class HomeController < ApplicationController

  def sellers
    product = params[:product]
    provider = get_provider()
    provider.find_sellers(product)
    render text: "done"
  end

  def search
  end

  def product_name
    query = params[:query]
    provider = get_provider()
    begin
      product_name = provider.product_name(query)
    rescue Exception => ex
      logger.error ex.backtrace
      flash[:warning] = "There was a problem fetching the product name from ebay"
      render :search and return
    end

    flash[:success] = "Displaying sellers in Amazon for product #{product_name}"
    render :index, locals: {products: [], product_name: product_name}

  end

  def index
  end

end
