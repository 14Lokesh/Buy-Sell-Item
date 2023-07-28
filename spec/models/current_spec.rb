# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Current, type: :model do
  describe 'attributes' do
    it 'has a user attribute' do
      user = User.new(username: 'Lokesh', email: 'lokeshkumarchaman@gmail.com')
      Current.user = user
      expect(Current.user).to eq(user)
    end
  end
end
