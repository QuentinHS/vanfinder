# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# Destroy listings and amenities before seeding
Listing.destroy_all
Amenity.destroy_all
# Seed amenities to database
amenities = [
    Amenity.create!(name: "shower"),
    Amenity.create!(name: "air conditioning"),
    Amenity.create!(name: "heater"),
    Amenity.create!(name: "fan"),
    Amenity.create!(name: "solar"),
    Amenity.create!(name: "inverter"),
    Amenity.create!(name: "stove"),
    Amenity.create!(name: "oven"),
    Amenity.create!(name: "fridge"),
    Amenity.create!(name: "bike rack"),
    Amenity.create!(name: "water tank"),
    Amenity.create!(name: "sink"),
    Amenity.create!(name: "tv")
]