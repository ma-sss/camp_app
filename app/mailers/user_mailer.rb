class UserMailer < ApplicationMailer
    default from: 'notifications@example.com'

    def welcome_email
        @user = params[:user]
        @url  = 'http://example.com/login'
        mail(to: @user.email, subject: 'キャンプサイトへようこそ')
    end

    def success_for_user_email
        @user = params[:user]
        @reservation = params[:reservation]
        @admin = params[:admin]
        @url  = 'http://example.com/login'
        mail(to: @user.email, subject: '予約が完了しました')
    end

    def cancel_for_user_email
        @user = params[:user]
        @reservation = params[:reservation]
        @admin = params[:admin]
        @url  = 'http://example.com/login'
        mail(to: @user.email, subject: '予約のキャンセルが完了しました')
    end
end
