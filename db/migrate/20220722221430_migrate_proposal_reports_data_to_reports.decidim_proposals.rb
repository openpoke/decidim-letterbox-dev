# frozen_string_literal: true

# This migration comes from decidim_proposals (originally 20170307085300)

class MigrateProposalReportsDataToReports < ActiveRecord::Migration[5.0]
  module Decidim
    module Proposals
      class ProposalReport < ApplicationRecord
        self.table_name = :decidim_proposals_proposal_reports
        belongs_to :user, foreign_key: 'decidim_user_id', class_name: 'Decidim::User'
        belongs_to :proposal, foreign_key: 'decidim_proposal_id', class_name: 'Decidim::Proposals::Proposal'
      end
    end
  end

  def change
    Decidim::Proposals::ProposalReport.find_each do |proposal_report|
      moderation = Decidim::Moderation.find_or_create_by!(reportable: proposal_report.proposal,
                                                          participatory_process: proposal_report.proposal.feature.participatory_space)
      Decidim::Report.create!(moderation: moderation,
                              user: proposal_report.user,
                              reason: proposal_report.reason,
                              details: proposal_report.details)
      moderation.update!(report_count: moderation.report_count + 1)
    end

    drop_table :decidim_proposals_proposal_reports
    remove_column :decidim_proposals_proposals, :report_count
    remove_column :decidim_proposals_proposals, :hidden_at
  end
end
