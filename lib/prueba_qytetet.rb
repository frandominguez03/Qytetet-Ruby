# encoding: utf-8
# author: Francisco Domínguez.

require_relative 'tipo_sorpresa'
require_relative 'sorpresa'
require_relative 'tipo_casilla'
require_relative 'titulo_propiedad'
require_relative 'casilla'
require_relative 'tablero'
require_relative 'qytetet'
require_relative 'dado'
require_relative 'jugador'

module ModeloQytetet
  class PruebaQytetet
    @@juego = Qytetet.instance
    
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
    
    def self.get_nombre_jugadores
      cadena = Array.new
      i=0
      
      puts "Introduzca el numero de jugadores: "
      num_jugadores = gets.chomp.to_i
      
      while i < num_jugadores
        puts "Introduzca el nombre del jugador: "
        cadena[i] = gets
        i+=1
      end
      
      return cadena
    end
    
    def self.main
      @@juego.inicializar_cartas_sorpresa
      tablero = Tablero.new
      
      puts "Imprimimos los métodos de la clase"
      puts "Cartas con valor mayor a cero: "
      puts mayor_que_cero << "\n"
      
      puts "Cartas del tipo ir a casilla: "
      puts tipo_casilla << "\n"
      
      TipoSorpresa::constants.each { |const_get|
        puts "Cartas del tipo #{const_get}: "
        puts tipo_sorpresa(const_get)
      }
      
      puts "Imprimimos el tablero"
      puts tablero.to_s << "\n"
      
      puts "Imprimimos los jugadores"
      puts get_nombre_jugadores << "\n"
      
      puts "Impimimos la instancia Qytetet"
      puts Qytetet.instance
    end
  end
  
  PruebaQytetet.main
end