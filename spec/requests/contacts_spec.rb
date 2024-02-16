require 'rails_helper'

RSpec.describe "Contacts", type: :request do
  before do
    sign_in_admin
  end

  describe "GET /index" do
    it "returns a successful response" do
      get admin_contacts_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /create" do
    let(:valid_attributes) { { contact: FactoryBot.attributes_for(:contact) } }
    let(:invalid_attributes) { { contact: FactoryBot.attributes_for(:contact, email: "") } }
    let(:new_contact) { Contact.last }

    context "with valid parameters" do
      it "creates a new contact and redirects to the contact" do
        expect {
          post admin_contacts_path, params: valid_attributes
        }.to change(Contact, :count).by(1)
        expect(response).to redirect_to(admin_contact_path(new_contact))
      end
    end

    context "with invalid parameters" do
      it "does not create a new contact" do
        expect {
          post admin_contacts_path, params: invalid_attributes
        }.not_to change(Contact, :count)
        # Assuming Active Admin redirects or renders :new on failure
        expect(response).to be_successful
      end
    end
  end
end
