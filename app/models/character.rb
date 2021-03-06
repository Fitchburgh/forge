class Character < ApplicationRecord
  belongs_to :user
  validates_uniqueness_of :current, if: :current # as written only one user can have one current character

  def self.create_character(params, auth_id)
    Character.new(
      user_id: auth_id,
      info: params['info'],
      name: params[:name].downcase,
      current: FALSE
    )
  end

  def self.update_character(var, params, auth_id)
    var.user_id = auth_id
    var.info = params['info']
    var.name = params[:name].downcase
    var.current = FALSE
  end

  def self.update_current_user_character(var, params)
    @characters = Character.where.not(id: params)
    @characters.each do |char|
      char.current = false
      char.save!
    end
    var.current = true
    var.save!
  end
end
