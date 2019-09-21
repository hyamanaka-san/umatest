class UmasController < ApplicationController
  def index
    
    unless params[:search] =="" && params[:sear]  ==""  && params[:money]  =="" # 全部カラだと動かさない
      
      @umas = Uma.search(params[:search])
       
      @umas2 = Uma.sear(params[:sear]) 
      
      @money = Uma.money(params[:money]) 
      
    end
    
    
#    if @umas == nil
     
 #      @umas2 = Uma.sear(params[:sear])
    
 #   elsif  @umas == ""
    
  #     @umas2 = Uma.sear(params[:sear]) 
  #  else

      # @umas2 = @umas.sear(params[:sear])
       
  #  end
    
  end
  

  def show
    #@umas = Uma.search(params[:search])
    
  end

  def new
       @uma = Uma.new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
  
end
