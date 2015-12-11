require 'set'

module Attila

  class TFD

    attr_reader :subject

    def init_dfd(params={})
      @subject = Set.new(params[:subject])
    end

  end

end