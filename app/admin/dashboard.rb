# frozen_string_literal: true

ActiveAdmin.register_page 'Dashboard' do
  menu priority: 1, label: proc { I18n.t('active_admin.dashboard') }

  content title: proc { I18n.t('active_admin.dashboard') } do
    columns do
      column max_width: '400px' do
        panel 'Quick Designers Upload' do
          form action: '/admin/designers/import', method: :post, enctype: 'multipart/form-data' do
            input type: :file, name: :designers
            input type: :submit, value: 'Upload'
          end
        end
      end
    end
  end
end
