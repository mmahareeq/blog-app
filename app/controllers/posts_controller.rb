class PostsController < ApplicationController
     
    skip_before_action :verify_authenticity_token
    before_action :authenticate_user!, except: [ :index, :show]
    before_action :post_find_id, expecpt: [:index, :new ,:create]

    # # disply a list of all posts
    def index 
        @post = Post.published
        render locals: {posts: @post}
        # render  status: 200
         
    end 
    
    def new 
       @post = Post.new
    end

    # create a new post name , content
    def create 
        puts params
        @post = Post.create(post_params)
        # @post.save

        if @post.save
            redirect_to posts_path, notice: 'created post successfully'
        #    render json: { message: 'created post successfully'}, status: 200
        else
             flash.now[:alert] = 'Please fill in all required fields.'
             render 'new', status: 404
        #    render json: {error: 'error happens'}, status: 404
        end
    end
    
    def edit 
        @post = Post.find_by(id: params[:id])
    end
    # edit specific post

    def update
        @post = Post.find_by(id: params[:id])
        # puts params
        if @post.update(post_params)
            # render json: {message: 'updated post successfully'}, status: 200
            redirect_to post_path, notice: 'updated post successfully'
        else
            flash.now[:alert] = 'Please fill in all required fields.'
            render :edit, status: 404

        end
    end
    
    # display specific post
    def show
        @post = Post.find_by(id: params[:id])

        if @post
            render status: 200
        else
            render json: {error: "Post Not Found"}, status: 404
        end
    end
    
    def destroy
        puts "hello"
        @post = Post.find_by(id: params[:id])
        puts @post
        
         if @post.destroy
            redirect_to posts_path, notice: 'deleted post successfully'
         end
        end
    private

    def post_params
        params.require(:post).permit(:name, :content, :image, :published_at)
    end

    def post_find_id
        @post = user_signed_in? ?  Post.find_by(id: params[:id]): Post.published.find_by(id: params[:id])
    rescue ActionRecoed::RecordNotFound
        redirect_to root_path
    end

end