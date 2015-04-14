FactoryGirl.define do
  factory :path1, class: Path do
    local 'Sampa'
    begin_point 'A'
    end_point 'B'
    distance 10
    #sequence(:distance){ |n| n*5}
  end
  factory :path2, class: Path do
    local 'Sampa'
    begin_point 'B'
    end_point 'D'
    distance 15
  end
  factory :path3, class: Path do
    local 'Sampa'
    begin_point 'A'
    end_point 'C'
    distance 20
  end
  factory :path4, class: Path do
    local 'Sampa'
    begin_point 'C'
    end_point 'D'
    distance 30
  end
  factory :path5, class: Path do
    local 'Sampa'
    begin_point 'B'
    end_point 'E'
    distance 50
  end
  factory :path6, class: Path do
    local 'Sampa'
    begin_point 'D'
    end_point 'E'
    distance 30
  end      
end