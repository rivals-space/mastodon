# frozen_string_literal: true

class ChangeAvatarAndHeaderDescriptionNonNullable < ActiveRecord::Migration[7.2]
  def change
    change_column_default :accounts, :avatar_description, from: nil, to: ''
    add_check_constraint :accounts, 'avatar_description IS NOT NULL', name: 'accounts_avatar_description_null', validate: false

    change_column_default :accounts, :header_description, from: nil, to: ''
    add_check_constraint :accounts, 'header_description IS NOT NULL', name: 'accounts_header_description_null', validate: false

    safety_assured do
      execute "UPDATE accounts SET avatar_description = COALESCE(avatar_description, ''), header_description = COALESCE(header_description, '') WHERE avatar_description IS NULL OR header_description IS NULL"
    end
  end
end
