# frozen_string_literal: true

class AddLockedAtToDecidimStatsCollections < ActiveRecord::Migration[6.1]
  def change
    add_column :decidim_stats_collections, :locked_at, :datetime
  end
end
