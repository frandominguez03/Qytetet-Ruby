# encoding: utf-8
# author: Francisco Domínguez

module ModeloQytetet
  class Calle < Casilla
    def initialize(numCasilla, titulo)
      @coste = titulo.precioCompra
      @titulo = titulo
      @numCasilla = numCasilla
      @tipo = TipoCasilla::CALLE
    end
    
    attr_reader :tipo, :coste, :numCasilla
    attr_accessor :titulo
    
    public
    def asignar_propietario(jugador)
      @titulo.propietario = jugador
    end
    
    def pagar_alquiler
      coste = @titulo.pagar_alquiler
      
      return coste
    end
    
    def propietario_encarcelado
      @titulo.propietario_encarcelado
    end
    
    def tengo_propietario
      @titulo.tengo_propietario
    end 
  end
end
