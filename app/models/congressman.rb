require_relative '../../db/config.rb'

class Congressman < ActiveRecord::Base

  belongs_to :party

end
