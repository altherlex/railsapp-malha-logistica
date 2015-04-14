FactoryGirl.define do
=begin  
  factory :map do
    local "Sampa"
    begin_point 
    end_point 
    sequence(:distance){|i| i*5}
  end
=end  
  factory :paths do
    
  end
end

A B 10
B D 15
A C 20
C D 30
B E 50
D E 30