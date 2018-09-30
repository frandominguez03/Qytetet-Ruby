# encoding: utf-8
# author: Francisco Domínguez.

require_relative "sorpresa"
require_relative "qytetet"

module ModeloQytetet
  class PruebaQytetet
    @@juego = Qytetet.new
    
    def self.mayor_que_cero
      mayor_cero = Array.new
      @@juego.mazo.each { |carta|
        if carta.valor > 0
          mayor_cero << carta
        end
      }
      return mayor_cero
    end
    
    def self.tipo_casilla
      tipo_casilla = Array.new
      @@juego.mazo.each { |carta|
        if carta.tipo == TipoSorpresa::IRACASILLA
          tipo_casilla << carta
        end
      }
      return tipo_casilla
    end
    
    def self.tipo_sorpresa(sorpresa)
      tipo_sorpresa = Array.new
      @@juego.mazo.each { |carta|
        if carta.tipo == TipoSorpresa::const_get(sorpresa)
          tipo_sorpresa << carta
        end
      }
      return tipo_sorpresa
    end
    
    def self.main
      @@juego.inicializar_cartas_sorpresa
      
      puts "Cartas con valor mayor a cero: "
      puts mayor_que_cero << "\n"
      
      puts "Cartas del tipo ir a casilla: "
      puts tipo_casilla << "\n"
      
      TipoSorpresa::constants.each { |const_get|
        puts "Cartas del tipo #{const_get}: "
        puts tipo_sorpresa(const_get)
      }
    end
  end
  
  PruebaQytetet.main
end