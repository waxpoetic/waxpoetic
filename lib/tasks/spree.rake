namespace :spree do
  desc "Configure global settings for the Spree::Store."
  task :configure_store => :environment do
    WaxPoetic::Store.configure_store
    puts "configured the waxpoetic online store"
  end

  desc "Generate Spree::Products from Releases"
  task :generate_products => :environment do
    WaxPoetic::Store.generate_products
    puts "generated spree products for all releases"
  end
end

desc "Configure and generate assets for the Spree-powered online store"
task :spree => %w(spree:configure_store spree:generate_products)
