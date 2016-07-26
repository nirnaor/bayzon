require 'nokogiri'
require 'mechanize'

# Dev provider for faster debugging.
class DevProvider
  def product_name(_url)
    'iPhone'
  end

  def find_sellers(product)
    products = JSON.parse(File.read('test/results.json'))
    until products.empty
      ProductsChannel.broadcast(product, products.pop(2))
      sleep(2)
    end
  end
end

# Production provider that works with Amazon and Ebay.
class ProductionProvider
  def correct_product_name(name)
    # Products can have a lot of names, e.g iPhone, iPhone 4S, iPhone 4s black
    # 16GB etc. Maybe there's a gem that will solve this problem better (or a
    # library). At the moment I'll use the first 5 words of the product and
    # optimize my solution later.
    name.truncate_words(3, omission: '')
  end

  def product_name(url)
    agent = Mechanize.new
    agent.user_agent_alias = 'Mac Safari'
    agent.get(url)
    title = agent.page.search('#itemTitle')
    correct_product_name(title.first.children.last.text)
  end

  def filter_products(_product, matching_products)
    # There should be a way to remove products that came in the search but are
    # not identical to the original product we looked for. For example,
    # searching for iPhone 6 might return phones with 64GB, 128GB,
    # or iPhone 6s plus which is a different product. Currently I don't
    # know how to filter out these  products so I'll just return all of them.
    matching_products.reject { false }
  end

  def find_sellers(product)
    url = "https://www.amazon.com/s/ref=nb_sb_noss?url=search-alias%3Daps&"\
    "field-keywords=#{CGI.escape(product)}"
    agent = Mechanize.new
    agent.user_agent_alias = 'Mac Safari'
    page = agent.get(url)

    loop do
      find_sellers_for(page, product)
      link = page.link_with(dom_id: 'pagnNextLink')
      link.nil? ? break : page = link.click
    end
  end

  def values_from(el)
    name = el.search('a.s-access-detail-page h2').first
    seller = el.search('.a-color-secondary+ .a-color-secondary').first
    price = el.search('.s-price').first
    [name, seller, price]
  end

  def find_sellers_for(doc, product)
    # doc = Nokogiri::HTML(open(url))

    relevant = doc.search('#s-results-list-atf li')
    res = []
    relevant.each do |el|
      values = values_from el
      next if values.include? nil
      res.push(values.map { |x| x.children.last.text })
    end

    ProductsChannel.broadcast(product, res)
    res
  end
end

def provider
  return ProductionProvider.new
  p = { development: DevProvider,
        production: ProductionProvider }[Rails.env.to_sym]
  p.new
end
