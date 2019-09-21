class Umaline < ApplicationRecord

    belongs_to :uma, optional: true,
    dependent: :delete
    
    def self.search(search)
      if search
        Umaline.where(['ml LIKE ?', "#{search}%"])
      else
        Umaline.all
      end
    end
    
end
