class Character < ApplicationRecord
  belongs_to :user
  validates_uniqueness_of :current, if: :current

  def self.create_character(params)
    Character.new(
      user_id: request.env['HTTP_USER_ID'].to_i,
      obj: params['obj'],
      name: params[:name].downcase,
      current: FALSE
    )
  end

  def self.update_character(var, params)
    var.user_id = request.env['HTTP_USER_ID'].to_i
    var.obj = params['obj']
    var.name = params[:name].downcase
    var.current = FALSE
  end
end
