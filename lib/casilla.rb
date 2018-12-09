# encoding: utf-8
# author: Francisco Domínguez.

module ModeloQytetet
  class Casilla
    
    def initialize(tipo, numCas, coste)
      @numCasilla = numCas
      @tipo = tipo
      @coste = coste
    end
    
    attr_reader :numCasilla, :tipo, :coste    
    
    def soy_edificable
      return @tipo == TipoCasilla::CALLE
    end   
    
    def to_s
      if @tipo == TipoCasilla::CALLE
        "numeroCasilla: #{@numCasilla} \n coste: #{@coste} \n tipo: #{@tipo} \n titulo: #{@titulo}"
      else
        "numeroCasilla: #{@numCasilla} \n coste: #{@coste} \n tipo: #{@tipo}"
      end
    end
  end
end
