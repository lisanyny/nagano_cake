class Public::CartItemsController < ApplicationController
  def index
    @cart_items = CartItem.all
  end

  def update
  end

  def destroy
  end

  def delete_all
  end

  def create
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount, :price)
  end

end
