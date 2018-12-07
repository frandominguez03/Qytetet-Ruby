# encoding: utf-8
# author: Francisco Domínguez

require "singleton"

class Dado
  include Singleton
  
  def initialize
    @valor = 0
  end
  
  attr_reader :valor
  
  def tirar
    aleatorio = Random.new
    
    @valor = aleatorio.rand(6)+1
  end
end
