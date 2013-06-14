class UcbRails::User < ActiveRecord::Base
  self.table_name = 'users'
  
  attr_accessible :uid, :first_name, :last_name, :inactive
  
  before_validation :set_first_last_name
  
  def admin!
    update_attribute(:admin, true)
  end
  
  def self.active
    where(inactive: false)
  end
  
  def self.admin
    where(admin: true)
  end
  
  private
  
  def set_first_last_name
    self.first_last_name = [first_name, last_name]
      .select { |n| n.present? }
      .join(' ')
      .presence
  end
end