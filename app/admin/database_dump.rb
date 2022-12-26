# frozen_string_literal: true

ActiveAdmin.register DatabaseDump do
  menu parent: 'Database'

  config.filters = false
  config.sort_order = 'created_at_desc'

  actions :index, :destroy
  action_item :make_dump, only: :index do
    link_to 'Make database dump', [:make_database_dump, ActiveAdmin.application.default_namespace, :database_dumps], method: :post
  end

  index do
    column :id
    column :original_filename
    column :created_at

    actions do |database_dump|
      text_node link_to 'Download', [:download, ActiveAdmin.application.default_namespace, database_dump]
    end
    panel 'How to import dump to your local database?', id: 'help-panel' do
      render partial: 'admin/database_dump_header'
    end
  end

  collection_action :make_database_dump, method: :post do
    DumpDatabaseJob.perform_later(current_admin_user.id)
    redirect_to [ActiveAdmin.application.default_namespace, :database_dumps], notice: 'You will receive an email after operation completion.'
  end

  member_action :download, method: :get do
    database_dump = DatabaseDump.find_by(id: params[:id])
    redirect_to database_dump.file_url
  end
end
