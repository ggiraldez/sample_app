# coding: utf-8
# by using the symbol ':users', we get Factory Girl to simulate the User model.
Factory.define :user do |user|
  user.name                  "Gustavo Giráldez"
  user.email                 "gustavo@example.com"
  user.password              "foobar"
  user.password_confirmation "foobar"
end
