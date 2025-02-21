# frozen_string_literal: true

# This migration comes from decidim_templates (originally 20221006184905)

class MigrateTemplateable < ActiveRecord::Migration[6.0]
  def self.up
    Decidim::Templates::Template.find_each do |template|
      template.update(target: template.templatable_type.demodulize.tableize.singularize)
    end
  end

  def self.down; end
end
