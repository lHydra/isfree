class PurchasesController < ApplicationController
  before_action :set_crease

  def create
    current_user.creases.push @crease

    @crease.activate! if @crease.users.count == @crease.recommended_quantity

    UserNotifier.send_participation_email(current_user, @crease).deliver
    flash[:notice] = 'Вы успешно записались на участие в складчине'
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
