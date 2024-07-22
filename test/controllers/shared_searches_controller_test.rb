# frozen_string_literal: true

class SharedSearchesControllerTest < ActionDispatch::IntegrationTest
  # We need the session to be initialized as a signed in user.
  setup { post sessions_url, params: { username: users(:user).username, password: '12341234' } }

  test 'does not allow to show searches which have not been shared' do
    get search_shared_url(searches(:search1).id)
    assert_equal @response.code.to_i, 404

    searches(:search1).update!(shared: true)

    get search_shared_url(searches(:search1).id)
    assert_equal @response.code.to_i, 200
  end
end
