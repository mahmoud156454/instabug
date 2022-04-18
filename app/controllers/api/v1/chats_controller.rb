class Api::V1::ChatsController < ApplicationController
    before_action :set_application

    def index
        if !@application
            render_json_not_found()
        else
            chats = @application.chats
            render_json_ok(chats)
        end
    end

    def show
        chat = @application.chats.find_by(chat_number: params[:chat_number])
        
        if chat.present?
            render_json_ok(chat)
        else
            render_json_not_found()
        end
    end

    def create
        recent_chat = @application.chats.last;

        if recent_chat.present?
            recent_chat_number = recent_chat.chat_number
        else
            recent_chat_number = 0
        end

        chat = @application.chats.new(:chat_number => recent_chat_number + 1)

        if chat.save
            render_json_created(chat)
        else
            render_json_bad_request(chat.errors)
        end
    end

    def destroy
        chat = @application.chats.find_by(chat_number: params[:chat_number])
        
        if chat.present?
            chat.destroy
            render_json_no_content(chat)
        else
        render_json_not_found()
        end
    end

    def update
        chat = @application.find_by(chat_number: params[:chat_number])

        if chat.present?
            if chat.update(chat_params)
                render_json_no_content(chat)
            else
                render_json_bad_request()
            end
        else
            render_json_not_found()
        end
    end
    

    def set_application
        @application = Application.find_by(token: params[:application_id])
        if @application.nil?
            render_json_not_found()
            return
        end
    end

    private

    def chat_params
        params.permit(:chat_number)
    end

end
