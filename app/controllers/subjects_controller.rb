class SubjectsController < ApplicationController
  
  layout "admin"

  before_action :confirm_logged_in

  def index
    @subjects = Subject.sorted
  end

  def show
    @subject = Subject.find(params[:id])
  end

  def new
    @subject = Subject.new({:name => "Default"})
    @subject_count = Subject.count + 1
  end

  def create
    #instantiate
    @subject = Subject.new(subject_params)
    #if save succeeds, redirect to the index action
    if @subject.save
      flash[:notice] = "Subject '#{Subject.name}' created successfully."
      redirect_to(:action => 'index')
    #if save fails, redisplay the form so user can fix problems
    else
      @subject_count = Subject.count + 1
      render('new')
    end
  end

  def edit
    @subject = Subject.find(params[:id])
    @subject_count = Subject.count
  end

  def update
    #find an existing object using form parameters
    @subject = Subject.find(params[:id])
    # Update the object
    if @subject.update_attributes(subject_params)
    #if update succeeds, redirect to the index action
      flash[:notice] = "Subject '#{@subject.name}' updated successfully."
      redirect_to(:action => 'show', :id => @subject.id)
    #if update fails, redisplay the form so user can fix problems
    else
      @subject_count = Subject.count
      render('edit')
    end
  end

  def delete
    @subject = Subject.find(params[:id])
  end

  def destroy
    subject = Subject.find(params[:id]).destroy
    flash[:notice] = "Subject '#{subject.name}' destroyed successfully."
    redirect_to(:action => 'index')
  end


  private
    def subject_params
      # same as using "params[:subject]", except that it:
      # - raises and error if :subject is not present
      # - allows listed attributes to be mass-assigned
      params.require(:video).permit(:name, :video_url, :position, :visible, :created_at)
    end

end
