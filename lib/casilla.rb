# encoding: utf-8
# author: Francisco Domínguez.

module ModeloQytetet
  class Casilla
    
    def initialize(tipo, numCas, titulo, coste)
      @numeroCasilla = numCas
      @tipo = tipo
      @titulo = titulo
      @coste = coste
    end
    
    def self.calle(numCas, titulo)
      new(TipoCasilla::CALLE, numCas, titulo, titulo.precioCompra)
    end
    
    def self.casilla(tipo, numCas, coste)
      new(tipo, numCas, nil, coste)
    end
    
    private_class_method :new
    
    attr_reader :numeroCasilla, :tipo, :coste, :titulo
    attr_accessor :titulo
    
    def asignar_propietario(jugador)
      @titulo.propietario = jugador
      
      return @titulo
    end
    
    def pagar_alquiler
      coste = @titulo.pagar_alquiler
      
      return coste
    end
    
    def propietario_encarcelado
      @titulo.propietario_encarcelado
    end
    
    def soy_edificable
      return @tipo == TipoCasilla::CALLE
    end
    
    def tengo_propietario
      @titulo.tengo_propietario
    end    
    
    def to_s
      if @tipo == TipoCasilla::CALLE
        "numeroCasilla: #{@numeroCasilla} \n coste: #{@coste} \n tipo: #{@tipo} \n titulo: #{@titulo}"
      else
        "numeroCasilla: #{@numeroCasilla} \n coste: #{@coste} \n tipo: #{@tipo}"
      end
    end
  end
end
