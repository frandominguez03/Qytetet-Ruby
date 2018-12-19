## encoding: utf-8
## author: David Gómez.
#
#require_relative 'tipo_sorpresa'
#require_relative 'sorpresa'
#require_relative 'tipo_casilla'
#require_relative 'titulo_propiedad'
#require_relative 'casilla'
#require_relative 'tablero'
#require_relative 'qytetet'
#require_relative 'dado'
#require_relative 'jugador'
#require_relative 'estado_juego'
#require_relative 'metodo_salir_carcel'
#
#module ModeloQytetet
#  class PruebaQytetet
#    @@juego = Qytetet.instance
#    
#    def self.mayor_que_cero
#      mayor_cero = Array.new
#      @@juego.mazo.each { |carta|
#        if carta.valor != 0
#          mayor_cero << carta
#        end
#      }
#      return mayor_cero
#    end
#    
#    def self.tipo_casilla
#      tipo_casilla = Array.new
#      @@juego.mazo.each { |carta|
#        if carta.tipo == TipoSorpresa::IRACASILLA
#          tipo_casilla << carta
#        end
#      }
#      return tipo_casilla
#    end
#    
#    def self.tipo_sorpresa(sorpresa)
#      tipo_sorpresa = Array.new
#      @@juego.mazo.each { |carta|
#        if carta.tipo == TipoSorpresa::const_get(sorpresa)
#          tipo_sorpresa << carta
#        end
#      }
#      return tipo_sorpresa
#    end
#    
#    def self.get_nombre_jugadores
#      nombres=Array.new
#      i=0
#      
#      puts "Introduce el numero de jugadores: "
#      numero_jugadores=gets.chomp.to_i
#      
#      while i < numero_jugadores
#        puts "Introduce los nombres de los jugadores"
#        nombres[i] = gets
#        i+=1
#      end
#      
#      return nombres
#      
#    end
#    
#    
#    
#    def self.main
#      nombres = get_nombre_jugadores
#      @@juego.inicializar_juego(nombres)
#      tablero = Tablero.new
#      
#      puts "Jugadores"
#      puts  @@juego.jugadores.to_s<< "\n"
#
#      puts "Cartas con valor mayor a cero: "
#      puts mayor_que_cero << "\n"
#      
#      puts "Cartas del tipo ir a casilla: "
#      puts tipo_casilla << "\n"
#      
#      TipoSorpresa::constants.each { |const_get|
#        puts "Cartas del tipo #{const_get}: "
#        puts tipo_sorpresa(const_get)
#      }
#      puts "Tablero"
#      puts tablero.to_s << "\n"
#      
#
#      puts "Qytetet"
#      puts Qytetet.instance
#     
#      # Probamos el método mover, comprar, diferentes casillas...
#      @@juego.mover(3)
#      puts @@juego.jugador_actual.casillaActual.numCasilla
#      @@juego.mover(13)
#      puts @@juego.jugador_actual.casillaActual.numCasilla
#      @@juego.jugador_actual.comprar_titulo_propiedad
#      puts @@juego.jugadores
#      @@juego.jugador_actual.casillaActual.asignar_propietario(@@juego.jugador_actual)
#      @@juego.siguiente_jugador
#      @@juego.mover(13)
#      puts @@juego.jugador_actual.saldo
#      
#      # Probamos a caer en una sorpresa y a aplicar sorpresa después
#      @@juego.mover(2)
#      puts @@juego.mazo[0]
#      @@juego.aplicar_sorpresa
#      puts @@juego.jugador_actual.casillaActual
#      
#      # Probamos a hipotecar, cancelar hipoteca, vender, edificar casas y hoteles...
#      @@juego.mover(9)
#      @@juego.hipotecar_propiedad(@@juego.jugador_actual.casillaActual.numCasilla)
#      @@juego.cancelar_hipoteca(@@juego.jugador_actual.casillaActual.numCasilla)
#      @@juego.vender_propiedad(@@juego.jugador_actual.casillaActual.numCasilla)
#      @@juego.edificar_casa(@@juego.jugador_actual.casillaActual.numCasilla)
#      @@juego.edificar_hotel(@@juego.jugador_actual.casillaActual.numCasilla)
#      
##       Probamos a salir de la carcel
#      @@juego.jugador_actual.ir_a_carcel(tablero.carcel)
#      if(@@juego.jugador_actual.tengo_carta_libertad)
#        @@juego.intentar_salir_carcel(MetodoSalirCarcel::PAGANDOLIBERTAD)
#      else
#        consigue = @@juego.intentar_salir_carcel(MetodoSalirCarcel::TIRANDODADO)
#        
#        if consigue
#          puts "Sales de la cárcel"
#        else
#          puts "F"
#        end
#      end
#
#      puts @@juego.jugador_actual
#      @@juego.mover(13)
#      @@juego.comprar_titulo_propiedad
#      puts @@juego.jugador_actual.casillaActual.titulo.propietario
#      @@juego.siguiente_jugador
#      @@juego.mover(13)
#      puts @@juego.jugador_actual.casillaActual.titulo.alquilerB
#      puts @@juego.jugador_actual
#      
#      
#      
#      
#    end
#  end
#  
#  PruebaQytetet.main
#end