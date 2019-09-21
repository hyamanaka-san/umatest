class Uma < ApplicationRecord
    include ActiveModel::Validations
    
    has_one :umaline
    

    def self.search(search) 
     
        unless search == nil
          #   if search == nil redirect_to umas
         # @uma = 
            Uma.where(['horse_name LIKE ?', "#{search}%"])

        end
    end
    
    def self.sear(sear)
            unless sear == nil 
            #  if sear
                Uma.where(['gwin LIKE ?', "#{sear}%"])
                  #s else
                   #  Uma.all
            end
    end
        
    def self.money(money)
            unless money == nil 
                #  if sear
                Uma.where(['money LIKE ?', "#{money}%"])
                  #s else
               #  Uma.all
            end
    end
    
end
