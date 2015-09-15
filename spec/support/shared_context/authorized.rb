RSpec.shared_context "authorized", authorized: true do
  include AuthorizationHelper::Controller
  before do
    authorize_anything!
  end
end
