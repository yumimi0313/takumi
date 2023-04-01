class ChatsController < ApplicationController

  def index
  end

  #入力したテキストに対してchatGPTの返信を返す
  def search
    @query = params[:query]

    response = @client.chat(
      parameters: {
          model: "gpt-3.5-turbo",
          messages: [{ role: "user", content: @query }],
          temperature: 0.7,
      })

    @chats = response.dig("choices", 0, "message", "content")
  end
end
