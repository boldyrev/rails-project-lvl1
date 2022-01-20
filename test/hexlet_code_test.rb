# frozen_string_literal: true

require 'test_helper'

User = Struct.new(:name, :job, :gender, keyword_init: true)

class HexletCodeTest < Minitest::Test
  def setup
    @user = User.new name: 'rob', job: 'hexlet', gender: 'm'
  end

  def test_that_it_has_a_version_number
    refute_nil ::HexletCode::VERSION
  end

  def test_it_does_create_form
    result = HexletCode.form_for Object.new do |f|
      # trick for linter
    end
    assert { result == fixture('empty_form') }
  end

  def test_it_does_create_form_with_url
    result = HexletCode.form_for Object.new, url: '/users' do |f|
      # trick for linter
    end
    assert { result == fixture('empty_form_with_url') }
  end

  def test_it_does_create_form_with_inputs
    result = HexletCode.form_for @user do |f|
      f.input :name
      f.input :job, as: :text
    end
    assert { result == fixture('form_with_inputs') }
  end

  def test_it_does_raise_error_if_field_not_found
    assert_raises(NoMethodError) do
      HexletCode.form_for @user, url: '/users' do |f|
        f.input :name
        f.input :job, as: :text
        f.input :age
        f.submit
      end
    end
  end

  def test_it_create_input_with_class
    user = User.new name: 'rob'
    result = HexletCode.form_for user, url: '#' do |f|
      f.input :name, class: 'user-input'
      f.input :job
      f.submit
    end
    assert { result == fixture('form_with_class_in_input') }
  end

  def test_it_does_raise_error_if_block_not_given
    assert_raises(HexletCode::NoBlockGivenError) do
      HexletCode.form_for Object.new
    end
  end

  def fixture(name)
    File.read("./test/fixtures/#{name}.html").strip
  end
end
