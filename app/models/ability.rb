# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user = nil, project_id = nil)
    user ||= User.new

    guest_abilities(project_id) if user.guest?
    designer_abilities(user, user.designer) if user.designer?

    return unless user.client?

    if user.client.god?
      god_client_abilities(user, user.client)
    else
      client_abilities(user, user.client)
    end
  end

  # rubocop:disable Metrics/PerceivedComplexity
  def designer_abilities(user, designer)
    can [:read], PayoutMinAmount
    can [:read], VatRate
    can [:read], FaqGroup
    can [:read], FaqItem
    can [:read], Product
    can [:read], ProductCategory
    can [:create, :destroy], UploadedFile::DesignerPortfolioWork
    can [:create, :destroy], UploadedFile::HeroImage
    can [:create, :destroy], UploadedFile::Avatar

    can [:read], Designer, user: user

    can [:read], Earning, designer: designer
    can [:read, :create], Payout, designer: designer
    can [:read, :create, :skip], PortfolioWork, designer: designer

    can [:read], Spot, designer: designer
    can [:create], Spot, designer: designer, project: { state: Project::STATE_DESIGN_STAGE.to_s }

    can [:read, :create, :restore, :update], Design, spot: { designer: designer }

    can [:read], DesignerNda, designer: designer
    can [:create], DesignerNda, designer: designer

    can [:create], DirectConversationMessage, user: user, design: { spot: { designer: designer } }
    can [:read], DirectConversationMessage, design: { spot: { designer_id: designer.id } }

    can :search, Project, Project.discoverable_by(designer).where(state: Project::DESIGNER_CAN_READ_STATES) do |project|
      next false unless designer.approved_product_category_ids.include?(project.product_category_id) || (project.product == Product.find(key: 'manual') && designer.approved_product_category_ids.include?(project.manual_product_category_id))
      next false if (designer.clients_that_blocked.pluck(:id) & project.clients.pluck(:id)).any?
      next false unless Project::DESIGNER_CAN_READ_STATES.include? project.state

      true
    end

    can :update, Project, Project.visible_for(designer).where(state: Project::DESIGNER_CAN_UPDATE_STATES) do |project|
      next false unless designer.approved_product_category_ids.include?(project.product_category_id) || (project.product == Product.find(key: 'manual') && designer.approved_product_category_ids.include?(project.manual_product_category_id))
      next false if (designer.clients_that_blocked.pluck(:id) & project.clients.pluck(:id)).any?
      next false unless Project::DESIGNER_CAN_UPDATE_STATES.include? project.state

      next false if !project.design_stage? && project.spots.visible.where(designer: designer).empty?
      next false if project.project_type == 'contest' && project.active_nda_not_free? && project.active_nda_paid? && !designer.accepted_ndas.include?(project.active_nda)

      true
    end

    can :read, Project, Project.includes(:product).visible_for(designer).where(state: Project::DESIGNER_CAN_READ_STATES) do |project|
      next false unless designer.approved_product_category_ids.include?(project.product_category_id) || (project.product == Product.find(key: 'manual') && designer.approved_product_category_ids.include?(project.manual_product_category_id))
      # FIXME: not optimal
      next false if (designer.clients_that_blocked.pluck(:id) & project.clients.pluck(:id)).any?
      next false unless Project::DESIGNER_CAN_READ_STATES.include? project.state

      next false if !project.design_stage? && project.spots.visible.where(designer: designer).empty?
      next false if project.project_type == 'contest' && project.active_nda_not_free? && project.active_nda_paid? && !designer.accepted_ndas.include?(project.active_nda)

      true
    end

    can [:read, :create], ProjectSourceFile, ProjectSourceFile.all do |file|
      file.project.winner == designer && file.designer == designer
    end

    can [:destroy], ProjectSourceFile, ProjectSourceFile.all do |file|
      file.project.winner == designer && file.designer == designer && file.project.review_files?
    end

    can [:read, :create], FeaturedImage, FeaturedImage.all do |file|
      file.project.winner == designer
    end

    can [:destroy], FeaturedImage, FeaturedImage.all do |file|
      file.project.winner == designer && file.project.review_files?
    end
  end

  # rubocop:enable Metrics/PerceivedComplexity

  def client_abilities(user, client)
    can [:read, :all], Brand, company: client.company, visible: true
    can [:read], Discount
    can [:read], VatRate
    can [:read], FaqItem
    can [:read], FaqGroup
    can [:read], NdaPrice
    can [:read], Testimonial
    can [:read], Product
    can [:read], ProductCategory
    can [:read], PortfolioImage
    can [:read], AdditionalDesignPrice
    can [:read], UploadedFile::BrandExample
    can [:create], UploadedFile::TechnicalDrawing

    can [:read, :create], Payment, project: { brand_dna: { brand: { company_id: client.company_id } } }

    can [:create, :read, :search, :upsell_days, :upsell_spots], Project, company: client.company
    can [:update], Project, state: Project::CLIENT_CAN_UPDATE_STATES, company: client.company
    can [:destroy], Project, state: Project::CLIENT_CAN_DESTROY_STATES, company: client.company
    can [:manual_request], Project

    can [:create], DirectConversationMessage, user: user, design: { project: { company: client.company } }

    # FIXME: hack, need refactoring
    can [:read], DirectConversationMessage, DirectConversationMessage.joins(design: { spot: :project }).where(designs: { spots: { project: client.company.projects } }) do
      true
    end

    can [:read], ProjectSourceFile, project: { brand_dna: { brand: { company_id: client.company_id } } }

    can [:read, :update, :make_finalist, :block, :eliminate], Design,
        project: { brand_dna: { brand: { company_id: client.company_id } } },
        spot: { state: Spot::VISIBLE_STATES }

    cannot [:block, :read, :update, :make_finalist, :eliminate], Design,
           spot: { state: 'design_uploaded', project: { state: ['finalist_stage', 'review_files', 'completed', 'canceled', 'error'] } }

    can [:read], Review, client: client
    can [:create], Review,
        client: client,
        design: { spot: { state: Spot::STATE_WINNER.to_s, project: { company: client.company } } }

    [Competitor].each do |clazz|
      can [:create, :destroy], clazz, brand: { company: client.company }
      can [:create, :destroy], clazz, brand: { company: nil }
    end

    [Inspiration, ExistingDesign, ProjectAdditionalDocument, ProjectStockImage].each do |clazz|
      can [:create, :destroy], clazz, project: { state: Project::BEFORE_PAYMENT_STATES, company: client.company }
      can [:create, :destroy], clazz, project: { state: Project::BEFORE_PAYMENT_STATES, company: nil }
    end
  end

  def god_client_abilities(user, client)
    can [:read, :all], Brand, visible: true
    can [:read], Discount
    can [:read], VatRate
    can [:read], FaqItem
    can [:read], FaqGroup
    can [:read], NdaPrice
    can [:read], Testimonial
    can [:read], Product
    can [:read], ProductCategory
    can [:read], PortfolioImage
    can [:read], AdditionalDesignPrice
    can [:read], UploadedFile::BrandExample
    can [:create], UploadedFile::TechnicalDrawing

    can [:read], Payment
    can [:create], Payment, project: { brand_dna: { brand: { company_id: client.company_id } } }

    can [:read, :search], Project
    can [:create], Project, brand: { company: client.company }
    can [:update], Project, state: Project::CLIENT_CAN_UPDATE_STATES, brand: { company: client.company }
    can [:destroy], Project, state: Project::CLIENT_CAN_DESTROY_STATES, brand: { company: client.company }

    can [:read], DirectConversationMessage
    can [:create], DirectConversationMessage, user: user, design: { project: { company: client.company } }
    can [:read], ProjectSourceFile
    can [:read], Design, spot: { state: Spot::VISIBLE_STATES }
    can [:block, :update, :make_finalist, :eliminate], Design,
        project: { company: client.company },
        spot: { state: Spot::VISIBLE_STATES }

    can [:read], Review
    can [:create], Review,
        client: client,
        design: { spot: { state: Spot::STATE_WINNER.to_s, project: { company: client.company } } }

    [Competitor].each do |clazz|
      can [:create, :destroy], clazz, brand: { company: client.company }
      can [:create, :destroy], clazz, brand: { company: nil }
    end

    [Inspiration, ExistingDesign, ProjectAdditionalDocument, ProjectStockImage].each do |clazz|
      can [:create, :destroy], clazz, project: { state: Project::BEFORE_PAYMENT_STATES, company: client.company }
      can [:create, :destroy], clazz, project: { state: Project::BEFORE_PAYMENT_STATES, company: nil }
    end
  end

  def guest_abilities(_project_id)
    can [:read], VatRate
    can [:read], FaqItem
    can [:read], FaqGroup
    can [:read], Product
    can [:read], ProductCategory
    can [:read], PortfolioImage
    can [:read], AdditionalDesignPrice
    can [:read], UploadedFile::BrandExample
    can [:create], UploadedFile::TechnicalDrawing
    can [:read], Review, visible: true
    can [:read], Designer

    can [:read], Brand, company_id: nil
    can [:read, :create, :update, :destroy], Project, state: Project::PUBLIC_STATES, brand_dna: { brand: { company_id: nil } }

    [Competitor].each do |clazz|
      can [:create, :destroy], clazz, brand: { company_id: nil }
    end

    [Inspiration, ExistingDesign, ProjectAdditionalDocument, ProjectStockImage].each do |clazz|
      # TODO: fix ability
      can [:create, :destroy], clazz
    end
  end
end
