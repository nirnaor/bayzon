require 'nokogiri'

def product_name(url)
  doc = Nokogiri::HTML(open(url))
  return doc.at_css("#itemTitle").children.last.text
end
