
require 'seats/session'

module Seats
  module LoginCtl
    PARAMETERS = %w[Id Name Remote Active IdleHint Class TTY RemoteHost]

    module_function

    def command *args
      `#{['loginctl', '--no-pager', '--no-legend', args].flatten.join(' ')}`
    end

    def CURRENT_SESSION_ID
      ENV['XDG_SESSION_ID']
    end

    def get_session_ids
      command.squeeze(' ').split($/).map(&:strip).map(&:split).map(&:first)
    end

    def get_session(_ids, *_params)
      ids = [ _ids ].flatten.map(&:to_s)
      params = _params.flatten.map { |p| "-p #{p}" }

      if ids.empty?
        raise ArgumentError, 'must supply atleast one id'
      else
        sessions = command(*params, 'show-session', *ids).split($/ * 2)

        if ids.size == 1 && !_ids.is_a?(Array)
          if sessions.empty?
            nil
          else
            Seats::Session.new sessions.first
          end
        else
          sessions.map { |x| Seats::Session.new x }
        end
      end
    end
  end
end
