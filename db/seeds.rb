if Report.all.size.zero?
  report = Report.new({
    abducted_quantity: 0,
    survivors_quantity: 0
  })
  report.save
else
  report = Report.find(1)
end

survivors = 200
witnesses = 500

survivors.times do
  survivor = Survivor.create({
    name: Faker::Simpsons.character,
    gender: Faker::Gender.binary_type,
    age: Random.rand(51),
    abducted: false
  })
  survivor.localization = Localization.new({
    latitude: rand(101) + rand,
    longitude: rand(101) + rand
  })
  report.update({survivors_quantity: report.survivors_quantity + 1})

end

witnesses.times do
  survivor_id = rand(survivors) + 1 
  survivor = Survivor.find(survivor_id)

  witness_id = rand(survivors) + 1
  witness_id += 1 if witness_id == survivor_id

  if survivor.witnesses.size == 2
    survivor.update({abducted: true})
    report.update({abducted_quantity: report.abducted_quantity + 1})
  end

  survivor.witnesses.create({witness_id: witness_id})
end