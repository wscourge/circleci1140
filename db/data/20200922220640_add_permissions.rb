# frozen_string_literal: true

class AddPermissions < ActiveRecord::Migration[6.0]
  PERMISSIONS = [
    { slug: 'sudo', name: 'Super Admin' },
    { slug: 'admin', name: 'Admin' },
    { slug: 'subscriber', name: 'Subscriber' },
    { slug: 'verified', name: 'Verified' },
    { slug: 'cantwait', name: 'Waiting List' },
    { slug: 'anon', name: 'Anonymous' }
  ]

  private_constant :PERMISSIONS

  def up
    Permission.insert_all(PERMISSIONS)
  end

  def down
    Permission.delete_all
  end
end
