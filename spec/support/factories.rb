Factory.sequence :question do |n|
  "Question #{n}"
end

FactoryGirl.define do
  factory :answer, :class => Census::Answer do
    question
    user
    data      'Factory Answer'
  end

  factory :choice, :class => Census::Choice do
    question
    value     'Factory Choice'
  end

  factory :data_group, :class => Census::DataGroup do
    name      'Physical Attributes'
  end

  factory :question, :class => Census::Question do
    data_group
    multiple  false
    other     false
    prompt    { Factory.next :question }
  end

  factory :user, :class => ::User do
  end

  factory :user_with_answers, :parent => :user do
    after_create do |user|
      @question1 = FactoryGirl.create(:question, :prompt => 'Hair Color', :data_type => 'String', :data_group => @data_group)
      @question2 = FactoryGirl.create(:question, :prompt => 'Weight', :data_type => 'Number', :data_group => @data_group)
      @question3 = FactoryGirl.create(:question, :prompt => 'Favorite Color', :data_type => 'String', :multiple => true, :data_group => @data_group)
      @red = FactoryGirl.create(:choice, :question => @question3, :value => 'Red')
      @green = FactoryGirl.create(:choice, :question => @question3, :value => 'Green')
      @blue = FactoryGirl.create(:choice, :question => @question3, :value => 'Blue')
      @yellow = FactoryGirl.create(:choice, :question => @question3, :value => 'Yellow') 
      FactoryGirl.create(:answer, :question => @question1, :data => 'Brown', :user => user)
      FactoryGirl.create(:answer, :question => @question2, :data => '150', :user => user)
      FactoryGirl.create(:answer, :question => @question3, :data => 'Blue', :user => user)
      FactoryGirl.create(:answer, :question => @question3, :data => 'Green', :user => user)
    end
  end
end
