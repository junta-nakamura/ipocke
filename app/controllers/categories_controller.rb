class CategoriesController < ApplicationController
  before_action :search_category
  
  def index
    ideas_list = []

    if @categories.present?
      @categories.first.ideas.each do |idea|
        ideas_list.push({id: idea.id, category: @categories.first.name, body: idea.body})
      end
    elsif !@categories.present? && params[:name].present?
    else
      Idea.all.each do |idea|
        ideas_list.push({id: idea.id, category: idea.category.name, body: idea.body})
      end
    end

    render json: { data: ideas_list }
  end

  def create
    if @categories.present?
      if idea = Idea.create(body: params[:body], category_id: @categories.ids.first)
        render json: { status: 201, action: action_name, data: idea }
      else
        render json: { status: 422, action: action_name, data: idea.errors }
      end
    else
      if category_idea_params
        render json: { status: 201, action: action_name, data: @idea }
      else
        render json: { status: 422, action: action_name, data: [@idea.errors, @category.errors] }
      end
    end
  end

  private
  def search_category
    @categories = Category.where(name: params[:name])
  end

  def category_idea_params
    @category = Category.create(name: params[:name])
    @idea = Idea.create(body: params[:body], category_id: @category.id)
  end

end