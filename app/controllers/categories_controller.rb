class CategoriesController < ApplicationController
  before_action :find_category
  
  def index
    ideas_list = []

    if @category.present?
      ideas = Idea.where(category_id: @category.id)
      ideas.each do |idea|
        ideas_list.push({id: idea.id, category: @category.name, body: idea.body})
      end
      render json: { data: ideas_list }
    elsif params[:name].present?
      render json: { status: 404 }
    else
      Idea.all.each do |idea|
        ideas_list.push({id: idea.id, category: idea.category.name, body: idea.body})
      end
      render json: { data: ideas_list }
    end
  end

  def create
    if @category.present?
      idea = Idea.new(body: params[:body], category_id: @category.id)
      if idea.save
        render json: { status: 201 }
      else
        render json: { status: 422 }
      end
    elsif params[:name].present? && params[:body].present?
      @create_category = Category.create(category_params)
      idea = Idea.create(idea_params)
      if @create_category && idea
        render json: { status: 201 }
      else
        render json: { status: 422 }
      end
    else
      render json: { status: 422 }
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