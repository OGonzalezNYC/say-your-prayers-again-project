#Post-tweaking:
class Api::V1::PrayersController < ApplicationController
  skip_before_action :authorized, only: [:index, :show]
# May want to consider running "rails g serializer prayer".  Might I also need one for the plural, i.e., "rails g serializer prayers"?
#In the tutorial, the two consecutive commands were "rails g controller api/v1/users" (plural) and "rails g serializer user" (singular).
  def index
    @prayers = Prayer.all
    render json: @prayers, status: 200 # you've got a serializer. Maybe you should use it.
  end

  def show
    @prayer = Prayer.find(params[:id])
    render json: @prayer, status: 200
  end

  def create
    @prayer = Prayer.create(prayer_params)
    render json: @prayer, status: 200
  end

  def update
    @prayer = Prayer.find(params[:id])
# 403 is an unauthorized error
    return render json: {error: 'Unauthorized'}, status: 403 unless @prayer.user == current_user
    @prayer.update(prayer_params)
    render json: @prayer, status: 200
  end


# -    return json: {error: 'Unauthorized'}, status: 403 unless @prayer.user == current_user
# +    return render json: {error: 'Unauthorized'}, status: 403 unless @prayer.user == current_user


  def destroy
    @prayer = Prayer.find(params[:id])
# 403 is an unauthorized error
    return render json: {error: 'Unauthorized'}, status: 403 unless @prayer.user == current_user
    @prayer.delete
    render json: {prayerId: prayer.id}
  end


  private
  def prayer_params
    params.require(:prayer).permit(:title, :body, :outcome, :amens).merge({user_id: current_user.id})
  end
end


















#Pre-tweaking:
# class Api::V1::PrayersController < ApplicationController
#   skip_before_action :authorized, only: [:index, :show]
# # May want to consider running "rails g serializer prayer".  Might I also need one for the plural, i.e., "rails g serializer prayers"?
# #In the tutorial, the two consecutive commands were "rails g controller api/v1/users" (plural) and "rails g serializer user" (singular).
#   def index
#     @prayers = Prayer.all
#     render json: @prayers, satus: 200 # you've got a serializer. Maybe you should use it.
#   end
#
#   def show
#     @prayer = Prayer.find(params[:id])
#     render json: @prayer, status: 200
#   end
#
#   def create
#     @prayer = Prayer.create(prayer_params)
#     render json: @prayer, status: 200
#   end
#
#   def update
#     @prayer = Prayer.find(params[:id])
#     @prayer.update(prayer_params)
#     render json: @prayer, status: 200
#   end
#
#   def destroy
#     @prayer = Prayer.find(params[:id])
#     @prayer.delete
#     render json: {prayerId: prayer.id}
#   end
#
#   private
#   def prayer_params
#     params.require(:prayer).permit(:title, :body, :outcome, :amens)
#   end
# end
