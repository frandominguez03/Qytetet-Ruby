# encoding: utf-8
# author: Francisco Domínguez

require "singleton"

class Dado
  include Singleton
  
  def initialize
    @valor = 0
  end
  
  attr_reader :valor
  
  protected
  def tirar
    
  end
end
