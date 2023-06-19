class PrototypesController < ApplicationController
  before_action :move_to_index, only: [:edit]
  before_action :authenticate_user!, only: [:new, :create, :edit, :update]

  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = current_user.prototypes.new(prototype_params)
  
    if @prototype.save
      redirect_to root_path, notice: 'Prototype was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @prototype = Prototype.find(params[:id])
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  def update
    @prototype = Prototype.find(params[:id])

    if params[:prototype].values.any?(&:blank?)
      # データが空の場合は編集ページに留まる
      render :edit
    elsif @prototype.update(prototype_params)
      redirect_to @prototype
    else
      # その他のエラーがある場合は編集ページに留まる
      render :edit
    end
  end

  def destroy
    @prototype = Prototype.find(params[:id])
    @prototype.destroy
    redirect_to root_path
  end

  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  

  def move_to_index
    unless user_signed_in? && current_user == Prototype.find(params[:id]).user
      redirect_to new_user_session_path
    end
  
end
end