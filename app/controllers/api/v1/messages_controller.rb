class Api::V1::MessagesController < ApplicationController
    before_action :set_chat

    def index
        messages = @chat.messages
        render_json_ok(messages)
    end

    def show
        message = @chat.messages.find_by(message_number: params[:message_number])

        if message.present?
            render_json_ok(message)
        else
            render_json_not_found()
        end
    end

    def create
        recent_message = @chat.messages.last;

        if recent_message.present?
            recent_message_number = recent_message.message_number
        else
            recent_message_number = 0
        end
        
        message = @chat.messages.new(:message_number => recent_message_number + 1)

        if message.save
            render_json_created(message)
        else
            render_json_bad_request(message.errors)
        end
    end

    def destroy
        message = @chat.messages.find_by(message_number: params[:message_number])
        
        if message.present?
            message.destroy
            render_json_no_content(message)
        else
            render_json_not_found()
        end
    end

    def update
        message = @chat.messages.find_by(message_number: params[:message_number])

        if message.present?
            if message.update(message_params)
                render_json_no_content(message)
            else
                render_json_bad_request()
            end
        else
        render_json_not_found()
        end
    end
    

    def set_chat
        @application = Application.find_by(token: params[:application_id])
        if @application.nil?
            render_json_not_found()
            return
        end

        @chat = Chat.find_by(chat_number: params[:chat_id])
    

        if @chat.nil?
            render_json_not_found()
            return
        end

    end

    private

    def message_params
        params.permit(:message_number)
    end

end
