require 'spec_helper'

describe AddressesController do
  let!(:address) { create(:address) }
  let(:valid_params) { attributes_for(:address, cidr: "120.4.4.1/12") }
  let(:invalid_params) {{ cidr: "not/valid" }}

  describe "GET show" do
    it "redirects to edit" do
      get :show, id: address.id
      expect(response).to redirect_to(edit_address_path(address.id))
    end
  end

  describe "GET index" do
    it "assigns the addresses" do
      get :index
      expect(response).to be_ok
      expect(assigns(:addresses)).to eq([address])
    end
  end

  describe "GET new" do
    it "assigns" do
      get :new
      expect(response).to be_ok
      expect(assigns(:address)).to be_new_record
    end
  end

  describe "GET edit" do
    it "assigns the address" do
      get :edit, id: address.id
      expect(response).to be_ok
      expect(assigns(:address)).to eq address
    end
  end

  describe "GET lookup" do
    it "displays the index form" do
      get :lookup
      expect(response).to be_ok
    end
  end

  describe "GET whitelisted" do
    it "returns a json true response when whitelisted" do
      get :whitelisted, ip_address: "127.0.0.1"
      body = JSON.parse(response.body)
      expect(body["whitelisted"]).to eq(true)
    end

    it "returns a json false response when not whitelisted" do
      get :whitelisted, ip_address: "1.1.1.0"
      body = JSON.parse(response.body)
      expect(body["whitelisted"]).to eq(false)
    end
  end

  describe "POST create" do
    it "creates a new address" do
      expect{ post :create, address: valid_params }
        .to change{ Address.count }.by(1)
      expect(Address.last.cidr).to eq valid_params[:cidr]
    end

    it "redirects to index on success" do
      post :create, address: valid_params
      expect(response).to redirect_to addresses_path
    end

    it "rerenders on validation errors" do
      post :create, address: invalid_params
      expect(response).to be_ok
      expect(response).to render_template("new")
      expect(assigns(:address)).to be_new_record
    end
  end

  describe "PATCH update" do
    it "creates a new mentor application" do
      patch :update, id: address.id, address: valid_params
      expect(address.reload.cidr).to eq valid_params[:cidr]
    end

    it "redirects to index on success" do
      patch :update, id: address.id, address: valid_params
      expect(response).to redirect_to addresses_path
    end

    it "rerenders on validation errors" do
      patch :update, id: address.id, address: invalid_params
      expect(response).to be_ok
      expect(response).to render_template("edit")
      expect(assigns(:address)).to eq address
    end
  end

  describe "DELETE destroy" do
    it "deletes the address" do
      expect {
        delete :destroy, id: address.id
      }.to change{Address.count}.by(-1)
    end

    it "redirects to index on success" do
      delete :destroy, id: address.id
      expect(response).to redirect_to addresses_path
    end
  end
end
