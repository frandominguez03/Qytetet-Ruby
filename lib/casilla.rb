# encoding: utf-8
# author: Francisco Domínguez.

module ModeloQytetet
  class Casilla
    
    def initialize(tipo, numCas, titulo)
      @numeroCasilla = numCas
      @tipo = tipo
      @propietario = nil
      
      if titulo == nil
        @coste = 0
      else
        @coste = titulo.precioC
        @titulo = titulo
      end
    end
    
    def self.calle(numCas, titulo)
      new(TipoCasilla::CALLE, numCas, titulo)
    end
    
    def self.casilla(tipo, numCas)
      new(tipo, numCas, nil)
    end
    
    private_class_method :new
    
    attr_reader :numeroCasilla, :tipo, :coste, :titulo
    attr_accessor :titulo
    private :titulo=
    
    protected
    def asignar_propietario(jugador)
      
    end
    
    def pagar_alquiler
      
    end
    
    def propietario_encarcelado
      
    end
    
    def soy_edificable
      
    end
    
    def tengo_propietario
      
    end
    
    
    def to_s
      if @tipo == TipoCasilla::CALLE
        "Casilla: numeroCasilla: #{@numeroCasilla} \n coste: #{@coste} \n tipo: #{@tipo} \n titulo: #{@titulo}"
      else
        "Casilla: numeroCasilla: #{@numeroCasilla} \n coste: #{@coste} \n tipo: #{@tipo}"
      end
    end
  end
end
