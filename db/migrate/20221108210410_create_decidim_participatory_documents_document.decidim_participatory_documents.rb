# frozen_string_literal: true
# This migration comes from decidim_participatory_documents (originally 20221018112720)

class CreateDecidimParticipatoryDocumentsDocument < ActiveRecord::Migration[6.0]
  def change
    create_table :decidim_participatory_documents_documents do |t|
      t.jsonb :title
      t.jsonb :description
      t.belongs_to :decidim_component, null: false, index: { name: "participatory_documents_document_decidim_component" }
      t.references :decidim_author, polymorphic: true, null: false, index: { name: "participatory_documents_document_author_id_and_type" }
      t.references :decidim_user_group, null: true, index: { name: "participatory_documents_document_user_group" }
      t.timestamps
    end
  end
end
