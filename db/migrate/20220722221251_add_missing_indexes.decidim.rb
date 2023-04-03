# frozen_string_literal: true

# This migration comes from decidim (originally 20190412105836)

class AddMissingIndexes < ActiveRecord::Migration[5.2]
  def change
    add_index :decidim_follows, %i[decidim_followable_id decidim_followable_type], name: 'index_follows_followable_id_and_type'
    add_index :decidim_user_group_memberships, %i[decidim_user_group_id decidim_user_id], name: 'index_user_group_memberships_group_id_user_id'
    add_index :decidim_users, %i[id type]
    add_index :decidim_users, %i[invited_by_id invited_by_type]
    add_index :versions, %i[item_id item_type]
  end
end
