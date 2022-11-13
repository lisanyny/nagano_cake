class Order < ApplicationRecord

enum payment_method: { credit_card: 0, transfer: 1 }
enum status: { waiting: 0, confirmation: 1, production: 2, reserve: 3, sent: 4 }

belongs_to :customer
has_many :order_details

end