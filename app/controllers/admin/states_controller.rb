class Admin::StatesController < Admin::BaseController
  before_filter :find_state, 
    :only => [:show, :edit, :update, :destroy, :make_default]
  before_filter :assigned?, :only => [:edit, :update, :destroy]

  def index
    @states = State.all
  end

  def new
    @state = State.new
  end

  def create
    @state = State.new(params[:state])
    if @state.save
      flash[:notice] = "State has been created."
      redirect_to admin_states_path
    else
      flash[:alert] = "State has not been created."
      render :action => "new"
    end
  end

  def show
  end

  def edit
  end

  def update
    if @state.update_attributes(params[:state])
      flash[:notice] = "State has been updated."
      redirect_to admin_states_path
    else
      flash[:alert] = "State has not been updated."
      render :action => "edit"
    end
  end

  def destroy
    @state.destroy
    flash[:notice] = "State has been deleted."
    redirect_to admin_states_path
  end

  def make_default
    @state.default!

    flash[:notice] = "#{@state.name} is now the default state."
    redirect_to admin_states_path
  end

  private

  def assigned?
    if !@state.tickets.empty?
      flash[:alert] = "State has tickets assigned."
      redirect_to admin_states_path
    end
  end

  def find_state
    @state = State.find(params[:id])
  end
end
