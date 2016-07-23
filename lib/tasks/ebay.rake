require 'data_providers'

namespace :ebay do
  desc "TODO"
  task product_name: :environment do
    url = "http://www.ebay.com/itm/Locked-Apple-Watch-Sport-42mm-Space-Gray-Aluminum-Case-Black-Sport-Band-/222187579880?hash=item33bb6969e8:g:3MEAAOSwc1FXcRa1"
    p = ProductionProvider.new
    print p.product_name(url)
  end

end
