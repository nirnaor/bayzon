require 'amazon'

namespace :amazon do
  task sellers: :environment do
    product = "phone"
    print search(product)
  end
end
