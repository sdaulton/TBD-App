# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Product.delete_all

Product.create!(name: "Plush toy", description: "It's cuddly and soft.  What more could you ask?", price: 4.99)
Product.create!(name: "Buzz Lightyear Action Figure", description: "Buzz Lightyear: for your inner space cadet.", price: 17.99, minimum_age_appropriate: 3)
Product.create!(name: "Lost puppies board game", description: "Cooperative game in which you collaborate to get lost puppies home before dark.", price: 19.99, minimum_age_appropriate: 4, maximum_age_appropriate: 12)
Product.create!(name: "Stick", description: "Yes, it's a real stick.  Wooden.  A stick.", price: 0.50, minimum_age_appropriate: 5)
Product.create!(name: "Koosh ball", description: "Far too much fun to throw these at an unsuspecting friend.  Makes a bad pillow.", price: 5.99, minimum_age_appropriate: 5)
Product.create!(name: "Stacking blocks", description: "Build them up, knock them down.  Endless entertainment.", price: 11.99, minimum_age_appropriate: 1, maximum_age_appropriate: 5)
Product.create!(name: "Crinkly bunny", description: "This fine bunny makes crinkly plastic noise when you touch it.  Will blow your baby's mind.", price: 2.99, minimum_age_appropriate: 0, maximum_age_appropriate: 0)

