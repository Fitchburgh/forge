#
class Article < ApplicationRecord
  def create_article(var, class_name)
    var.downcase = class_name.new(asset_params)
    if var.save
      render json: var
    else
      render json: { errors: var.errors.full_messages }
    end
  end

  private

  def asset_params
    # only permitting user and scene ID's here for testing.  these will come from front end
    params.permit(:name, :info, :user_id, :scene_id, :tags, :public)
  end
end
