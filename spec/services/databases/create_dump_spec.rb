# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Databases::CreateDump do
  subject { described_class.new }

  let(:time_now) { Time.current.change(:usec) }

  describe '#call' do
    describe 'success? true' do
      it 'calls all methods' do
        allow(subject).to receive(:success?) { true }
        expect(subject).to receive(:backup_database)
        expect(subject).to receive(:upload_file_to_s3)
        expect(subject).to receive(:remove_local_backup)
        subject.call
      end
    end

    describe 'success? true' do
      it 'calls only backup_database' do
        allow(subject).to receive(:success?) { false }
        expect(subject).to receive(:backup_database)
        expect(subject).not_to receive(:upload_file_to_s3)
        expect(subject).not_to receive(:remove_local_backup)
        subject.call
      end
    end
  end

  describe '#backup_database' do
    it do
      file_name = subject.send(:backup_filename)
      dump_command = "pg_dump #{subject.send(:database_atts)} | gzip -9 > tmp/#{file_name}.psql.gz"
      expect(subject).to receive(:system).with(dump_command) { true }
      subject.send(:backup_database)
      expect(subject.success?).to be_truthy
      `rm -f tmp/#{file_name}`
    end
  end

  describe '#upload_file_to_s3' do
    it do
      allow(subject).to receive(:store_path) { 'spec/support/fixtures' }
      allow(subject).to receive(:backup_filename) { 'database_dump' }
      expect { subject.send(:upload_file_to_s3) }.to change { DatabaseDump.count }.by(1)
      FileUtils.rm_rf(Dir["#{Rails.root}/public/database_dumps"])
    end
  end

  describe '#remove_local_backup' do
    it do
      file_name = 'database_dump'
      allow(subject).to receive(:backup_filename) { file_name }
      expect(File).to receive(:exist?)
        .with('tmp/database_dump.psql.gz')
        .and_return(true)
      expect(File).to receive(:delete).with('tmp/database_dump.psql.gz')
      subject.send(:remove_local_backup)
    end
  end

  describe '#database_atts' do
    it 'returns database attrs' do
      db_config = {
        'user' => 'username',
        'password' => 'password',
        'database' => 'database'
      }
      allow(subject).to receive(:db_config) { db_config }
      expect(subject.send(:database_atts)).to eq(
        "--dbname=postgresql://#{db_config['user']}:#{db_config['password']}@localhost:5432/#{db_config['database']} --verbose --clean --no-owner --format=p --no-acl"
      )
    end
  end

  describe '#host' do
    describe 'development' do
      it do
        allow(subject).to receive(:environment) { 'development' }
        expect(subject.send(:host)).to eq 'localhost'
      end
    end

    describe 'staging' do
      it do
        host = 'host'
        allow(subject).to receive(:environment) { 'staging' }
        allow(ActiveRecord::Base).to receive(:configurations) { { 'staging' => { 'host' => host } } }
        expect(subject.send(:host)).to eq host
      end
    end

    describe 'production' do
      it do
        host = 'host'
        allow(subject).to receive(:environment) { 'production' }
        allow(ActiveRecord::Base).to receive(:configurations) { { 'production' => { 'host' => host } } }
        expect(subject.send(:host)).to eq host
      end
    end
  end

  describe '#port' do
    describe 'development' do
      it do
        allow(subject).to receive(:environment) { 'development' }
        expect(subject.send(:port)).to eq '5432'
      end
    end

    describe 'staging' do
      it do
        port = 'port'
        allow(subject).to receive(:environment) { 'staging' }
        allow(ActiveRecord::Base).to receive(:configurations) { { 'staging' => { 'port' => port } } }
        expect(subject.send(:port)).to eq port
      end
    end

    describe 'production' do
      it do
        port = 'port'
        allow(subject).to receive(:environment) { 'production' }
        allow(ActiveRecord::Base).to receive(:configurations) { { 'production' => { 'port' => port } } }
        expect(subject.send(:port)).to eq port
      end
    end
  end
end
