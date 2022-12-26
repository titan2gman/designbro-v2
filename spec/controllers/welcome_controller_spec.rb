# frozen_string_literal: true

require 'rails_helper'

RSpec.describe WelcomeController do
  describe 'GET *path' do
    it 'renders welcome/index template' do
      get :index

      expect(controller).to render_template(:index)
    end
  end
end
