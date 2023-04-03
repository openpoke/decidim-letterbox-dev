# frozen_string_literal: true

# This migration comes from decidim (originally 20181126145142)

class AddIdDocumentsFieldsToOrg < ActiveRecord::Migration[5.2]
  def change
    unless ActiveRecord::Base.connection.column_exists?(:decidim_organizations, :id_documents_explanation_text)
      add_column :decidim_organizations, :id_documents_explanation_text, :jsonb, default: {}
    end
    unless ActiveRecord::Base.connection.column_exists?(:decidim_organizations, :id_documents_methods)
      add_column :decidim_organizations, :id_documents_methods, :string, array: true, default: ['online']
      Decidim::Organization.reset_column_information
      Decidim::Organization.update_all(id_documents_methods: ['online'])
    end
  end
end
