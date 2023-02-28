class Public::OrdersController < ApplicationController
  def new
    return redirect_to cart_items_path if current_customer.cart_items.blank?
    @order = Order.new
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = current_customer.orders.find(params[:id])
  end

  def confirm
    @order = Order.new(order_params)

    if params[:order][:select_address] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name

    elsif params[:order][:select_address] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name

    else params[:order][:select_address] == "2"
         @order.postal_code = params[:order][:postal_code]
         @order.address = params[:order][:address]
         @order.name = params[:order][:name]
    end

    @cart_items = current_customer.cart_items
    @total = 0
    @cart_items.each do |cart_item|
      @total = @total + cart_item.subtotal
    end
    @order.price = @total
  end

  def complete
  end

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.postage = 800
    @order.save!

    current_customer.cart_items.each do |cart_item|
      @order_detail = OrderDetail.new
      @order_detail.item_id = cart_item.item_id
      @order_detail.amount = cart_item.amount
      @order_detail.price = (cart_item.item.price * 1.1).floor
      @order_detail.order_id = @order.id
      @order_detail.save
    end
    current_customer.cart_items.destroy_all
    redirect_to orders_complete_path
  end

  private
    def order_params
      params.require(:order).permit(:payment_method, :postal_code, :address, :name, :price, :customer_id)
    end
end
