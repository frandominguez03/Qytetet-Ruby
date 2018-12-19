# encoding: utf-8

require "singleton"
require_relative "qytetet"
require_relative 'opcion_menu'
require_relative "estado_juego"
require_relative"metodo_salir_carcel"

module ControladorQytetet
  class ControladorQytetet
    include Singleton
    
    @@modelo=ModeloQytetet::Qytetet.instance
    def initialize
    @nombre_jugadores = Array.new 
    end
    
    attr_accessor :nombre_jugadores
    
    def obtener_operaciones_juego_validas()
      lista= Array.new
      
      if @@modelo.jugadores.empty?
        lista<<OpcionMenu.index(:INICIARJUEGO)
      else
      case @@modelo.estado
      when ModeloQytetet::EstadoJuego::JA_CONSORPRESA
        lista<<OpcionMenu.index(:APLICARSORPRESA)
        lista<<OpcionMenu.index(:MOSTRARJUGADORACTUAL)
        lista<<OpcionMenu.index(:MOSTRARJUGADORES)
        lista<<OpcionMenu.index(:MOSTRARTABLERO)
        lista<<OpcionMenu.index(:TERMINARJUEGO)
      when ModeloQytetet::EstadoJuego::JA_PREPARADO
        lista<<OpcionMenu.index(:JUGAR)
        lista<<OpcionMenu.index(:MOSTRARJUGADORACTUAL)
        lista<<OpcionMenu.index(:MOSTRARJUGADORES)
        lista<<OpcionMenu.index(:MOSTRARTABLERO)
        lista<<OpcionMenu.index(:TERMINARJUEGO)
      when ModeloQytetet::EstadoJuego::JA_PUEDEGESTIONAR
        lista<<OpcionMenu.index(:PASARTURNO)
        lista<<OpcionMenu.index(:MOSTRARJUGADORACTUAL)
        lista<<OpcionMenu.index(:MOSTRARJUGADORES)
        lista<<OpcionMenu.index(:MOSTRARTABLERO)
        lista<<OpcionMenu.index(:TERMINARJUEGO)
        if !@@modelo.obtener_propiedades_jugador.empty?
          lista<<OpcionMenu.index(:EDIFICARCASA)
          lista<<OpcionMenu.index(:EDIFICARHOTEL)
          lista<<OpcionMenu.index(:HIPOTECARPROPIEDAD)
          lista<<OpcionMenu.index(:VENDERPROPIEDAD)
          if !@@modelo.obtener_propiedades_jugador_segun_estado_hipoteca(true).empty?
            lista<<OpcionMenu.index(:CANCELARHIPOTECA)
          end
        end
      when ModeloQytetet::EstadoJuego::JA_PUEDECOMPRAROGESTIONAR
        lista<<OpcionMenu.index(:PASARTURNO)
        lista<<OpcionMenu.index(:MOSTRARJUGADORACTUAL)
        lista<<OpcionMenu.index(:MOSTRARJUGADORES)
        lista<<OpcionMenu.index(:MOSTRARTABLERO)
        lista<<OpcionMenu.index(:TERMINARJUEGO)
        lista<<OpcionMenu.index(:COMPRARTITULOPROPIEDAD)
        if !@@modelo.obtener_propiedades_jugador.empty?
          lista<<OpcionMenu.index(:EDIFICARCASA)
          lista<<OpcionMenu.index(:EDIFICARHOTEL)
          lista<<OpcionMenu.index(:HIPOTECARPROPIEDAD)
          lista<<OpcionMenu.index(:VENDERPROPIEDAD)
          if !@@modelo.obtener_propiedades_jugador_segun_estado_hipoteca(true).empty?
            lista<<OpcionMenu.index(:CANCELARHIPOTECA)
          end
        end
      when ModeloQytetet::EstadoJuego::ALGUNJUGADORENBANCARROTA
        lista<<OpcionMenu.index(:MOSTRARJUGADORACTUAL)
        lista<<OpcionMenu.index(:MOSTRARJUGADORES)
        lista<<OpcionMenu.index(:MOSTRARTABLERO)
        lista<<OpcionMenu.index(:TERMINARJUEGO)
      when ModeloQytetet::EstadoJuego::JA_ENCARCELADO
        lista<<OpcionMenu.index(:PASARTURNO)
        lista<<OpcionMenu.index(:MOSTRARJUGADORACTUAL)
        lista<<OpcionMenu.index(:MOSTRARJUGADORES)
        lista<<OpcionMenu.index(:MOSTRARTABLERO)
        lista<<OpcionMenu.index(:TERMINARJUEGO)
      when ModeloQytetet::EstadoJuego::JA_ENCARCELADOCONOPCIONDELIBERTAD
        lista<<OpcionMenu.index(:MOSTRARJUGADORACTUAL)
        lista<<OpcionMenu.index(:MOSTRARJUGADORES)
        lista<<OpcionMenu.index(:MOSTRARTABLERO)
        lista<<OpcionMenu.index(:TERMINARJUEGO)
        lista<<OpcionMenu.index(:INTENTARSALIRCARCELPAGANDOLIBERTAD)
        lista<<OpcionMenu.index(:INTENTARSALIRCARCELTIRANDODADO)
        end
      end
      return lista
    end
    def necesita_elegir_casilla(opcion_menu)
      necesita_elegir = false
      if (opcion_menu == OpcionMenu.index(:HIPOTECARPROPIEDAD) || opcion_menu == OpcionMenu.index(:CANCELARHIPOTECA) || 
          opcion_menu == OpcionMenu.index(:EDIFICARCASA) || opcion_menu == OpcionMenu.index(:EDIFICARHOTEL) || 
          opcion_menu == OpcionMenu.index(:VENDERPROPIEDAD)) 
          necesita_elegir = true
      end
        return necesita_elegir
    end
    def obtener_casillas_validas(opcion_menu)
      casillas_validas=Array.new
      if opcion_menu == OpcionMenu.index(:HIPOTECARPROPIEDAD)
        casillas_validas=@@modelo.obtener_propiedades_jugador
      else
        if opcion_menu == OpcionMenu.index(:VENDERPROPIEDAD)
          casillas_validas=@@modelo.obtener_propiedades_jugador
        else
          if opcion_menu == OpcionMenu.index(:CANCELARHIPOTECA)
            casillas_validas=@@modelo.obtener_propiedades_jugador_segun_estado_hipoteca(true)
          else
            if opcion_menu == OpcionMenu.index(:EDIFICARCASA)
              casillas_validas=@@modelo.obtener_propiedades_jugador
            else
              if opcion_menu == OpcionMenu.index(:EDIFICARHOTEL)
                casillas_validas=@@modelo.obtener_propiedades_jugador
              end
            end
          end
        end
      end

      return casillas_validas
    end
    
    def realizar_operacion(opcion_elegida, casilla_elegida)
      case opcion_elegida
      when OpcionMenu.index(:INICIARJUEGO) #INICIAR JUEGO
        resultado = "Inicializando juego"
        @@modelo.inicializar_juego(@nombre_jugadores)
      when OpcionMenu.index(:JUGAR) #JUGAR
        @@modelo.jugar
        resultado=@@modelo.dado.to_s + ". Casilla actual " + @@modelo.jugador_actual.casillaActual.to_s
      when OpcionMenu.index(:APLICARSORPRESA) #APLICAR SORPRESA
        @@modelo.aplicar_sorpresa
        resultado="La sorpresa es " + @@modelo.carta_actual.to_s
      when OpcionMenu.index(:INTENTARSALIRCARCELPAGANDOLIBERTAD) #INTENTAR SALIR CARCEL PAGANDO LIBERTAD
        salido=@@modelo.intentar_salir_carcel(ModeloQytetet::MetodoSalirCarcel::PAGANDOLIBERTAD)
        if salido
          resultado = "Te has caido con las prisas y no has conseguido escapar.Además de pobre eres topre"
        else
          resultado = "¡Has salido de soto del real pagando suciamente"
        end
      when OpcionMenu.index(:INTENTARSALIRCARCELTIRANDODADO) #INTENTAR SALIR CARCEL TIRANDO DADO  
        salido = @@modelo.intentar_salir_carcel(ModeloQytetet::MetodoSalirCarcel::TIRANDODADO)
        if salido
          resultado = "Te has caido con las prisas y no has conseguido escapar. Te han echado mal de ojo"
        else
          resultado = "¡Has salido de soto del real. la suerte está de tu lado."
        end
      when OpcionMenu.index(:COMPRARTITULOPROPIEDAD)#COMPRAR TITULO PROPIEDAD
        comprado=@@modelo.comprar_titulo_propiedad
        if comprado
          resultado = "Enhorabuena ahora tienes una propiedad más"
        else
          resultado = "Lo sentimos pero no tiene usted suficiente cash"
        end
      when OpcionMenu.index(:HIPOTECARPROPIEDAD) #HIPOTECAR PROPIEDAD
        @@modelo.hipotecar_propiedad(casilla_elegida)
        resultado = "Ha hipotecado usted su propiedad"
      when OpcionMenu.index(:CANCELARHIPOTECA) #CANCELAR HIPOTECA
        cancelada = @@modelo.cancelar_hipoteca(casilla_elegida)
        if cancelada
          resultado = "Ha logrado deshacerse de esa birria"
        else
          resultado = "Mala suerte, tendrá que seguir pagando a Hacienda"
        end
      when OpcionMenu.index(:EDIFICARCASA) #EDIFICAR CASA
        edificada=@@modelo.edificar_casa(casilla_elegida)
        if edificada
          resultado = "Ha construido usted una preciosa casita"
        else
          resultado = "Tendrás que seguir acostumbrado a la tienda de campaña"
        end
      when OpcionMenu.index(:EDIFICARHOTEL) #EDIFICAR HOTEL
        edificada = @@modelo.edificar_hotel(casilla_elegida)
        if edificada
          resultado = "Hotel construido, ¡se ve desde la estacion espacial!"
        else
          resultado = "Hotel no construido, el arquitecto te ha devuelto los papeles"
        end
      when OpcionMenu.index(:VENDERPROPIEDAD) #VENDER PROPIEDAD
        @@modelo.vender_propiedad(casilla_elegida)
        resultado = "Has vendido la propiedad. Espero que te acordaras de coger al gato"
      when OpcionMenu.index(:PASARTURNO) #PASAR TURNO
        @@modelo.siguiente_jugador
        resultado = "Cambio de jugador, turno de "+ @@modelo.jugador_actual.nombre
      when OpcionMenu.index(:OBTENERRANKING) #OBTENER RANKING
        @@modelo.obtener_ranking
        resultado = "Imprimiendo el ranking de los jugadores"
      when OpcionMenu.index(:MOSTRARJUGADORACTUAL) #MOSTRAR JUGADOR ACTUAL
        puts @@modelo.jugador_actual.to_s
      when OpcionMenu.index(:MOSTRARJUGADORES) #MOSTRAR JUGADORES
        puts @@modelo.jugadores.to_s
      when OpcionMenu.index(:MOSTRARTABLERO) #MOSTRAR TABLERO
        puts @@modelo.tablero.to_s
      when OpcionMenu.index(:TERMINARJUEGO) #TERMINAR JUEGO
        resultado = "Cerrando juego"
        @@modelo.obtener_ranking
        puts @@modelo.jugadores.to_s
        exit(0)
      end
    end
end
  end

