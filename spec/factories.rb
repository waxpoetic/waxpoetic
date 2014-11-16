FactoryGirl.define do
  factory :artist do
    name { |n| "Artist #{n}" }
    bio "i am an artist"
  end

  factory :product, class: 'Spree::Product' do
    name "Artist - Release"
    shipping_category { Spree::ShippingCategory.find_by_name('Default') }
    price 1.00
  end

  factory :variant, class: 'Spree::Variant' do
    name "Artist - Release (WAV)"
    price 1.00
    product
  end

  factory :release do
    name { |n| "Release #{n}" }
    artist
    product
    released_on DateTime.now
    description 'i am a release'
    catalog_number { |n| "WXP-00#{n}" }
  end

  factory :user do
    email { |n| "regular-user-#{n}@example.com" }
    password 'hello123'
  end

  factory :order, class: 'Spree::Order' do
    variants [ FactoryGirl.create(:variant) ]
    user
  end

  factory :download do
    order
  end
end