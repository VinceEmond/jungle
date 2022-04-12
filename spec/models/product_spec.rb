require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    #each example will needs its own @category created and then @product initialized with that category
    before(:each) do
      @category = Category.create(name: 'Bikes')
    end

    it 'creates a product with all 4 fields' do
      @product = @category.products.create!(name: 'Rocky Mountain', price: 420, quantity: 10, category: @category)
      expect(@product).to be_valid
    end

    it 'should have a valid name' do
      # @product = @category.products.new(name: nil, price: 4200, quantity: 10, category: @category)   
      @product = Product.new(name: nil, price: 4200, quantity: 10, category: @category)   
      @product.save
      expect(@product.errors.full_messages).to include("Name can't be blank")
    end

    it 'should have a valid price' do
      # @product = @category.products.new(name: "Rocky Mountain", price: nil, quantity: 10, category: @category)   
      @product = Product.new(name: "Rocky Mountain", price: nil, quantity: 10, category: @category)   
      @product.save
      expect(@product.errors.full_messages).to include("Price can't be blank")
    end

    it 'should have a valid quantity' do
      # @product = @category.products.new(name: "Rocky Mountain", price: 420, quantity: nil, category: @category)   
      @product = Product.new(name: "Rocky Mountain", price: 420, quantity: nil, category: @category)   
      @product.save
      expect(@product.errors.full_messages).to include("Quantity can't be blank")
    end

    it 'should have a valid category' do
      @product = Product.new(name: 'Rocky Mountain', price: 420, quantity: 10, category: nil)
      @product.save
      expect(@product.errors.full_messages).to include("Category can't be blank")
    end

  end
end
