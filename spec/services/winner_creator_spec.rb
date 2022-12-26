# frozen_string_literal: true

RSpec.describe WinnerCreator do
  describe '.call' do
    [:logo, :packaging, :brand_identity].each do |type|
      context "#{type} project" do
        it 'changes spot state to :winner' do
          project = create(:"#{type}_project", state: Project::STATE_FINALIST_STAGE)
          designs = create_list(:finalist_design, 3, project: project)

          winner_design = designs.first

          message_delivery = instance_double(ActionMailer::MessageDelivery)
          expect(DesignerMailer).to receive(:design_eliminated).with(design: designs[1]).and_return(message_delivery)
          expect(DesignerMailer).to receive(:design_eliminated).with(design: designs[2]).and_return(message_delivery)
          allow(message_delivery).to receive(:deliver_later)

          expect(EarningCreator::PayFinalists).to receive(:call).with(project)

          expect(winner_design.project).to receive(:select_winner!)

          expect { WinnerCreator.call(winner_design) }
            .to broadcast(:send_designer_stats_entity)

          expect(winner_design.reload.spot.state)
            .to eq(Spot::STATE_WINNER.to_s)
        end
      end
    end
  end
end
