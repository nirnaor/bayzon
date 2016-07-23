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
  return res
end
