# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "decidim/stats/version"

Gem::Specification.new do |spec|
  spec.name = "decidim-stats"
  spec.version = Decidim::Stats.version
  spec.required_ruby_version = ">= 3.0"
  spec.authors = ["Antti Hukkanen"]
  spec.email = ["antti.hukkanen@mainiotech.fi"]

  spec.summary = "Adds possibility to add statistics to Decidim."
  spec.description = "Developers can define the statistics for their module and they will be provided for admins."
  spec.homepage = "https://github.com/mainio/decidim-module-stats"
  spec.license = "AGPL-3.0"

  spec.files = Dir[
    "{app,config,lib}/**/*",
    "LICENSE-AGPLv3.txt",
    "Rakefile",
    "README.md"
  ]

  spec.require_paths = ["lib"]

  spec.add_dependency "decidim-core", Decidim::Stats.decidim_version

  spec.add_development_dependency "decidim-dev", Decidim::Stats.decidim_version
end
