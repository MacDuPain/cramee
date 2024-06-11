class Review < ApplicationRecord
  class Review < ApplicationRecord
    validates :name, presence: true
    validates :content, presence: true
  end
end
