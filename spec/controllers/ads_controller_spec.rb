require 'rails_helper'
require 'capybara/rspec'
require 'factory_girl_rails'
require 'spec_helper'
describe AdsController do
  describe "GET #index" do
    it "responds successfully and renders index template" do
      get :index
      expect(response).to be_success
      expect(response).to render_template(:index)
    end
    it "populates array of ads" do
      ad1 = create(:ad)
      ad2 = create(:ad)
      get :index
      expect(assigns(:ads)).to contain_exactly(ad1, ad2)
    end
  end

  describe "GET #show" do
    it "responds successfully and renders show template" do
      ad = create(:ad)
      get :show, params: { id: ad.id }
      expect(response).to be_success
      expect(response).to render_template(:show)
    end
    it "assigns requested ad to @ad" do
      ad = create(:ad)
      get :show, params: { id: ad.id }
      expect(assigns(:ad)).to eq ad
    end
  end
  describe "GET #new" do
    it "responds successfully and renders new template" do
    get :new
    expect(response).to be_success
    expect(response).to render_template(:new)
    end
    it "assigns a new Ad to @ad" do
    get :new
    expect(assigns(:ad)).to be_a_new(Ad)
    end
  end
  describe "GET #edit" do
    it "responds successfully and renders edit template" do
    ad = create(:ad)
    get :edit, params: { id: ad }
    expect(response).to be_success
    expect(response).to render_template(:edit)
    end
    it "assigns requested ad to @ad" do
    ad = create(:ad)
    get :edit, params: { id: ad }
    expect(assigns(:ad)).to eq ad
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
    it "save new ad" do
    expect {
    post :create, params: { ad: { title: 'Tytuł', description: 'Opis' }}
  }.to change(Ad, :count).by(1)
    end
    it "save new ad with expected attributes" do
      post :create, params: { ad: { title: 'Tytuł', description: 'Opis' }}
      expect(Ad.count).to be > 0
      expect(Ad.last.title).to eq 'Tytuł'
      expect(Ad.last.description).to eq 'Opis'
    end
      context "with invalid attributes" do
      it "does not save new ad" do
        expect {
          post :create, params: { ad: { title: 'Tytuł zdjęcia' }}
        }.to_not change(Ad, :count)
      end
      it "re-renders the :new template" do
        post :create, params: { ad: { title: 'Tytuł zdjęcia' }}
        expect(response).to render_template :new
      end
    end
    it "redirects to show page" do
    post :create, params: { ad: { title: 'Tytuł', description: 'Opis' }}
    expect(response).to redirect_to ad_path(1)
      end
    end
  end

  describe "PATCH #update" do
    let(:ad) { create(:ad, title: 'Tytuł') }
    it "finds requested ad" do
      put :update, params: { id: ad, ad: { title: "Nowy Tytuł" }}
      expect(assigns(:ad)).to eq ad
    end
  context "valid attributes" do
    it "changes ad's attributes" do
  put :update, params: { id: ad, ad: { title: "Nowy Tytuł" }}
  ad.reload
  expect(ad.title).to eq "Nowy Tytuł"
  end
  it "redirects to updated ad" do
  put :update, params: { id: ad, ad: { title: "Nowy Tytuł" }}
  expect(response).to redirect_to ad
  end
end
  context "invalid attributes" do
  it "does not change ad's attributes" do
  put :update, params: { id: ad, ad: { title: "" }}
  ad.reload
  expect(ad.title).to eq "Tytuł"
end
  it "re-renders the :edit template" do
  put :update, params: { id: ad, ad: { title: "" }}
  expect(response).to render_template :edit
    end
  end
end

  describe "DELETE #destroy" do
    let!(:ad) { create(:ad) }
    it "deletes ad" do
    expect {
    delete :destroy, params: { id: ad }
  }.to change(Ad, :count).by(-1)
  end
    it "redirects to index page" do
    delete :destroy, params: { id: ad }
    expect(response).to redirect_to ads_url
    end
  end
end
