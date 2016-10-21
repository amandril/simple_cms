class SectionController < ApplicationController

  layout "admin"

  before_action :confirm_logged_in
  before_action :find_pages

  def index
    @section = Section.where(:page_id => @page).sorted
  end

  def show
    @section = Section.find(params[:id])
  end

  def new
    @section = Section.new({:page_id => @page.id, :name => "Default"})
  end

  def create
    @section = Section.new(section_params)
    if @section.save
      #if section succeeds, redirect to the index action
      flash[:notice] = "Section '#{@section.name}' created successfully."
      redirect_to(:action => 'index', :id => @section, :page_id => @page, :subject_id => @subject)
    #if save fails, redisplay the form so user can fix problems
    else
      render('new', :id => @section, :page_id => @page, :subject_id => @subject)
    end
  end

  def edit
    @section = Section.find(params[:id])
  end

  def update
    @section = Section.find(params[:id])
    # Update the section
    if @section.update_attributes(section_params)
    # if the update goes through
      redirect_to(:action => 'show', :id => @section, :page_id => @page, :subject_id => @subject)
      flash[:notice] = "Section '#{@section.name}' updated successfully."
    else
      render('edit')
    end
  end

  def delete
    @section = Section.find(params[:id])
  end

  def destroy
    @section.find(params[:id]).destroy
    flash[:notice] = "Section '#{section.name}' destroyed successfully."
    redirect_to(:action => 'index', :page_id => @page, :subject_id => @subject)
  end

  private
    def section_params
      params.require(:section).permit(:page_id, :name, :position, :visible, :content_type, :content)
    end

    def find_pages
      if params[:page_id && :subject_id]
        @page = Page.find(params[:page_id])
        @subject = Subject.find(params[:subject_id])
      end
    end
    
end
