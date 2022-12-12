# frozen_string_literal: true
# This migration comes from decidim_participatory_documents (originally 20221205093306)

class ChangeDecidimParticipatoryDocumentsAnnotations < ActiveRecord::Migration[6.0]
  def change
    remove_column :decidim_participatory_documents_annotations, :data
    add_column :decidim_participatory_documents_annotations, :rect, :jsonb, default: {}
    add_column :decidim_participatory_documents_annotations, :page_number, :integer, default: 1
    add_reference :decidim_participatory_documents_annotations, :zone, index: true, foreign_key: { to_table: :decidim_participatory_documents_zones }
  end
end
