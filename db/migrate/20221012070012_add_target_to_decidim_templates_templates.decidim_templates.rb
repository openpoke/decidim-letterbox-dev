# frozen_string_literal: true

# This migration comes from decidim_templates (originally 20221006184809)

class AddTargetToDecidimTemplatesTemplates < ActiveRecord::Migration[6.0]
  def change
    add_column :decidim_templates_templates, :target, :string
  end
end
