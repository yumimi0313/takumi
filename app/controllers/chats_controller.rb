require 'openai'
require "dotenv"
Dotenv.load

class ChatsController < ApplicationController
  before_action :initialize_client

  def index
  end

  def search
    @query = params[:query]
    response = chat_with_gpt(@query)
    @chats = response.dig('choices', 0, 'message', 'content')

    respond_to do |format|
      format.json { render json: { result: @chats } }
    end
  end

  def create_generated_text
    interview = Interview.find(params[:id])
    chat_gpt_response = call_chat_gpt_api(interview)
    # chat_gpt_responseを処理して、生成されたテキストを保存/表示する処理をここに追加
    @generated_text = chat_gpt_response.dig('choices', 0, 'message', 'content')
  
    respond_to do |format|
      format.json { render json: { result: @generated_text } }
    end
  end

  private

  def initialize_client
    @client = OpenAI::Client.new(access_token: ENV["CHATGPT_API_KEY"])
  end

  def chat_with_gpt(messages)
    @client.chat(
      parameters: {
        model: 'gpt-3.5-turbo',
        messages: messages,
        temperature: 0.7,
      })
  end

  def call_chat_gpt_api(interview)
    interview_questions = load_interview_questions
    user_responses = interview.questions.map do |question|
      {
        role: 'user',
        content: "Q: #{interview_questions[index][:question]} A: #{question.answer}"
      }
    end

    system_prompt = {
      role: 'system',
      content: 'You are a helpful assistant.'
    }

    user_prompt = {
      role: 'user',
      content: '匠のプロフィール、事業の歴史、後継者募集のタイトル、内容、商品のキャッチコピー、PR文をそれぞれの情報に基づいて要約された200から500文字の文章で生成してください。'
    }

    messages = [system_prompt] + user_responses + [user_prompt]
    chat_with_gpt(messages)
  end

  private
  def load_interview_questions
    YAML.load_file(Rails.root.join('config', 'interview_questions.yml'))
  end
end
