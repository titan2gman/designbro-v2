# frozen_string_literal: true

RSpec.describe DesignForm do
  describe '#update' do
    it 'updates changes into design' do
      project = create(:project)
      design  = create(:design, rating: 2)

      attrs = {
        rating: 3,
        id: design.id,
        project: project
      }

      form = DesignForm.new(attrs)

      expect { form.update }
        .to broadcast(:send_designer_stats_entity)

      design.reload

      expect(design.rating).to eq(3)
    end

    context 'design in stationery state' do
      it 'changes spot state to stationery uploaded' do
        project = create(:project, state: Project::STATE_FINALIST_STAGE)
        design  = create(:stationery_design)

        attrs = {
          name: 'name',
          id: design.id,
          project: project,
          uploaded_file: create(:design_file)
        }

        form = DesignForm.new(attrs)

        expect(form).to receive(:broadcast).with(:new_design_uploaded, design)
        expect(form).to receive(:broadcast).with(:send_designer_stats_entity, design)

        form.update
        design.reload

        expect(design.spot.state).to eq(Spot::STATE_STATIONERY_UPLOADED.to_s)
      end
    end

    context 'finalist is setting to true' do
      it 'set state to finalist' do
        project = create(:project, state: Project::STATE_DESIGN_STAGE, project_type: [:logo, :packaging].sample)
        design  = create(:design, project: project)

        attrs = {
          id: design.id,
          finalist: true,
          project: project
        }

        form = DesignForm.new(attrs)

        expect { form.update }
          .to broadcast(:send_designer_stats_entity)

        design.reload

        expect(design.spot.state).to eq(Spot::STATE_FINALIST.to_s)
      end

      it 'set state to stationery' do
        project = create(:brand_identity_project, state: Project::STATE_DESIGN_STAGE)
        design  = create(:design, project: project)

        attrs = {
          id: design.id,
          finalist: true,
          project: project
        }

        form = DesignForm.new(attrs)

        expect { form.update }
          .to broadcast(:send_designer_stats_entity)

        design.reload

        expect(design.spot.state).to eq(Spot::STATE_STATIONERY.to_s)
      end
    end

    context 'stationery approved event' do
      it 'change design state to finalist' do
        project = create(:brand_identity_project, state: Project::STATE_FINALIST_STAGE)
        design  = create(:stationery_uploaded_design, project: project)

        attrs = {
          id: design.id,
          project: project,
          stationery_approved: true
        }

        form = DesignForm.new(attrs)

        expect { form.update }
          .to broadcast(:send_designer_stats_entity)

        design.reload

        expect(design.spot.state).to eq(Spot::STATE_FINALIST.to_s)
      end
    end
  end

  describe '#save' do
    it 'change spot state to design_uploaded' do
      project = create(:packaging_project, state: Project::STATE_DESIGN_STAGE)

      attrs = {
        name: 'name',
        project: project,
        spot: create(:reserved_spot),
        uploaded_file: create(:design_file)
      }

      form = DesignForm.new(attrs)

      expect(form).to receive(:broadcast).with(:new_design_uploaded, an_instance_of(Design))
      expect(form).to receive(:broadcast).with(:send_designer_stats_entity, an_instance_of(Design))

      form.save

      design = form.design

      expect(design.spot.state).to eq(Spot::STATE_DESIGN_UPLOADED.to_s)
    end
  end
end
