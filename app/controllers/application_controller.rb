class ApplicationController < ActionController::Base
        include DeviseTokenAuth::Concerns::SetUserByToken
        protect_from_forgery with: :null_session

        def current_user
                ActiveDecorator::Decorator.instance.decorate(super) if super.present?
                super
              end
end
