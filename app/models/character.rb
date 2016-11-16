class Character < ApplicationRecord
  belongs_to :user

  def self.create_character(params)
    Character.new(
      user_id: params[:user_id],
      obj: params['obj'],
      name: params[:name].downcase,
      current: params[:current].upcase
    )
  end

  def self.update_character(var, params)
    var.user_id = params[:user_id]
    var.obj = params['obj']
    var.name = params[:name].downcase
    var.current = params[:current].upcase
  end
end
