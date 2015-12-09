require "set"
require "glpk_sat"

module Attila

class Generator

  def generateSets
    f = GlpkSat::Formula.new
    puts "hi I am generating #{f}"
  end

end

end