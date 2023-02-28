class Public::ItemsController < ApplicationController
  before_action :move_to_signed_in, except: [:index]

  def index
    @items = Item.page(params[:page])
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end

  private
    def item_params
      params.require(:item).permit(:name, :image_id, :introduction, :price, :amount)
    end

    def move_to_signed_in
      unless customer_signed_in?
        redirect_to "/customers/sign_in"
      end
    end
end
