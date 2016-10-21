class DemoController < ApplicationController
  
  layout 'application'

  def index
  	#render(:template => 'demo/hello')
  	# render('hello') #does the same thing as above with just a string

  end

  def hello
  	# render('index')
  	@array = [1,2,3,4,5]
  	@id = params['id'].to_i
  	@page = params[:page].to_i
  end
 
  def other_hello
  	redirect_to(:controller => 'demo', :action => 'index')
  end

  def lynda
  	redirect_to("http://lynda.com")
  end 

  def text_helpers
  end

  def escape_output
  end

end
