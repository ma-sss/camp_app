# frozen_string_literal: true


class Api::V1::User::SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
    if current_api_v1_user
      render json: { is_login: true, data: current_api_v1_user }
    else
      render json: { is_login: false, message: 'ユーザーが存在しません' }
    end
  end
end
