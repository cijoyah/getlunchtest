class UsersController < ApplicationController

  before_action :authenticate_user!

    def index
      @user = User.all
    end

    def show
      @user = User.find(params[:id])

      @active_promotions = @user.promotions.active.order("created_at DESC")
      @expired_promotions = @user.promotions.expired.order("created_at DESC")

      @total_of_all_promotions_sold = 0
      @user.promotions.each do |promo|
        @total_of_all_promotions_sold += promo.buyers
      end

      @total_sum_of_all_sales = 0
      @user.promotions.each do |promo|
        @total_sum_of_all_sales += promo.price * promo.buyers
      end

        @promotion_count = @user.promotions.length
    end

    def edit
      @user = User.find(params[:id])
    end


    private
  
end
