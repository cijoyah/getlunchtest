class PromotionsController < ApplicationController

    before_action :find_promotion, only: [:show, :edit, :update, :destroy]
    before_action :authenticate_user!, except: [:show, :index]

    def index
      @promotions = Promotion.active.all.order("created_at DESC")
      # @promotions = Promotion.paginate(:page => params[:page], :per_page => 12)
    end

    def expired
      @promotions = Promotion.expired
      # render :index
    end

    def show
    end

    def new
      @promotion = current_user.promotions.build
    end

    def create
      @promotion = current_user.promotions.build(promotion_params)
      
      if @promotion.save
        redirect_to @promotion
      else
        render 'new'
      end
    end

    def edit
    end

    def update
      if @promotion.update(promotion_params)
        redirect_to @promotion
      else
        render 'edit'
      end
    end

    def destroy
      @promotion.destroy
      redirect_to root_path
    end

    def confirmed
      @promotion = Promotion.find(params[:id])
    end

    def pause
      @promotion = Promotion.find(params[:id])
      @promotion.end_time = Time.now
      @promotion.save
      redirect_to user_path(current_user)
    end

    private

    def find_promotion
      @promotion = Promotion.find(params[:id])
    end

    def promotion_params
      params.require(:promotion).permit(:pitch, :description, :price, :available_on_date, :start_time, :end_time, :cuisine, :hotness, :user_id, :image)
    end

end
