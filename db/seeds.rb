require 'faker'


20.times do
  Item.create!(
    name: Faker::Name.unique.name,
    description: Faker::Lorem.sentence,
    price: Faker::Commerce.price(range: 10..100),
    image_url: Faker::Internet.url,
  )
end

puts "20 items ont été créés"
