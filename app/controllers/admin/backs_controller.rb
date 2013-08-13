class Admin::BacksController < Admin::BaseController
  
  def index
    @backs = Back.all
  end

  def show 
    @back = Back.find(params[:id])
  end

  def revenue

    @backs = Back.all
    @start_date = params[:s_date].to_time
    @end_date = params[:e_date].to_time
    @s_int = @start_date.to_i
    @e_int = @end_date.to_i
    @time_backs = []
    @fee = 0.05
    @sum = 0
    @int_array = []
    
    @backs.each do |back|
      integer = back.created_at.to_i
      if (integer > @s_int and integer < @e_int)
        @time_backs[back.id] = back
      end
      @int_array[back.id] = integer 
    end
    @i = 0
    @time_backs.each do |tback|
      @sum += tback.amount if tback
      @i += 1 if tback
    end

    @total_fee = @sum * @fee
    @backs = @time_backs
    calculate_backs
  end

  def monney_to_give
    @fee = 0.05
    @backs = Back.all
    calculate_backs
  end

  def calculate_backs
    @sum = 0
    @new_backs = {}
    for back in @backs
      if back != nil 
        if @new_backs[back.project_id] != nil
          @new_backs[back.project_id] += back.amount
        else
          @new_backs[back.project_id] = back.amount
        end
      end
    end
    @sum = 0
    @new_backs.each{|key,sum| @sum += sum }
    @total_fee = @sum * @fee
    @money = @sum - @total_fee
    #end

  end
 
  
  private
  def back_params
    params.require(:back).permit(:amount, :comment, :project_id, :user_id, :created_at)
  end
end
