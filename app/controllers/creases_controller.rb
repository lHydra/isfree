class CreasesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  respond_to :html

  def index
    # SEO meta tags
    @meta_title = meta_title 'Список складчин'
    @meta_description = 'Список доступных складчин, в которых вы можете записаться на участие. Также можно принять участие в уже завершившихся складчинах.'

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
    @crease = Crease.new(crease_params)
    @crease.creator_id = current_user.id
    @crease.users.push(current_user)
    @crease.save

    flash[:notice] = 'Вы успешно предложили складчину'
    respond_with @crease
  end

  def show
    @crease = Crease.friendly.find(params[:id])
    # SEO meta tags
    @meta_title = meta_title @crease.title
    @meta_description = @crease.description

    @participants = @crease.users
    @user_has_crease = current_user.creases.include?(@crease) if current_user
    @each_amount = @crease.amount.to_f / @crease.users.count
  end


  def destroy
    @crease = Crease.friendly.find(params[:id])
    @crease.delete

    flash[:notice] = 'Складчина успешно удалена'
    redirect_to creases_path
  end

  private

  def crease_params
    params.require(:crease).permit(:title, :description, :link, :amount, :recommended_quantity)
  end
end
