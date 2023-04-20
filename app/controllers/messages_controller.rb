class MessagesController < ApplicationController
  #cancancan読み込みのメソッド
  before_action :load_conversation_and_authorize

  def index
    @messages = @conversation.messages
  
    if @messages.length > 10
      @over_ten = true
      @messages = Message.where(id: @messages[-10..-1].pluck(:id))
    end
  
    if params[:m]
      @over_ten = false
      @messages = @conversation.messages
    end
  
    if @messages.last
      @messages.where.not(user_id: current_user.id).update_all(read: true)
    end
  
    @messages = @messages.order(:created_at)
    @message = @conversation.messages.build
  end

  def create
    @message = @conversation.messages.build(message_params)
    @message.user = current_user

    if @message.save
      redirect_to conversation_messages_path(@conversation)
    else
      # indexアクションで必要なインスタンス変数を設定する
      @messages = @conversation.messages.order(:created_at)

      if @messages.length > 10
        @over_ten = true
        @messages = Message.where(id: @messages[-10..-1].pluck(:id))
      end

      if params[:m]
        @over_ten = false
        @messages = @conversation.messages
      end

      if @messages.last
        @messages.where.not(user_id: current_user.id).update_all(read: true)
      end

      render 'index'
    end
  end

  private

  def message_params
    params.require(:message).permit(:body, :user_id)
  end

  def load_conversation_and_authorize
    @conversation = Conversation.find(params[:conversation_id])
    authorize! :read, @conversation
  end
end
