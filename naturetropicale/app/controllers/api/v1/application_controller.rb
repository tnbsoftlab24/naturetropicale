class  Api::V1::ApplicationController < ActionController::API
  before_action :authorize_request
  
  def not_found
    render json: { message: 'not_found' }
  end

  def authorize_request
    header = request.headers['Authorization']
    header = header.split(' ').last if header
    begin
      @decoded = JsonWebToken.decode(header)
      @current_user = User.find(@decoded[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      render json: { message: e.message }, status: :unauthorized
    rescue JWT::DecodeError => e
      render json: { message: e.message }, status: :unauthorized
    end
  end
end