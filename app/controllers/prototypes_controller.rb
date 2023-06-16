class PrototypesController < ApplicationController
  def index
    @prototypes = Prototype.all
  end
  def new
    @prototype = Prototype.new
  end

  private
  def message_params
    params.require(:Prototype).permit(:content, :image).merge(user_id: current_user.id)
  end
end
