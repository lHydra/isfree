class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @conversations = current_user.mailbox.conversations
  end

  def new
    @crease = Crease.friendly.find(params[:crease_id])
    subject = 'Диалог с автором складчины ' + @crease.title
    if current_user.mailbox.conversations.where(subject: subject).size > 1
      redirect_to conversation_path(current_user.mailbox.conversations[0])
    end
  end

  def create
    crease = Crease.friendly.find(params[:crease_id])
    subject = 'Диалог с автором складчины ' + crease.title
    recipient = User.find(crease.creator_id)
    receipt = current_user.send_message(recipient, params[:body], subject)

    flash[:success] = 'Сообщение было успешно отправлено'
    redirect_to conversation_path(receipt.conversation)
  end

  def show
    @conversation = current_user.mailbox.conversations.find(params[:id])
  end
end
