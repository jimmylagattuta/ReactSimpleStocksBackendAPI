class Stock < ApplicationRecord
	has_many :portfolios, through: :portfolio_stocks
	has_many :portfolio_stocks
end
