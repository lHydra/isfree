class CreasesController < ApplicationController
  respond_to :html

  def index
    @creases = Crease.all
    @proposed_creases = @creases.select  { |crease| crease.proposed? }
    @approved_creases = @creases.select  { |crease| crease.approved? }
    @active_creases = @creases.select    { |crease| crease.active? }
    @completed_creases = @creases.select { |crease| crease.finished? }
    @canceled_creases = @creases.select  { |crease| crease.canceled? }
  end

  def new
    @crease = Crease.new
  end

  def create
    @crease = Crease.create(crease_params)
    @crease.users.push(current_user)

    flash[:success] = 'Вы успешно предложили складчину'
    respond_with @crease
  end

  def show
    @ru_state = { proposed: 'Предложена', approved: 'Одобрена', active: 'Активна', finished: 'Завершена', canceled: 'Отменена' }
    @crease = Crease.find(params[:id])
    @participants = @crease.users
    @user_has_crease = current_user.creases.include?(@crease) if current_user
    @each_amount = @crease.amount.to_f / @crease.users.count
  end

  private

  def crease_params
    params.require(:crease).permit(:title, :description, :link, :amount, :recommended_quantity)
  end
end
