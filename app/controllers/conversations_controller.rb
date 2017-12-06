class ConversationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_mailbox, except: [:create]

  def index
    @conversations = @mailbox.conversations
  end

  def new
    @crease = Crease.friendly.find(params[:crease_id])

    # If dialog has already been started redirect to dialog
    subject = 'Диалог с автором складчины ' + @crease.title
    if @mailbox.conversations.where(subject: subject).size > 0
      redirect_to conversation_path(current_user.mailbox.conversations[0])
    end
  end

  def create
    crease = Crease.friendly.find(params[:crease_id])
    subject = 'Диалог с автором складчины ' + crease.title
    recipient = User.find(crease.creator_id)
    receipt = current_user.send_message(recipient, params[:body], subject)

    flash[:notice] = 'Сообщение было успешно отправлено'
    redirect_to conversation_path(receipt.conversation)
  end

  def show
    @conversation = @mailbox.conversations.find(params[:id])
  end

  private

  def set_mailbox
    @mailbox = current_user.mailbox
  end
end
