class PrototypesController < ApplicationController
  def index
    @prototypes = Prototype.all
  end
  private
  def message_params
    params.require(:Prototype).permit(:content, :image).merge(user_id: current_user.id)
  end
end
