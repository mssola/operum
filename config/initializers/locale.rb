# frozen_string_literal: true

I18n.available_locales = %i[en ca]

I18n.default_locale = if Rails.env.test?
                        :en
                      else
                        ENV.fetch('OPERUM_DEFAULT_LOCALE', :ca).to_sym
                      end

Rails.logger.info "Locale: #{I18n.default_locale}"
