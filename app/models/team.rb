class Team < ActiveRecord::Base

  has_many :team_members

  validates :name, :presence => true,
            :length => { :maximum => 50 },
            :uniqueness => true

end
