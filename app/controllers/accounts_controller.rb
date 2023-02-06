class AccountsController < ApplicationController
  before_action :authenticate_account!

  def destroy
    if current_account.user?
      render json: { message: 'Not an admin' }, status: :forbidden
      return
    end

    if current_account.id == params[:id].to_i
      render json: { message: 'The purpose of our lives is to be happy.' }, status: :forbidden
      return
    end

    begin
      account = Account.find(params[:id])
			account.destroy
      render json: { message: "Account with id=#{params[:id]} was deleted" }, status: :ok
    rescue ActiveRecord::RecordNotFound => e
      render json: { message: "No such account with id = #{params[:id]}" }, status: :not_found
    end
  end
end
