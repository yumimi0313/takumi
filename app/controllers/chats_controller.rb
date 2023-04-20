require 'openai'
require "dotenv"
Dotenv.load

class ChatsController < ApplicationController
  before_action :initialize_client

  def new
    @questions = [
      "あなたの事業はどの業種に属していますか？",
      "あなたが事業を始めたきっかけは何ですか？",
      "事業の歴史について教えてください。",
      "事業の主な製品やサービスについて教えてください。",
      "あなたの商品やサービスが他の類似商品やサービスと比較してどのような特徴がありますか？",
      # "現在の課題や挑戦は何ですか？",
      # "あなたの事業で使用している伝統的な技術や知識について教えてください。",
      # "後継者に求める最も重要なスキルや資質は何ですか？",
      # "後継者にどのようなビジョンを持ってほしいですか？",
      # "あなたの事業が地域やお客様にどのような価値を提供していますか？",
      "あなたの商品やサービスを通じてお客様にどのような体験や感動を提供したいですか？",
      "これまでの事業運営で直面した課題や困難は何でしたか？それをどのように克服しましたか？",
      # "お客様から寄せられた印象的な感想やエピソードはありますか？",
      "あなたの事業に対する情熱やビジョンを教えてください",
      "あなたの仕事において最も誇りに思う瞬間は何ですか？",
      "あなたの仕事哲学や価値観を教えてください。",
    ]
  end

  def create
    prompt = "以下の質問に対する回答に基づいて、プロフィール文（事業の歴史）約200文字で、人間が事業と商品が魅力的と思えるような文章で作ってください。\n\n"
    #後継者募集のタイトル約50文字・詳細約150文字、商品のキャッチコピー約30文字、商品PR文約200文字を改行（'\n\n'）で区切って、
    @questions = params[:questions]

    @questions.each do |question_data|
      question = question_data["question"]
      user_input = question_data["user_input"]
      prompt += "質問:#{question}\n 回答:#{user_input}\n\n "
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
          {"role": "system", "content": "あなたは優秀なコピーライター、マーケター、プレゼンターです"},
          {"role": "user", "content": prompt}
        ],
        temperature: 0.7,
      })
    response.dig('choices', 0, 'message', 'content')
  end
end
