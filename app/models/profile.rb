class Profile < ActiveRecord::Base

  belongs_to :user

  validates :first_name, :last_name, :birthdate, :presence => true
  validates :first_name, :last_name, :length => { in: 1..20 }
  validates :gender, :inclusion => { in: ["Female", "Male"] }
  # validates :telephone, :length => { in: 7..17 }
  validate :valid_birthdate

  def valid_birthdate

    unless birthdate && birthdate.between?(Date.today - 125.years, Date.today)
      errors.add(:birthdate, "Please enter a valid birthdate")
    end

  end

  def full_name

    self.first_name + " " + self.last_name

  end
  
end
