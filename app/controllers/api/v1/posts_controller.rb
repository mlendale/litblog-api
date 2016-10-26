class Api::V1::PostsController < ApplicationController
  before_action :load_post, :only => [:show, :update, :destroy]
  before_action :authenticate_user!, :only => [:create, :update]
  
  def index
    posts=Post.all
    render jsonapi: posts, status: :ok
  end
    
  #Show one post. For testing but will not be used.
  def show      
     render jsonapi: @post
  end
  
 # Create post
  def create
  post = Post.new(post_params)
    respond_to do |format|
      if post.save
        format.jsonapi { render jsonapi: post, status: :created }
      else
        format.jsonapi { render jsonapi: post.errors, status: :unprocessable_entity }
      end
    end
  end

# Update post
  def update
   
    respond_to do |format|
      if @post.update_attributes(post_params)
        #@post.reload #Is it needed?
        format.jsonapi { render jsonapi: @post, status: :ok }
      else
        format.jsonapi { render jsonapi: @post.errors, status: :unprocessable_entity }
      end
    end
  end
 

 
  private
    # Only allow a trusted parameter "white list" through.
  def post_params
    ActiveModelSerializers::Deserialization.jsonapi_parse!(params, only: [:content, :user] )
    #params.permit(:content, :user_id)
  end

  def load_post
    @post = Post.find_by_id(params[:id])
    render jsonapi: 'Post not found', serializer: ActiveModel::Serializer::ErrorSerializer, status: :not_found unless @post.present?
  end

end
