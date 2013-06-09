require 'spec_helper'

describe UcbRails::User do
  
  it '#full_name' do
    UcbRails::User.new().full_name.should == ''
    UcbRails::User.new(first_name: 'first').full_name.should == 'first'
    UcbRails::User.new(last_name: 'last').full_name.should == 'last'
    UcbRails::User.new(first_name: 'first', last_name: 'last').full_name.should == 'first last'
  end
  
  it '#admin!' do
    user = UcbRails::User.create!(uid: 1)
    user.admin!
    user.should be_admin
  end
  
  it '.active' do
    active = UcbRails::User.create(uid: 1)
    inactive = UcbRails::User.create(uid: 2, inactive: true)
    UcbRails::User.active.should == [active]
  end

  it '.admin' do
    admin = UcbRails::User.create(uid: 1)
    admin.admin!
    not_admin = UcbRails::User.create(uid: 2)
    UcbRails::User.admin.should == [admin]
  end
end