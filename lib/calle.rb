require_relative "casilla"

module ModeloQytetet
  class Calle < Casilla
    def initialize(numCasilla, titulo)
      super(numCasilla,TipoCasilla::CALLE,titulo.precioC)
      @titulo = titulo
    end
    
     attr_accessor :titulo
   
    def asignar_propietario(jugador)
      @titulo.propietario = jugador
      return @titulo
    end
    
    def pagar_alquiler
      return @titulo.pagar_alquiler
    end
    
    def propietario_encarcelado
      @titulo.propietario_encarcelado
    end
    
    def tengo_propietario
      @titulo.tengo_propietario
    end
    
    def soy_edificable
      return true
    end
    
    def to_s
      return super + "Titulo propiedad: #{@titulo}"
    end
    
  end
end