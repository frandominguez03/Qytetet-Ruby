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
    private :titulo=
    
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
        "numeroCasilla: #{@numeroCasilla} \n coste: #{@coste} \n tipo: #{@tipo} \n titulo: #{@titulo}"
      else
        "numeroCasilla: #{@numeroCasilla} \n coste: #{@coste} \n tipo: #{@tipo}"
      end
    end
  end
end
