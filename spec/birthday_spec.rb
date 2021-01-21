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
    @m3 = Marriage.create(:faithful => true,  :anniversary => Date.parse('2009-08-20')).reload
  end

  after :each do
    back_to_the_present
  end

  it 'check anniversary_today? correctly' do
    time_travel_to Date.parse('2011-09-09')
    expect(@m1).to be_anniversary_today
    expect(@m2).not_to be_anniversary_today
  end

  it 'check anniversary_age correctly' do
    time_travel_to Date.parse('2011-09-08')
    expect(@m1.anniversary_age).to eq(1)
    expect(@m2.anniversary_age).to eq(2)
  end

  it 'finds people\'s by anniversary date' do
    time_travel_to Date.parse('2011-08-08')
    anniversaries_today = Marriage.find_anniversaries_for(Date.today)
    expect(anniversaries_today).not_to include(@m1)
    expect(anniversaries_today).to include(@m2)
  end

  it 'finds people\'s by anniversary date - dumb scope' do
    time_travel_to Date.parse('2011-08-08')
    anniversaries_today = Marriage.anniversary_today
    expect(anniversaries_today).not_to include(@m1)
    expect(anniversaries_today).to include(@m2)
  end

  it 'finds people\'s by anniversary dates' do
    anniversaries = Marriage.find_anniversaries_for(Date.parse('2011-08-01'), Date.parse('2011-12-12'))
    expect(anniversaries).to include(@m1)
    expect(anniversaries).to include(@m2)
  end

  it 'finds people\'s by anniversary dates with years overlapping' do
    anniversaries = Marriage.find_anniversaries_for(Date.parse('2011-09-01'), Date.parse('2012-08-12'))
    expect(anniversaries).to include(@m1)
    expect(anniversaries).to include(@m2)
    expect(anniversaries).not_to include(@m3)
  end
end

describe Person do

  before :each do
    @p1 = Person.create(:name => "Twilight Sparkle", :birthday => Date.parse('2006-09-09')).reload
    @p2 = Person.create(:name => "Rainbow Dash",     :birthday => Date.parse('2004-08-08')).reload
    @p3 = Person.create(:name => "Floofy Dude",      :birthday => Date.parse('2005-08-20')).reload
  end

  after :each do
    back_to_the_present
  end

  it 'check birthday_today? correctly' do
    time_travel_to Date.parse('2011-09-09')
    expect(@p1).to be_birthday_today
    expect(@p2).not_to be_birthday_today
  end

  it 'check birthday_age correctly' do
    time_travel_to Date.parse('2011-09-08')
    expect(@p1.birthday_age).to eq(4)
    expect(@p2.birthday_age).to eq(7)
  end

  it 'finds people\'s by birthday date' do
    time_travel_to Date.parse('2011-08-08')
    birthdays_today = Person.find_birthdays_for(Date.today)
    expect(birthdays_today).not_to include(@p1)
    expect(birthdays_today).to include(@p2)
  end

  it 'finds people\'s by birthday date - dumb scope' do
    time_travel_to Date.parse('2011-08-08')
    birthdays_today = Person.birthday_today
    expect(birthdays_today).not_to include(@p1)
    expect(birthdays_today).to include(@p2)
  end

  it 'finds people\'s by birthday dates' do
    birthdays = Person.find_birthdays_for(Date.parse('2011-08-01'), Date.parse('2011-12-12'))
    expect(birthdays).to include(@p1)
    expect(birthdays).to include(@p2)
  end

  it 'finds people\'s by birthday dates with years overlapping' do
    birthdays = Person.find_birthdays_for(Date.parse('2011-09-01'), Date.parse('2012-08-12'))
    expect(birthdays).to include(@p1)
    expect(birthdays).to include(@p2)
    expect(birthdays).not_to include(@p3)
  end
end
