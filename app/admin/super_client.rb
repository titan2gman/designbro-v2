# frozen_string_literal: true

ActiveAdmin.register Client, as: 'SuperClient' do
  include AdminShare::Client

  menu parent: 'User'

  scope('all', default: true) { |scope| scope.where(god: true) }

  permit_params :god

  form do |_f|
    semantic_errors

    inputs do
      input :email
      input :password
      input :first_name
      input :last_name
      input :state, as: :select, collection: User.aasm.states_for_select, include_blank: false
      input :god, input_html: { value: true }, as: :hidden
      input :opt_out
    end

    actions
  end

  filter :email
  filter :first_name
  filter :last_name
  filter :country_code
  filter :phone
  filter :created_at

  controller do
    def create
      password = params[:client][:password]
      email = params[:client][:email]
      state = params[:client][:state]
      user = User.new(uid: email, email: email, password: password, state: state)
      @super_client = user.build_client(client_params)

      user.skip_confirmation! if user.devise_modules.include?(:confirmable)

      if user.valid?
        @super_client.save
      else
        @super_client.valid?
        user.errors.each { |k, v| @super_client.errors.add(k, v) }
      end

      respond_with @super_client, location: -> { resource_path }
    end

    def update
      email = params[:client][:email]
      state = params[:client][:state]
      @super_client = resource
      user = @super_client.user
      user.update(email: email, uid: email, state: state)
      if user.valid?
        super
      else
        @super_client.update(resource_params.first)
        user.errors.each { |k, v| @super_client.errors.add(k, v) }
        respond_with @super_client, location: -> { resource_path }
      end
    end

    private

    def client_params
      params.require(:client).permit(
        :company_name,
        :country_code,
        :first_name,
        :state_name,
        :last_name,
        :address1,
        :address2,
        :phone,
        :city,
        :god,
        :zip,
        :vat
      )
    end
  end
end
