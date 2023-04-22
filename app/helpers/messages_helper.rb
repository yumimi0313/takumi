module MessagesHelper
  def message_time(time)
    l(time, format: :long)
  end
end
