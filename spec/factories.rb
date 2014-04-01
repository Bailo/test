FactoryGirl.define do
  factory :user do
    name                  "Gavrila Kirin"
    email                 "example@mail.com"
    password              "foobar"
    password_confirmation "foobar"
  end
end