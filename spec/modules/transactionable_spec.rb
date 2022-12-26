# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Transactionable do
  subject do
    Struct.new(:id) do
      include Transactionable
    end
  end

  describe '#generate_transaction_id' do
    describe 'if persisted (has ID)' do
      it 'should return string' do
        instance = subject.new(123)

        Timecop.freeze(Time.local(1997, 6, 13)) do
          transaction_id = instance.generate_transaction_id
          expect(transaction_id).to eq '130697-00123'
        end
      end
    end

    describe 'if not persisted (has not ID)' do
      it 'should return string' do
        expect(subject.new.generate_transaction_id).to be_nil
      end
    end
  end
end
