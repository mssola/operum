# frozen_string_literal: true

class ExportsControllerTest < ActionDispatch::IntegrationTest
  # We need the session to be initialized as a signed in user.
  setup { post sessions_url, params: { username: users(:user).username, password: '12341234' } }

  test 'csv: works' do
    get search_exports_url(0, format: 'csv')

    body = @response.body.split("\n")

    assert_nil body.last.index('_')

    targets = body.map { |b| b.split(',').first }

    assert_equal targets, [things(:thing2).target, things(:thing1).target]

    assert_equal 'text/csv', @response.media_type
  end

  test 'csv: underscore is removed for the title' do
    things(:thing1).update!(title: 'This is a _title_ with _many_ underscores')

    get search_exports_url(0, format: 'csv')

    body = @response.body.split("\n")

    assert_equal 'This is a title with many underscores', body.last.split(',')[7]
  end

  test 'uoc: works' do
    get search_exports_url(0, format: 'uoc')

    assert_equal @response.body, file_fixture('all.uoc.tex').read
    assert_equal 'application/x-tex', @response.media_type
  end

  test 'uoc: underscore is supported for the title' do
    things(:thing1).update!(title: 'This is a _title_ with _many_ underscores')

    get search_exports_url(0, format: 'uoc')

    assert_equal @response.body, file_fixture('underscores.uoc.tex').read
  end

  test 'plain: works' do
    get search_exports_url(0, format: 'txt')

    assert_equal @response.body, file_fixture('all.txt').read.strip
    assert_equal 'text/plain', @response.media_type
  end

  test 'plain: underscore is removed for the title' do
    things(:thing1).update!(title: 'This is a _title_ with _many_ underscores')

    get search_exports_url(0, format: 'txt')

    body = @response.body.split("\n")

    assert_includes body.last, 'This is a title with many underscores'
  end
end
