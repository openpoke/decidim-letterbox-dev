# frozen_string_literal: true
# This migration comes from decidim_participatory_documents (originally 20221115233021)

class CreateDecidimParticipatoryDocumentsParticipationSections < ActiveRecord::Migration[6.0]
  def change
    create_table :decidim_participatory_documents_sections do |t|
      t.belongs_to :document,
                   null: true,
                   index: { name: "document_zones" }
      t.jsonb :title
      t.jsonb :description
      t.string :state
      t.string :uid, index: true
      t.datetime :published_at
      t.timestamps
    end
  end
end
