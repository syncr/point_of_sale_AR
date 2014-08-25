class Product < ActiveRecord::Base
  has_many :purchases
  has_many :sales, through: :purchases
  validates :name, presence: true
  before_save :upcase_name

  def self.find_category(category_input)
    where(:category => category_input)
  end

private

  def upcase_name
    self.name = self.name.upcase
  end
end

