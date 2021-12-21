# frozen_string_literal: true

require "test_helper"

User = Struct.new(:name, :job, :gender, keyword_init: true)

class HexletCodeTest < Minitest::Test
  def setup
    @tag = HexletCode::Tag
    @user = User.new name: "rob", job: "hexlet", gender: "m"
  end

  def test_that_it_has_a_version_number
    refute_nil ::HexletCode::VERSION
  end

  def test_it_does_create_single_tags
    assert { @tag.build("br") == "<br>" }
    assert { @tag.build("img", src: "/path/to/image") == fixture("img") }
  end

  def test_it_does_create_pair_tags
    label = "<label>Email</label>"
    assert { @tag.build("label") { "Email" } == label }
    p = "<p class=\"content\"></p>"
    assert { @tag.build("p", class: "content") == p }
    p_with_value = "<p class=\"content\">Text</p>"
    assert { @tag.build("p", class: "content") { "Text" } == p_with_value }
  end

  def test_it_does_create_form
    result = HexletCode.form_for Object.new
    assert { result == fixture("empty_form") }
  end

  def test_it_does_create_form_with_url
    result = HexletCode.form_for Object.new, url: "/users"
    assert { result == fixture("empty_form_with_url") }
  end

  def test_it_does_create_form_with_inputs
    result = HexletCode.form_for @user do |f|
      f.input :name
      f.input :job, as: :text
    end
    assert { result == fixture("form_with_inputs") }
  end

  def test_it_does_raise_error_if_field_not_found
    assert_raises(NoMethodError) do
      HexletCode.form_for @user, url: "/users" do |f|
        f.input :name
        f.input :job, as: :text
        f.input :age
        f.submit
      end
    end
  end

  def fixture(name)
    File.read("./test/fixtures/#{name}.html").strip
  end
end
