require 'rails_helper'

feature 'Categories listing' do
  background do
    Category.create([{ name: 'sports' }, { name: 'programming' }])
  end

  scenario 'shows all the categories' do
    visit categories_path

    expect(page).to have_link('sports')
    expect(page).to have_link('programming')
  end
end
