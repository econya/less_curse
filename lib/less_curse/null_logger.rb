require 'logger'

module LessCurse
  # NullLogger â la hawkins: http://hawkins.io/2013/08/using-the-ruby-logger/
  class NullLogger < Logger
    def initialize(*args)  ; end
    def add(*args, &block) ; end
  end
end
