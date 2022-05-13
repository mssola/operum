# frozen_string_literal: true

module ErrorResponse
  extend ActiveSupport::Concern

  def log_exception(exception)
    logger.error "#{exception.class}: #{exception.message}"
    logger.error exception.backtrace.join("\n")
  end

  def error_response(exception)
    status = exception.try(:status) ||
             ActionDispatch::ExceptionWrapper.status_code_for_exception(exception.class.name)

    messages = if exception.is_a?(ActiveRecord::RecordInvalid)
                 exception.record.errors.messages
               elsif status == 500 || status > 500
                 log_exception(exception)
                 I18n.t('errors.internal')
               else
                 exception.try(:message) || I18n.t('errors.internal')
               end

    render json: { status:, messages: }, status:
  end
end
