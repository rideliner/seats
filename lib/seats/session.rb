
module Seats
  class Session
    def initialize str
      @hash = Hash[str.each_line.map { |x|
        arr = x.chomp.split('=')
        [ arr[0].downcase.to_sym, case arr[1]
        when 'no'
          false
        when 'yes'
          true
        else
          # will fix where arr[1] doesn't exist (sets it to nil)
          arr[1]
        end ]
      }]
    end

    def method_missing(method_name, *arguments, &block)
      if @hash.has_key?(method_name)
        @hash[method_name]
      else
        super
      end
    end

    def respond_to_missing?(method_name, include_private = false)
      @hash.has_key?(method_name) || super
    end
  end
end
