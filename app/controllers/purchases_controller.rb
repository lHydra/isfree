class PurchasesController < ApplicationController
  before_action :set_crease

  def create
    current_user.creases.push @crease

    if @crease.users.count == @crease.recommended_quantity
      @crease.activate!
    end

    UserNotifier.send_participation_email(current_user, @crease).deliver
    flash[:success] = 'Вы успешно записались на участие в складчине'
    redirect_to @crease
  end

  def destroy
    current_user.creases.delete(@crease)

    if @crease.users.count < @crease.recommended_quantity && @crease.active?
      @crease.inactive!
    end

    flash[:warning] = 'Вы отказались от участия в складчине'
    redirect_to @crease
  end

  private

  def set_crease
    @crease = Crease.friendly.find(params[:crease_id])
  end
end
