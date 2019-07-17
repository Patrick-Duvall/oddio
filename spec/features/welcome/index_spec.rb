require 'rails_helper'

RSpec.describe "Welcome Index" do
  describe 'as a visitor' do
    before(:each) do
      visit '/'
    end

    it 'loads the page' do
      expect(current_path).to eq(root_path)
      expect(status_code).to eq(200)
    end

    it 'shows basic info about the site' do
      expect(page).to have_content('Welcome to Oddio')
      # TODO: Issue #16 - Add brief description of the site & sample content
      expect(page).to have_link('Enter')
      expect(page).to have_selector(:css, "a[href=\"#{landmarks_path}\"]")
    end
    
    it 'has links to register and login' do
      expect(page).to have_link('Register')
      expect(page).to have_selector(:css, "a[href=\"#{new_user_path}\"]")

      expect(page).to have_link('Login')
      expect(page).to have_selector(:css, "a[href=\"#{login_path}\"]")
    end
  end
end