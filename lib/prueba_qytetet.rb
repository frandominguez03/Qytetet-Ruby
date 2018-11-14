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
require_relative 'estado_juego'
require_relative 'metodo_salir_carcel'

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
      puts "Introduzca el numero de jugadores"
      numero=gets.chomp.to_i
      nombres=Array.new
      
      for i in 1..numero
        puts "Introduzca el nombre del jugador #{i}"
        nombres.push(gets.chomp)
      end      
    return nombres
    end
    
    def self.main
      nombres = get_nombre_jugadores
      @@juego.inicializar_juego(nombres)
      tablero = Tablero.new
      
      #puts "Imprimimos los métodos de la clase"
      #puts "Cartas con valor mayor a cero: "
      #puts mayor_que_cero << "\n"
      #
      #puts "Cartas del tipo ir a casilla: "
      #puts tipo_casilla << "\n"
      
      #TipoSorpresa::constants.each { |const_get|
      #  puts "Cartas del tipo #{const_get}: "
      #  puts tipo_sorpresa(const_get)
      #}
      
      #puts "Imprimimos el tablero"
      #puts tablero
      
      #puts "Imprimimos los jugadores"
      #puts @@juego.jugadores
      #puts @@juego.jugadorActual
      
      #puts "Impimimos la instancia Qytetet"
      #puts Qytetet.instance
      
      # Probamos el método mover, comprar, diferentes casillas...
      #@@juego.mover(3)
      #puts @@juego.jugadorActual.casillaActual.numeroCasilla
      #@@juego.mover(13)
      #puts @@juego.jugadorActual.casillaActual.numeroCasilla
      #@@juego.jugadorActual.comprar_titulo_propiedad
      #puts @@juego.jugadores
      #@@juego.jugadorActual.casillaActual.asignar_propietario(@@juego.jugadorActual)
      #@@juego.siguiente_jugador
      #@@juego.mover(13)
      #puts @@juego.jugadorActual.saldo
      
      # Probamos a caer en una sorpresa y a aplicar sorpresa después
      #@@juego.mover(2)
      #puts @@juego.mazo[0]
      #@@juego.aplicar_sorpresa
      #puts @@juego.jugadorActual.casillaActual
      
      # Probamos a hipotecar, cancelar hipoteca, vender, edificar casas y hoteles...
      #@@juego.mover(9)
      #@@juego.hipotecar_propiedad(@@juego.jugadorActual.casillaActual.numeroCasilla)
      #@@juego.cancelar_hipoteca(@@juego.jugadorActual.casillaActual.numeroCasilla)
      #@@juego.vender_propiedad(@@juego.jugadorActual.casillaActual.numeroCasilla)
      #@@juego.edificar_casa(@@juego.jugadorActual.casillaActual.numeroCasilla)
      #@@juego.edificar_hotel(@@juego.jugadorActual.casillaActual.numeroCasilla)
      
      # Probamos a salir de la carcel
#      @@juego.jugadorActual.ir_a_carcel(tablero.carcel)
#      if(@@juego.jugadorActual.tengo_carta_libertad)
#        @@juego.intentar_salir_carcel(MetodoSalirCarcel::PAGANDOLIBERTAD)
#      else
#        consigue = @@juego.intentar_salir_carcel(MetodoSalirCarcel::TIRANDODADO)
#        
#        if consigue
#          puts "Sales de la cárcel"
#        else
#          puts "Al palo"
#        end
#      end

#      puts @@juego.jugadorActual
      @@juego.mover(13)
      @@juego.comprar_titulo_propiedad
      puts @@juego.jugadorActual.casillaActual.titulo.propietario
      @@juego.siguiente_jugador
      @@juego.mover(13)
      puts @@juego.jugadorActual.casillaActual.titulo.alquilerBase
      puts @@juego.jugadorActual
    end
  end
  
  PruebaQytetet.main
end