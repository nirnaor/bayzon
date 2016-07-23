require 'nokogiri'

class DevProvider
  def product_name(url)
    "iPhone"
  end

  def find_sellers(product)
    products = JSON.parse(File.read('test/results.json'))
    while products.size > 0 do
      ProductsChannel.broadcast(product, products.pop(2))
      sleep(2)
    end
  end
end

class ProductionProvider

  def correct_product_name(name)
    # Products can have a lot of names, e.g iPhone, iPhone 4S, iPhone 4s black 
    # 16GB etc. Maybe there's a gem that will solve this problem better (or a 
    # library). At the moment I'll use the first 5 words of the product and 
    # optimize my solution later
    name.truncate_words(3, omission: '')
  end

  def product_name(url)
    doc = Nokogiri::HTML(open(url))
    return correct_product_name(doc.at_css("#itemTitle").children.last.text)
  end

  def filter_products(product, matching_products)
    # There should be a way to remove products that came in the search but are 
    # not identical to the original product we looked for. For example, searching
    # for iPhone 6 might return phones with 64GB, 128GB, or iPhone 6s plus which 
    # is a different product. Currently I don't know how to filter out these
    # products so I'll just return all of them
    matching_products.reject {|p| false }
  end

  def find_sellers(product)
    url = "https://www.amazon.com/s/ref=nb_sb_noss?url=search-alias%3Daps&field-keywords=#{CGI.escape(product)}"
    doc = Nokogiri::HTML(open(url))

    relevant = doc.css("#s-results-list-atf li")
    res = []
    relevant.each {|el|
      name = el.at_css("a.s-access-detail-page h2")
      seller = el.at_css(".a-color-secondary+ .a-color-secondary")
      price = el.at_css(".s-price")

      values = [name, seller, price]
      next if values.include? nil
      res.push(values.map{|x| x.children.last.text})
    }

    ProductsChannel.broadcast(product, res)
    return res
  end
end


def get_provider
  p = {development: DevProvider,  production: ProductionProvider}[Rails.env.to_sym]
  p.new
end
