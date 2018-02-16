require 'rails_helper'

describe Category, type: :model do
  let(:category) { Category.new(name: 'sports') }

  it 'is valid with a name' do
    expect(category).to be_valid
  end

  it 'requires a name' do
    category.name = ' '
    expect(category).to be_invalid
  end

  it 'has a unique name' do
    category.save

    category2 = Category.new(name: 'sports')
    expect(category2).to be_invalid
  end

  it 'cannot have a name longer than 25 characters' do
    category.name = 'a' * 26
    expect(category).to be_invalid
  end

  it 'cannot have a name shorter than 3 characters' do
    category.name = 'aa'
    expect(category).to be_invalid
  end
end
