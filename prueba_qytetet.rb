# encoding: utf-8
# author: Francisco Domínguez.

require_relative "sorpresa"

module ModeloQytetet
  class PruebaQytetet
    @@juego = Qytetet.new()
    
    def self.mayor_que_cero
      @mayor_cero
      for s in @@juego.mazo
        if(mazo.valor > 0)
          @mayor_cero.mazo = s
        end
      end
    end
    
    def self.tipo_casilla
      @tipo_casilla
      for s in @@juego.mazo
        if(mazo.tipo == :Ir_casilla)
          @tipo_casilla.mazo = s
        end
      end
    end
    
    def self.tipo_sorpresa(sorpresa)
      @tipo_sorpresa
      for s in TipoSorpresa::constants
        if(mazo.tipo == sorpresa)
          @tipo_sorpresa = s
        end
      end
    end
    
    def self.main
      Qytetet.inicializarCartasSorpresa
      
      puts mayor_que_cero
      puts tipo_casilla
      puts tipo_sorpresa
    end
  end
  
  PruebaQytetet.main
end