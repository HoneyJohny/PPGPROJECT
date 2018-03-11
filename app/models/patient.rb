class Patient < ApplicationRecord
has_many :comments, dependent: :destroy
validates :name, presence: true

validates :age, presence: true

validates :height, presence: true

end
