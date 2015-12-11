require 'set'

module Attila

  class TFD

    attr_reader :atemporals, :epsilon, :nil_tolerance

    def initialize(params= {})
      @atemporals, @epsilon, @nil_tolerance = Set.new(params[:attributes].keys), params[:epsilon], params[:nil_tolerance]
      load("#{Attila.root}/lib/attila/tfds/#{params[:kind]}.rb")
      eval("init_#{params[:kind]}(params)")
    end

  end

end