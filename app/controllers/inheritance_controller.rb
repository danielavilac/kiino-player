class InheritanceController < ApplicationController
  respond_to :html
  helper_method :object_class

  def index
    @objects = object_class.all
  end

  def show
    @object = find_object
  end

  def edit
    @object = find_object
  end

  def new
    @object = object_class.new
  end

  def create(redirect_path = nil)
    redirect_path ||= polymorphic_path(object_class)
    @object = object_class.new(permitted_params)
    if @object.save
      redirect_to redirect_path
    else
      respond_with @object
    end
  end

  def update(redirect_path = nil)
    redirect_path ||= polymorphic_path(object_class)
    @object = find_object
    if @object.update(permitted_params)
      redirect_to redirect_path
    else
      respond_with @object
    end
  end

  def destroy(redirect_path = nil)
    redirect_path ||= polymorphic_path(object_class)
    find_object.destroy
    redirect_to redirect_path
  end

  def object_class
    controller_name.classify.constantize
  end

  private

  def find_object
    controller_name.classify.constantize.find(params[:id])
  end
end
