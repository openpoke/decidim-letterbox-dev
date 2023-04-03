# frozen_string_literal: true

# This migration comes from decidim_templates (originally 20221006055954)

class AddFieldValuesToDecidimTemplates < ActiveRecord::Migration[6.0]
  def change
    add_column :decidim_templates_templates, :field_values, :json, default: {}
  end
end
