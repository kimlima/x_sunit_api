5.times do 
  Survivor.create({
    name: Faker::Simpsons.character,
    age: Random.rand(51),
    gender: Faker::Gender.binary_type,
    abducted: false
  })
end
