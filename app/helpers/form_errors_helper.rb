module FormErrorsHelper
  def error_message_for(object, field)
    return unless object.respond_to?(:errors) && object.errors.include?(field)
    error_messages = object.errors[field].join(', ')
    content_tag(:div, error_messages, class: 'form-error-message')
  end
end 
