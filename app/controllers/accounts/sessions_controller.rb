# frozen_string_literal: true

class Accounts::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  respond_to :json

  private

  def respond_with(_resource, _options = {})
    render json: {
      message: 'Signed in successfully', data: current_account
    }, status: :ok
  end

  def respond_to_on_destroy
    jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1],
                             Rails.application.credentials.fetch(:secret_key_base)).first
    current_account = Account.find(jwt_payload['sub'])
    if current_account
      render json: { message: 'Signed out successfully' }, status: :ok
    else
      render json: { message: 'No active session' }, status: :unauthorized
    end
  rescue NoMethodError => _e
    render json: { message: 'No active session' }, status: :unauthorized
  rescue JWT::VerificationError => e
    render json: { message: 'Invalid token' }, status: :unauthorized
  end
end
