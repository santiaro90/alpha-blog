require 'rails_helper'

describe CategoriesController, type: :controller do
  context 'when not logged in' do
    describe '#index' do
      it 'gets all categories' do
        FactoryBot.create_list(:category, 2)

        get :index
        expect(assigns(:categories).length).to eq(2)
      end
    end

    describe '#new' do
      it 'redirects to #index' do
        get :new
        expect(response).to redirect_to(categories_path)
      end
    end

    describe '#show' do
      it 'gets a category' do
        category = FactoryBot.create(:category)

        get :show, id: category.id
        expect(assigns(:category)).to eq(category)
      end
    end
  end

  context 'when logged in as a regular user' do
    before { session[:user_id] = FactoryBot.create(:user).id }
    after { session[:user_id] = nil }

    describe '#new' do
      it 'redirects to #index' do
        get :new
        expect(response).to redirect_to(categories_path)
      end
    end

    describe '#create' do
      it 'redirects to #index' do
        expect do
          post :create, category: { name: 'programming' }
        end.to_not(change { Category.count })

        expect(response).to redirect_to(categories_path)
      end
    end
  end

  context 'when logged in as an admin' do
    before { session[:user_id] = FactoryBot.create(:admin).id }
    after { session[:user_id] = nil }

    describe '#new' do
      it 'gets the create category page' do
        get :new
        expect(assigns(:category)).to be_a_new(Category)
      end
    end

    describe '#create' do
      it 'creates a category' do
        expect do
          post :create, category: { name: 'programming' }
        end.to change { Category.count }.by(1)

        expect(Category.last.name).to eq('programming')
      end
    end
  end
end
