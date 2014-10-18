desc "Generate products for the Spree-powered online store"
task :products => :environment do
  WaxPoetic::Seed.generate_products
  puts "generated spree products for all releases and tracks"
end
