require File.join(File.dirname(__FILE__), 'spec_helper')

class Person < ActiveRecord::Base
  acts_as_birthday :birthday
end

class Marriage < ActiveRecord::Base
  acts_as_birthday :anniversary
end

describe Marriage do

  before :each do
    @m1 = Marriage.create(:faithful => true,  :anniversary => Date.parse('2009-09-09')).reload
    @m2 = Marriage.create(:faithful => false, :anniversary => Date.parse('2009-08-08')).reload
  end

  after :each do
    back_to_the_present
  end

  it 'check anniversary_today? correctly' do
    time_travel_to Date.parse('2011-09-09')
    @m1.should be_anniversary_today
    @m2.should_not be_anniversary_today
  end

  it 'check anniversary_age correctly' do
    time_travel_to Date.parse('2011-09-08')
    @m1.anniversary_age.should eq(1)
    @m2.anniversary_age.should eq(2)
  end
  
  it 'finds people\'s by anniversary date' do
    time_travel_to Date.parse('2011-08-08')
    anniversaries_today = Marriage.find_anniversaries_for(Date.today)
    anniversaries_today.should_not include(@m1)
    anniversaries_today.should include(@m2)
  end

  it 'finds people\'s by anniversary dates' do
    anniversaries = Marriage.find_anniversaries_for(Date.parse('2011-08-01'), Date.parse('2011-12-12'))
    anniversaries.should include(@m1)
    anniversaries.should include(@m2)
  end

  it 'finds people\'s by anniversary dates with years overlapping' do
    anniversaries = Marriage.find_anniversaries_for(Date.parse('2011-09-01'), Date.parse('2012-08-12'))
    anniversaries.should include(@m1)
    anniversaries.should include(@m2)
  end
end

describe Person do

  before :each do
    @p1 = Person.create(:name => "Twilight Sparkle", :birthday => Date.parse('2006-09-09')).reload
    @p2 = Person.create(:name => "Rainbow Dash",     :birthday => Date.parse('2004-08-08')).reload
  end

  after :each do
    back_to_the_present
  end

  it 'check birthday_today? correctly' do
    time_travel_to Date.parse('2011-09-09')
    @p1.should be_birthday_today
    @p2.should_not be_birthday_today
  end

  it 'check birthday_age correctly' do
    time_travel_to Date.parse('2011-09-08')
    @p1.birthday_age.should eq(4)
    @p2.birthday_age.should eq(7)
  end
  
  it 'finds people\'s by birthday date' do
    time_travel_to Date.parse('2011-08-08')
    birthdays_today = Person.find_birthdays_for(Date.today)
    birthdays_today.should_not include(@p1)
    birthdays_today.should include(@p2)
  end

  it 'finds people\'s by birthday dates' do
    birthdays = Person.find_birthdays_for(Date.parse('2011-08-01'), Date.parse('2011-12-12'))
    birthdays.should include(@p1)
    birthdays.should include(@p2)
  end

  it 'finds people\'s by birthday dates with years overlapping' do
    birthdays = Person.find_birthdays_for(Date.parse('2011-09-01'), Date.parse('2012-08-12'))
    birthdays.should include(@p1)
    birthdays.should include(@p2)
  end
end