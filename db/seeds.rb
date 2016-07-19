["Sports", "Art", "Pet", "Music", "Games", "Gardening", "Others", "Phones", "Cameras", "Magic"].each do |cat|
  Category.create name: cat
end

10.times { Tag.create(title: Faker::Hacker.adjective)}
