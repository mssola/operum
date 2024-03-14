# frozen_string_literal: true

class ExportsControllerTest < ActionDispatch::IntegrationTest
  # We need the session to be initialized as a signed in user.
  setup { post sessions_url, params: { username: users(:user).username, password: '12341234' } }

  test 'csv: works' do
    get search_exports_url(0, format: 'csv')

    body = @response.body.split("\n")
    targets = body.map { |b| b.split(',').first }

    assert_equal targets, [things(:thing2).target, things(:thing1).target]

    assert_equal 'text/csv', @response.media_type
  end

  test 'uoc: works' do
    get search_exports_url(0, format: 'uoc')

    assert_equal @response.body, file_fixture('all.uoc.tex').read
    assert_equal 'application/x-tex', @response.media_type
  end
end
