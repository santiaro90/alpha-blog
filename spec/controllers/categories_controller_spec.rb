require 'rails_helper'

describe CategoriesController, type: :controller do
  before { Category.create([{ name: 'sports' }, { name: 'health' }]) }

  context 'when not logged in' do
    describe '#index' do
      it 'gets all categories' do
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
        category = Category.first

        get :show, id: category.id
        expect(assigns(:category)).to eq(category)
      end
    end
  end

  context 'when logged in' do
    before do
      admin = { username: 'adminguy', email: 'admin@example.com', password: 'password', admin: true }
      regular = { username: 'regular', email: 'regular@example.com', password: 'password', admin: false }

      User.create([admin, regular])
    end

    after(:each) { session[:user_id] = nil }

    let(:admin) { User.first }
    let(:regular) { User.last }

    describe '#new' do
      it 'redirects to #index for non-admins' do
        session[:user_id] = regular.id
        get :new

        expect(response).to redirect_to(categories_path)
      end

      it 'gets the new page for admins' do
        session[:user_id] = admin.id
        get :new

        expect(assigns(:category)).to be_a_new(Category)
      end
    end

    describe '#create' do
      it 'redirects to #index for non-admins' do
        session[:user_id] = regular.id

        expect do
          post :create, category: { name: 'programming' }
        end.to_not change { Category.count }

        expect(response).to redirect_to(categories_path)
      end

      it 'creates a category for admins' do
        session[:user_id] = admin.id

        expect do
          post :create, category: { name: 'programming' }
        end.to change { Category.count }.by(1)
      end
    end
  end
end
