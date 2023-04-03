# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
# You can remove the 'faker' gem if you don't want Decidim seeds.

require "decidim/faker/internet"
require "decidim/faker/localized"

Decidim.seed!

# rubocop:disable Rails/SkipsModelValidations
Decidim::Organization.first.update_attribute(:smtp_settings, nil)

Decidim::User.find_by(email: "admin@example.org").update_attribute(:nickname, "admin")
Decidim::User.find_by(email: "user@example.org").update_attribute(:nickname, "user")
Decidim::User.find_by(email: "user2@example.org").update_attribute(:nickname, "user2")
Decidim::User.find_by(email: "locked_user@example.org").update_attribute(:nickname, "lockeduser")
# rubocop:enable Rails/SkipsModelValidations
