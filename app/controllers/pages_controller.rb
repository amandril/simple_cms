class PagesController < ApplicationController

  layout "admin"

  before_action :confirm_logged_in
  before_action :find_subject

  def index
    @page = Page.where(:subject_id => @subject).sorted
    #@pages = @subject.pages.sorted
  end

  def show
    @page = Page.find(params[:page_id])
  end

  def new
    @page = Page.new({:subject_id => @subject, :name => "Default"})
    @subjects = Subject.order('position ASC')
    @page_count = Page.count + 1
  end

  def create
    # instantiate
    @page = Page.new(page_params)
    # Save the page
    if @page.save
      #if page succeeds, redirect to the index action
      redirect_to(:action => 'index', :subject_id => @subject)
    #if save fails, redisplay the form so user can fix problems
    else
      @subjects = Subject.order('position ASC')
      @page_count = Page.count + 1
      render('new')
    end
  end

  def edit
    @page = Page.find(params[:page_id])
    @subjects = Subject.order('position ASC')
    @page_count = Page.count
  end

  def update
    @page = Page.find(params[:page_id])
    # Update the object
    if @page.update_attributes(page_params)
    #if update succeeds, redirect to the index action
    flash[:notice] = "Page '#{@page.name}' updated successfully."
      redirect_to(:action => 'show', :page_id => @page.id, :subject_id => @subject.id)
    #if update fails, redisplay the form so user can fix problems
    else
      @subjects = Subject.order('position ASC')
      @page_count = Page.count
      render('edit')
    end
  end

  def delete
    @page = Page.find(params[:id])
  end

  def destroy
    page = Page.find(params[:id]).destroy
    flash[:notice] = "Page '#{page.name}' destroyed successfully."
    redirect_to(:action => 'index', :subject_id => @subject.id)
  end

  private
    def page_params
      # same as using "params[:Page]", except that it:
      # - raises and error if :Page is not present
      # - allows listed attributes to be mass-assigned
      params.require(:page).permit(:subject_id, :id, :name, :permalink, :position, :visible)
    end

    def find_subject
      if params[:subject_id]
        @subject = Subject.find(params[:subject_id])
      end
    end

end