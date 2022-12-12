# frozen_string_literal: true
# This migration comes from decidim_participatory_documents (originally 20221205093308)

class AddUidToDecidimParticipatoryDocumentsAnnotations < ActiveRecord::Migration[6.0]
  def change
    add_column :decidim_participatory_documents_annotations, :uid, :string, index: true
  end
end
