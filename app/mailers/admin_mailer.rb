class AdminMailer < ApplicationMailer
    default from: 'notifications@example.com'

    def success_for_admin_email
        @user = params[:user]
        @reservation = params[:reservation]
        @admin = params[:admin]
        @url  = 'http://example.com/login'
        mail(to: @admin.email, subject: '予約されました')
    end

    def cancel_for_admin_email
        @user = params[:user]
        @reservation = params[:reservation]
        @admin = params[:admin]
        @url  = 'http://example.com/login'
        binding.pry
        mail(to: @admin.email, subject: '予約がキャンセルされました')
    end
end