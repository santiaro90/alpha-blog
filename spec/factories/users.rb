FactoryBot.define do
  factory :user do
    username 'johndoe'
    email 'johndoe@example.com'
    password 'password'
    admin false

    factory :admin do
      admin true
    end
  end
end
