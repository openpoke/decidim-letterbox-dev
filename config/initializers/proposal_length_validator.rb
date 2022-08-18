# frozen_string_literal: true

Rails.application.configure do
  config.after_initialize do
    Decidim::Proposals::ProposalWizardCreateStepForm
      .validators_on(:title).find { |v| v.is_a?(ActiveModel::Validations::LengthValidator) }
      .instance_variable_set(:@options, { minimum: 7, maximum: 150 })
  end
end
