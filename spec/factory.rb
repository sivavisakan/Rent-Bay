Factory.define :user do |user|
  user.name                  "Michael Hartl"
  user.email                 "mhartl@example.com"
  user.password              "foobar"
  user.password_confirmation "foobar"
end

Factory.define :bid do |bid|
  bid.amount 1
  bid.itemid 1
  bid.userid 2
  bid.association :product
end

