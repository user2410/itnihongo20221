class AccountPostsController < ApplicationController
  #GET /account_posts
  def index
    @likes = AccountPost.all

    render json: @likes
  end

  #POST /account_posts
  def create
    account = Account.find(params[:user_id])
    post = Post.find(params[:post_id])
    if AccountPost.find_by(account: account, post: post).nil?
      account.posts << post
      account.save
      render json: {message: ['success']}
    end
    render json: {message: ['record existed']}
  end

 #PUT /account_post/{:post_id}/{:user_id}
 def unlike
  account = Account.find(params[:user_id])
  post = Post.find(params[:post_id])
  account_post = AccountPost.find_by(account: account, post: post)
  if account_post.nil?
    render json: { errors: ['Could not find account post'] }, status: :not_found
  end
  if account_post.reaction == 1
    account_post.update(reaction: 0)
  else
    account_post.update(reaction: 1)
  end
  render json: {message: ['success']}, status: :ok
 end


 #DELETE /account_post/{:post_id}/{:user_id}
 def destroy
  account = Account.find(params[:user_id])
  post = Post.find(params[:post_id])
  account_post = AccountPost.find_by(account: account, post: post)
  if account_post.nil?
    render json: { errors: ['Could not find account post'] }, status: :not_found
  end
  account_post.destroy
  render json: { message: 'success' }, status: :ok
end
end
