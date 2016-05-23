class CategoriesController < ApplicationController
  before_action :require_admin, only: [:new,:create]
  
  def new
    @category = Category.new
  end
  
  def show
  end
  
  def index
    @categories = Category.paginate(page: params[:page], per_page:5)
  end
  
  def create
		#debugger 
		@category = Category.new(category_params)
		if @category.save
			flash[:success] = "Category '#{@category.name}' was successfully created"
			redirect_to categories_path
		else 
			render 'new'
		end
  end
	
	private
	def category_params
		params.require(:category).permit(:name)
	end
	
	def require_admin
		if !logged_in? || (logged_in? && !current_user.admin?)
			flash[:danger] = "Only admin users can perform that action."
			redirect_to categories_path
		end
	end
	

end