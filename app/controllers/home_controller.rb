require 'amazon'
require 'ebay'

class HomeController < ApplicationController
  def search
  end

  def fetch_sellers
    query = params[:query]
    product_name = product_name(query)
    @products = find_sellers(product_name)
    render :index
  end

  def index
  end
end
