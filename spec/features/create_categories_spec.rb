require 'rails_helper'

feature 'Create a category' do
  let(:admin) { FactoryBot.create(:admin) }

  background do
    login_as admin, 'password'
    visit new_category_path
  end

  scenario 'adds a category with valid input' do
    fill_in 'Name', with: 'sports'
    click_button 'Save'

    expect(page).to have_content('Category was created successfully')
    expect(page).to have_link('sports')
  end

  scenario 'fails with invalid input' do
    click_button 'Save'
    expect(page).to have_content("Name can't be blank")

    visit categories_path
    expect(page).to_not have_selector('a[href~="/categories/"]')
  end
end
