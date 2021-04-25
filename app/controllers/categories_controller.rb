class CategoriesController < ApplicationController
  before_action :find_category
  
  def index
    ideas_list = []

    if @category.present?
      ideas = Idea.where(category_id: @category.id)
      ideas.each do |idea|
        ideas_list.push({id: idea.id, category: @category.name, body: idea.body})
      end
    elsif !@category.present? && params[:name].present?
    else
      Idea.all.each do |idea|
        ideas_list.push({id: idea.id, category: idea.category.name, body: idea.body})
      end
    end

    render json: { data: ideas_list }
  end

  def create
    if @category.present?
      idea = Idea.new(body: params[:body], category_id: @category.id)
      if idea.save
        render json: { status: 201, action: action_name, data: idea }
      else
        render json: { status: 422, action: action_name, data: idea.errors }
      end
    else
      @create_category = Category.new(category_params)
      idea = Idea.new(idea_params)
      if idea.save && @create_category.save
        render json: { status: 201, action: action_name, data: idea }
      else
        render json: { status: 422, action: action_name, data: [@create_category.errors, idea.errors] }
      end
    end
  end

  private
  def find_category
    @category = Category.find_by(name: params[:name])
  end

  def category_params
    params.permit(:name)
  end

  def idea_params
    params.permit(:body).merge(category_id: @create_category.id)
  end

end