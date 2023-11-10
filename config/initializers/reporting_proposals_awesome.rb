
  Decidim.component_registry.find(:reporting_proposals).tap do |component|
    component.settings(:global) do |settings|
      settings.attribute :awesome_voting_manifest,
                         type: :select,
                         default: "",
                         choices: -> { ["default"] + Decidim::DecidimAwesome.voting_registry.manifests.map(&:name) },
                         readonly: lambda { |context|
                           Decidim::Proposals::Proposal.where(component: context[:component]).where.not(proposal_votes_count: 0).any?
                         }
      settings.attribute :voting_cards_box_title,
                         type: :string,
                         translated: true
      settings.attribute :voting_cards_show_modal_help,
                         type: :boolean,
                         default: true
      settings.attribute :voting_cards_show_abstain,
                         type: :boolean,
                         default: false
      settings.attribute :voting_cards_instructions,
                         type: :text,
                         translated: true,
                         editor: true

	end
