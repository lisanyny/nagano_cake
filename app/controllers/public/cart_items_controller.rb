class Public::CartItemsController < ApplicationController
  def index
    @cart_items = CartItem.all
    @total = 0
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_params)
    redirect_to cart_item_path
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
     @cart_item.save
     redirect_to cart_items_path
  end


  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def delete_all
    CartItem.destroy_all
    current_customer.cart_item.destroy_all
    redirect_to cart_items_path, notice: 'カートが空になりました。'
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount, :customer_id)
  end

end
