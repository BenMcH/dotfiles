class Controller < ApplicationController
  #load_and_authorize_resource

  def index
  end

  def new
  end

  def edit
  end

  def update
    if @controller.update_attributes(params[:controller])
      redirect_to edit_controller_path(@controller), :notice => "Controller was successfully updated."
    else
      flash[:error] = "Unable to create controller."
      render :new
    end
  end

  def create
    if @controller.save
      redirect_to controller_path, :notice => "Controller was successfully created."
    else
      flash[:error] = "Unable to create controller."
      render :new
    end
  end

  def destroy
    #object = @professional_designation_assignment.person
    @controller.destroy
    flash[:notice] = 'Controller was successfully deleted.'
    redirect_to edit_controller_path(object)
  end
end

