namespace :amazon do
  task sellers: :environment do
    p = ProductionProvider.new
    print p.find_sellers("phone")
  end
end
