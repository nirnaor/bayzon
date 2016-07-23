require 'amazon'

namespace :amazon do
  task sellers: :environment do
    product = "phone"
    print find_sellers(product)
  end
end
