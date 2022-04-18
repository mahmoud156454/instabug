5.times do
    Application.create({
        name: Faker::App.name
    })
end