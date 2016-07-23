require 'nokogiri'

def correct_product_name(name)
  ## Products can have a lot of names, e.g iPhone, iPhone 4S, iPhone 4s black 
  # 16GB etc. Maybe there's a gem that will solve this problem better (or a 
  # library). At the moment I'll use the first 5 words of the product and 
  # optimize my solution later
  name.truncate_words(5, omission: '')
end

def product_name(url)
  doc = Nokogiri::HTML(open(url))
  return correct_product_name(doc.at_css("#itemTitle").children.last.text)
end
