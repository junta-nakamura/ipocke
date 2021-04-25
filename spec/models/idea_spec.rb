require 'rails_helper'

RSpec.describe Idea, type: :model do
  describe 'アイデア新規登録' do

    it 'アイデア本文が入力されており、カテゴリーと紐付いていれば登録できる' do
      category = Category.create(name: 'test')
      idea = Idea.new(body: 'test', category_id: category.id)
      expect(idea).to be_valid
    end

    it 'アイデア本文が空では登録できない' do
      category = Category.create(name: 'test')
      idea = Idea.new(body: '', category_id: category.id)
      idea.valid?
      expect(idea.errors.full_messages).to include("Body can't be blank")
    end

    it 'カテゴリーと紐付いていなければ登録できない' do
      idea = Idea.new(body: 'test', category_id: '')
      idea.valid?
      expect(idea.errors.full_messages).to include("Category must exist")
    end

  end
end
