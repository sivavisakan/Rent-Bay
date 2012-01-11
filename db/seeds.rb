# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#
#  Mayor.create(:name => 'Daley', :city => cities.first)

Product.delete_all

Product.create(:Name => 'Programming Ruby 1.9',
:Description =>
%{
Ruby is the fastest growing and most exciting dynamic language out
there. If you need to get working programs delivered fast, you should
add Ruby to your toolbox.
},
:Upload_Picture => 'rails.png',
:Price => 49.5,
:Rental_Period => %{This is currently not for renting.})

