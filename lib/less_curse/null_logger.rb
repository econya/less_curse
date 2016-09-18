require 'logger'

# NullLogger â la hawkins: http://hawkins.io/2013/08/using-the-ruby-logger/
module LessCurse
  class NullLogger < Logger
    def initialize(*args)  ; end
    def add(*args, &block) ; end
  end
end
