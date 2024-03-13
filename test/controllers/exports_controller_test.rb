# frozen_string_literal: true

class ExportsControllerTest < ActionDispatch::IntegrationTest
  # We need the session to be initialized as a signed in user.
  setup { post sessions_url, params: { username: users(:user).username, password: '12341234' } }

  test 'csv: works' do
    get search_exports_url(0, format: 'csv')

    body = @response.body.split("\n")
    assert body.size == 2
    assert body.first.split(',')[0] == things(:thing2).target
    assert body.last.split(',')[0] == things(:thing1).target

    assert @response.media_type == 'text/csv'
  end

  test 'uoc: works' do
    get search_exports_url(0, format: 'uoc')

    assert @response.body == file_fixture('all.uoc.tex').read
    assert @response.media_type == 'application/x-tex'
  end
end
