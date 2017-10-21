class AdsController < ApplicationController
before_action :login_required, except: [:index, :show]
before_action :set_ad, only: [:edit, :update, :destroy]
def index
  @ads = Ad.all
end
def show
  @ad = Ad.find(params[:id])
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
private

def ad_params
  params.require(:ad).permit(:title, :description, :image)
end
end
