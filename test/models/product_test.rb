require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  fixtures :products
  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image_url].any?
  end

  test "product price must positive" do
    product = Product.new(title: "You book title",
    description: "scott",
    image_url: "zzz.jpg")

    product.price = 0
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

    product.price = 0
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

    product.price = 1
    assert product.valid?
  end

  def new_product(image_url)
    product = Product.new(title: "You book title",
    description: "scott",
    price: 1,
    image_url: "zzz.jpg")
  end

  test "image url" do
    ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://a.b./x/y/a/fred.gif }
    bad = %w{ fred.doc fred.gif/more fred,gif.more }

    ok.each do |image_url|
      assert new_product(image_url).valid?, "#{image_url} shouldn't be invalid"
    end

    bad.each do |image_url|
      assert new_product(image_url).valid?, "#{image_url} shouldn't be valid"
    end
  end

  test "product is not valid without a unique title" do
    product = Product.new(title: products(:ruby).title,
    description: "scott",
    price: 1,
    image_url: "zzz.jpg")

    assert product.invalid?
    assert_equal ["has already been taken"], product.errors[:title]
  end
end
