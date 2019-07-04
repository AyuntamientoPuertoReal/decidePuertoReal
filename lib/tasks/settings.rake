namespace :settings do

  desc "Remove deprecated settings"
  task remove_deprecated_settings: :environment do
    ApplicationLogger.new.info "Removing deprecated settings"

    deprecated_keys = [
      "place_name",
      "banner-style.banner-style-one",
      "banner-style.banner-style-two",
      "banner-style.banner-style-three",
      "banner-img.banner-img-one",
      "banner-img.banner-img-two",
      "banner-img.banner-img-three",
      "verification_offices_url",
      "feature.spending_proposals",
      "feature.spending_proposal_features.phase1",
      "feature.spending_proposal_features.phase2",
      "feature.spending_proposal_features.phase3",
      "feature.spending_proposal_features.voting_allowed",
      "feature.spending_proposal_features.final_voting_allowed",
      "feature.spending_proposal_features.open_results_page",
      "feature.spending_proposal_features.valuation_allowed"
    ]

    deprecated_keys.each do |key|
      Setting.where(key: key).first&.destroy
    end
  end

  desc "Rename existing settings"
  task rename_setting_keys: :environment do
    Setting.rename_key from: "map_latitude",  to: "map.latitude"
    Setting.rename_key from: "map_longitude", to: "map.longitude"
    Setting.rename_key from: "map_zoom",      to: "map.zoom"

    Setting.rename_key from: "feature.debates",     to: "process.debates"
    Setting.rename_key from: "feature.proposals",   to: "process.proposals"
    Setting.rename_key from: "feature.polls",       to: "process.polls"
    Setting.rename_key from: "feature.budgets",     to: "process.budgets"
    Setting.rename_key from: "feature.legislation", to: "process.legislation"

    Setting.rename_key from: "per_page_code_head", to: "html.per_page_code_head"
    Setting.rename_key from: "per_page_code_body", to: "html.per_page_code_body"

    Setting.rename_key from: "feature.homepage.widgets.feeds.proposals", to: "homepage.widgets.feeds.proposals"
    Setting.rename_key from: "feature.homepage.widgets.feeds.debates",   to: "homepage.widgets.feeds.debates"
    Setting.rename_key from: "feature.homepage.widgets.feeds.processes", to: "homepage.widgets.feeds.processes"
  end

  desc "Add new settings"
  task add_new_settings: :environment do
    Setting.add_new_settings
  end

  desc "Create new Attached Documents feature setting"
  task create_attached_documents_setting: :environment do
    Setting['feature.allow_attached_documents'] = true
  end

  desc "Enable recommendations settings"
  task enable_recommendations: :environment do
    Setting['feature.user.recommendations'] = true
    Setting['feature.user.recommendations_on_debates'] = true
    Setting['feature.user.recommendations_on_proposals'] = true
  end

  desc "Enable Help page"
  task enable_help_page: :environment do
    Setting['feature.help_page'] = true
  end

  desc "Enable Featured proposals"
  task enable_featured_proposals: :environment do
    Setting['feature.featured_proposals'] = true
    Setting['featured_proposals_number'] = 3
  end

  desc "Create new period to calculate hot_score"
  task create_hot_score_period_setting: :environment do
    Setting['hot_score_period_in_days'] = 31
  end
end
