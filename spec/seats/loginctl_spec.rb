require 'spec_helper'

describe Seats::LoginCtl do
  describe '#command' do

    it 'does a system call' do
      expect(described_class).to receive(:`).with('loginctl --no-pager --no-legend')
      Seats::LoginCtl.command
    end

    it 'allows for arguments' do
      expect(described_class).to receive(:`).with('loginctl --no-pager --no-legend --version')
      Seats::LoginCtl.command '--version'
    end

    it 'runs successfully' do
      Seats::LoginCtl.command
      expect($?).to eq(0)
    end
  end

  describe '#CURRENT_SESSION_ID' do
    let(:id) { Seats::LoginCtl.CURRENT_SESSION_ID }

    it 'is not nil' do
      expect(id).not_to be_nil
    end

    it 'equals the environment variable' do
      expect(Seats::LoginCtl.CURRENT_SESSION_ID).to eq(ENV['XDG_SESSION_ID'])
    end
  end

  describe '#get_session_ids' do
    it 'returns an array' do
    end

    it 'returns the current session' do
      ids = Seats::LoginCtl.get_session_ids
      expect(ids.length).to be >= 1
      expect(Seats::LoginCtl.CURRENT_SESSION_ID).not_to be_nil
      expect(ids).to include(Seats::LoginCtl.CURRENT_SESSION_ID)
    end
  end

  describe '#get_session' do
    it 'accepts a single id' do
      session = Seats::LoginCtl.get_session Seats::LoginCtl.CURRENT_SESSION_ID
      expect(session).to be_kind_of(Seats::Session)
    end

    it 'accepts multiple ids' do
      sessions = Seats::LoginCtl.get_session [ Seats::LoginCtl.CURRENT_SESSION_ID ] * 2
      expect(sessions).to be_kind_of(Array)
    end

    it 'requires one or more ids' do
      expect { Seats::LoginCtl.get_session }.to raise_error(ArgumentError)
    end

    describe 'Session' do
      it 'holds the properties' do
        session = Seats::LoginCtl.get_session Seats::LoginCtl.CURRENT_SESSION_ID, %w[Id Name]
        expect(session).to respond_to :id
        expect(session).to respond_to :name
      end

      it 'ignores non-existent properties' do
        session = Seats::LoginCtl.get_session Seats::LoginCtl.CURRENT_SESSION_ID, %w[Id Name Foo]
        expect(session).to respond_to :id
        expect(session).to respond_to :name
        expect(session).not_to respond_to :foo
      end

      it 'id is the same as provided' do
        session = Seats::LoginCtl.get_session Seats::LoginCtl.CURRENT_SESSION_ID, %w[Id]
        expect(session.id).to eq(Seats::LoginCtl.CURRENT_SESSION_ID)
      end
    end
  end
end
