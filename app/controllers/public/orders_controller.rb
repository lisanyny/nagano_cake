class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
  end

  def index
  end

  def show
  end

  def confirm
  end

  def complete
  end

  def create
    @order = Order.new
    @order.save
    redirect_to
  end

end
