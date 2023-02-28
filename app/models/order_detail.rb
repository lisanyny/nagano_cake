class OrderDetail < ApplicationRecord
  enum making_status: { not_create: 0, waiting: 1, production: 2, complete: 3 }

  belongs_to :item
  belongs_to :order
end
