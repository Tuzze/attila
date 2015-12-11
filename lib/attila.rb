require "attila/version"
require "attila/generator"
require "attila/data_translator"
require "attila/data_layers/pg"
require "attila/tfd"


module Attila
  def self.root
    File.dirname __dir__
    end
end
