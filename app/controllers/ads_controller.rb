class AdsController < ApplicationController
before_action :login_required, except: [:index, :show]
before_action :set_ad, only: [:edit, :update, :destroy]
def index
  @ads = Ad.all
end
def show
  @ad = Ad.find(params[:id])
  @rating = @ad.ratings.find_by(user: current_user)
end
def new
@ad = Ad.new
end
def edit
end
def create
@ad = Ad.new(ad_params)
@ad.user = current_user
if @ad.save
  flash[:success] = "Zamieszczono ogłoszenie!"
  redirect_to @ad
else
  flash.now[:danger] = "Nie można zamieścić ogłoszenia!"
  render :new
end
end
def update
if @ad.update(ad_params)
flash[:success] = "Zaktualizowano ogłoszenie!"
redirect_to @ad
else
flash.now[:danger] = "Nie można zaktualizować ogłoszenia!"
render :edit
end
end
def destroy
@ad.destroy
if @ad.destroy
  flash[:success] = "Usunięto zdjęcie!"
redirect_to ads_url
else
  flash[:danger] = "Nie można usunąć zdjęcia!"
  render :edit
end
end
def set_ad
  @ad = current_user.ads.find(params[:id])
end
def rate
  ad = Ad.find(params[:id])
  rating = ad.ratings.find_or_initialize_by(user: current_user)
  rating.value = params[:value]
  rating.save!
  flash[:success] = 'Ocena została zapisana.'
  redirect_to(:back)
end
private

def ad_params
  params.require(:ad).permit(:title, :description, :image)
end
end
