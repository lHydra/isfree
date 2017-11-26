class PurchasesController < ApplicationController
  def create
    @crease = Crease.find(params[:crease_id])
    current_user.creases.push @crease

    if @crease.users.count == @crease.recommended_quantity
      @crease.activate!
    end

    redirect_to @crease
  end

  def destroy
    @crease = Crease.find(params[:crease_id])
    current_user.creases.delete(@crease)

    if @crease.users.count < @crease.recommended_quantity
      @crease.inactive!
    end

    redirect_to @crease
  end
end
