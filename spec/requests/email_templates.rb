require 'rails_helper'

RSpec.describe "EmailTemplates", type: :request do
  let(:admin_user) { FactoryBot.create(:admin_user) }
  let(:valid_attributes) { { email_template: FactoryBot.attributes_for(:email_template) } }
  let(:invalid_attributes) { { email_template: FactoryBot.attributes_for(:email_template, name: "") } }

  before do
    sign_in admin_user
  end

  describe "POST /admin/email_templates" do
    context "with valid parameters" do
      it "creates a new EmailTemplate and redirects to the EmailTemplate's show page" do
        expect {
          post admin_email_templates_path, params: valid_attributes
        }.to change(EmailTemplate, :count).by(1)

        new_email_template = EmailTemplate.last
        expect(response).to redirect_to(admin_email_template_path(new_email_template))
      end
    end

    context "with invalid parameters" do
      it "does not create a new EmailTemplate and re-renders the 'new' template" do
        expect {
          post admin_email_templates_path, params: invalid_attributes
        }.not_to change(EmailTemplate, :count)

        expect(response).to be_successful  # This assumes that the response is successful even if creation failed, as it typically renders :new
      end
    end
  end
end
