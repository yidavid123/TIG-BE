class Gtg < ApplicationRecord
  has_many :gtg_rules, dependent :destroy
  belongs_to :user
end
