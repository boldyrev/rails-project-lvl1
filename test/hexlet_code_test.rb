# frozen_string_literal: true

require "test_helper"

class HexletCodeTest < Minitest::Test
  def setup
    @tag = HexletCode::Tag
  end

  def test_that_it_has_a_version_number
    refute_nil ::HexletCode::VERSION
  end

  def test_it_does_create_single_tags
    assert { @tag.build("br") == "<br>" }
    expected = '<img src="/path/to/image">'
    assert { @tag.build("img", src: "/path/to/image") == expected }
  end

  def test_it_does_create_form
    result = @tag.form_for Object.new do |f|
    end
    expected = '<form action="#" method="post"></form>'
    assert { result == expected }
  end

  def test_it_does_create_form_with_url
    result = @tag.form_for Object.new, url: "/users" do |f|
    end
    expected = '<form action="/users" method="post"></form>'
    assert { result == expected }
  end
end
