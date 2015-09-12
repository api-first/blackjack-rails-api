RSpec.shared_context "authenticated", authenticated: true do
  before do
    @user = FactoryGirl.create(:user)
    @access_token = Doorkeeper::AccessToken.create!(resource_owner_id: @user.id)
    header "Authorization", "Bearer #{@access_token.token}"
  end
end
