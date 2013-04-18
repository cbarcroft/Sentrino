class Log < ActiveRecord::Base
	belongs_to :user

	attr_accessible :log_text, :log_type
end