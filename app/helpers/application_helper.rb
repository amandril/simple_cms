module ApplicationHelper

	def error_messages_for(object)
		render(:partial => 'application/error_messages', :locals => {:object => object})
	end

	def status_tag(boolean, options={})
		options[:true_text] ||= ''
		options[:false_text] ||= ''

		if boolean
			# Generates a span tag and will put whatever text (from options[:true_text]) with class 'status true' or 'status false'
			content_tag(:span, options[:true_text], :class => 'status true')
		else
			content_tag(:span, options[:false_text], :class => 'status false')
		end
	end

end
