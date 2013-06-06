class UcbRails::User < ActiveRecord::Base
  self.table_name = 'users'
  
  def full_name
    [first_name, last_name].map(&:presence).compact.join(' ')
  end
  
  def self.active
    where(inactive: false)
  end
end