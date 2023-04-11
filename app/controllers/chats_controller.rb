require 'openai'
require "dotenv"
Dotenv.load

class ChatsController < ApplicationController
  before_action :initialize_client

  def new
    @questions = [
      "あなたの事業はどの業種に属していますか？",
      "あなたが事業を始めたきっかけは何ですか？",
      "事業を始めたきっかけや経緯を教えてください。",
      "事業の歴史について教えてください。",
      "事業の主な製品やサービスについて教えてください。",
      "どのようなターゲット顧客がいますか？",
      "あなたの商品やサービスが他の類似商品やサービスと比較してどのような特徴がありますか？",
      # "事業の現在の課題や挑戦は何ですか？",
      # "あなたの事業で使用している伝統的な技術や知識について教えてください。",
      # "事業の現在の課題や挑戦は何ですか？",
      # "後継者に求める最も重要なスキルや資質は何ですか？",
      # "あなたが後継者に期待する役割や責任は何ですか？",
      # "後継者にどのようなビジョンを持ってほしいですか？",
      # "あなたの事業が地域やお客様にどのような価値を提供していますか？",
      # "あなたの事業において最も誇りに思っている点は何ですか？",
      # "あなたの商品やサービスを通じてお客様にどのような体験や感動を提供したいですか？",
      # "あなたの事業ではどのようなこだわりがありますか？",
      # "これまでの事業運営で直面した課題や困難は何でしたか？それをどのように克服しましたか？",
      # "あなたの商品やサービスが最も力を入れている点や独自性は何ですか？",
      # "お客様から寄せられた印象的な感想やエピソードはありますか？",
      # "あなたの事業に対する情熱やビジョンを教えてください",
      # "事業を通じて達成したい目標は何ですか？",
      # "あなたの仕事において最も誇りに思う瞬間は何ですか？",
      # "あなたの仕事哲学や価値観を教えてください。",
      # "あなたの事業において、次に取り組みたいことや展望を教えてください。"
    ]
    # session[:questions] = @questions
  end

  def create
    prompt = "以下の質問に対する回答に基づいて、プロフィール文を平均100文字で、人間が読んで面白いと思うように文章を作ってください。\n\n"

    # 、事業の歴史、後継者募集のタイトル、内容、商品のキャッチコピー、PR文をそれぞれの情報に基づいて要約された、各
    # @questions = questions_params.to_unsafe_h.to_a

    @questions = params[:questions]

    if @questions.nil?
    end

    @questions.each_with_index do |question, index|
      # user_input_key = "user_input_#{index}".to_sym
      user_input = params[:user_input][index]
      prompt += "質問:#{question}\n- 回答:#{user_input}\n\n"
    end

    generated_text = chat_with_gpt(prompt)

    # セッションに生成された文章を一時的に保存する
    session[:generated_text] = generated_text
    redirect_to chat_path(id: 'show') # 生成された文章のshowページにリダイレクト
  end

  def show
    @generated_text = session[:generated_text] # セッションから生成された文章を取得する
    session.delete(:generated_text) # セッションから生成された文章を削除（オプション）
  end

  private

  def initialize_client
    @client = OpenAI::Client.new(access_token: ENV["CHATGPT_API_KEY"])
  end

  def chat_with_gpt(prompt)
    response = @client.chat(
      parameters: {
        model: 'gpt-3.5-turbo',
        messages: [
          {"role": "system", "content": "You are a helpful assistant."},
          {"role": "user", "content": prompt}
        ],
        temperature: 0.7,
      })
    response.dig('choices', 0, 'message', 'content')
  end

  # def questions_params
  #   params.require(:questions).permit!
  # end  
end
