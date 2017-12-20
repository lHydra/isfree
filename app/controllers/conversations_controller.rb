class ConversationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_mailbox, except: [:create]
  before_action :set_crease, only: %i[new create]

  def index
    @conversations = @mailbox.conversations
  end

  def new
    # If dialog has already been started redirect to dialog
    unless @mailbox.conversations.where(subject: @subject).empty?
      redirect_to conversation_path(current_user.mailbox.conversations[0])
    end
  end

  def create
    recipient = User.find(@crease.creator_id)
    receipt = current_user.send_message(recipient, params[:body], @subject)

    flash[:notice] = 'Сообщение было успешно отправлено'
    redirect_to conversation_path(receipt.conversation)
  end

  def show
    @conversation = @mailbox.conversations.find(params[:id])
  end

  private

  def set_crease
    @crease = Crease.friendly.find(params[:crease_id])
    @subject = 'Диалог с автором складчины ' + @crease.title
  end

  def set_mailbox
    @mailbox = current_user.mailbox
  end
end
