Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      resources :applications, param: :token
      resources :applications do
        resources :chats, param: :chat_number
        resources :chats do
          resources :messages, param: :message_number
        end
      end
    end
  end
end
