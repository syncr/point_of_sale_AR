class Customer < ActiveRecord::Base
  has_many :sales
  has_many :cashiers, :through => :sales
end
