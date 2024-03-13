# frozen_string_literal: true

I18n.available_locales = %i[en ca]
I18n.default_locale = ENV.fetch('OPERUM_DEFAULT_LOCALE', :ca).to_sym

Rails.logger.info "Locale: #{I18n.default_locale}"
