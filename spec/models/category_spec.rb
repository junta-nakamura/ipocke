require 'rails_helper'

RSpec.describe Category, type: :model do
  describe '新規カテゴリー登録' do

    it 'カテゴリー名が入力されていれば登録できる' do
      category = Category.new(name: 'test')
      expect(category).to be_valid
    end

    it 'カテゴリー名が空では登録できない' do
      category = Category.new(name: '')
      category.valid?
      expect(category.errors.full_messages).to include("Name can't be blank")
    end

    it 'カテゴリー名の重複登録はできない' do
      category = Category.create(name: 'test')
      @category = Category.new(name: category.name)
      @category.valid?
      expect(@category.errors.full_messages).to include("Name has already been taken")
    end

  end
end
