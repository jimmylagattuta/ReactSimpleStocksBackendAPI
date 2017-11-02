class PortfolioStock < ApplicationRecord
	has_many :stocks
	belongs_to :portfolio 
end
