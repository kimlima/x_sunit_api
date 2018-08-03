20.times do
  survivor = Survivor.create({
    name: Faker::Simpsons.character,
    gender: Faker::Gender.binary_type,
    age: Random.rand(51),
    abducted: false
  })
  survivor.localization = Localization.new({
    latitude: rand,
    longitude: rand
  })
end