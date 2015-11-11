require 'rails_helper'

describe Profile do

  let(:profile) { build(:profile) }

  describe 'Birthdate validations' do

    it 'accepts a valid birthdate' do
      profile.birthdate = Date.today
      expect(profile).to be_valid
    end

    it 'accepts a birthdate that is up to 125 years ago from today' do
      profile.birthdate = Date.today - 125.years
      expect(profile).to be_valid
    end

    it 'rejects a birthdate from the future' do
      profile.birthdate = Date.tomorrow
      expect(profile).to be_invalid
    end

    it 'rejects a birthdate that is more than 125 years ago from today' do
      profile.birthdate = Date.yesterday - 125.years
      expect(profile).to be_invalid
    end

  end

end