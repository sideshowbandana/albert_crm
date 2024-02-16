module RequestSpecHelper
  def sign_in_admin(admin = FactoryBot.create(:admin_user))
    sign_in admin  # Devise helper
  end
end
