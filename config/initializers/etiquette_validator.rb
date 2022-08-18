# frozen_string_literal: true

Rails.application.config.to_prepare do
  EtiquetteValidator.class_eval do

    private

    def validate_caps_first(record, attribute, value)
      return unless value.scan(/\A[a-zA-Z]{1}/).empty?

      record.errors.add(attribute, options[:message] || :must_start_with_caps)
    end
  end
end
