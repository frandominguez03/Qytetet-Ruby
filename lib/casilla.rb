# encoding: utf-8

module ModeloQytetet
  class Casilla
    
    def initialize(numCas, tipo, coste)
      @numCasilla = numCas
      @tipo = tipo
      @coste = coste
    end
    
    attr_reader :numCasilla, :tipo, :coste    
    
    def soy_edificable
      return @tipo == TipoCasilla::CALLE
    end   
    
    def to_s
        "numeroCasilla: #{@numCasilla} \n coste: #{@coste} \n tipo: #{@tipo}"
    end
  end
end