# encoding: utf-8
# author: Francisco Domínguez

require "singleton"

module ModeloQytetet
  class Qytetet
    include Singleton
    
    @@MAX_JUGADORES = 4
    @@NUM_SORPRESAS = 10
    @@NUM_CASILLAS = 20
    @@PRECIO_LIBERTAD = 200
    @@SALDO_SALIDA = 1000

    def initialize
      inicializar_tablero
      @mazo = Array.new
      @jugadores = Array.new
      @cartaActual
      @jugadorActual
      @dado = Dado.instance
      @estado
      @metodo
    end

    attr_reader :mazo, :dado
    attr_accessor :cartaActual, :jugadorActual, :jugadores
    
    def to_s
      "Tablero: #{@tablero} \n Mazo: #{@mazo.join("\n")} \n Jugadores: #{@jugadores.join("\n")} \n cartaActual: #{@cartaActual} \n jugadorActual: #{@jugadorActual}"
    end
    
    def actuar_si_en_casilla_edificable
      debo_pagar = @jugadorActual.debo_pagar_alquiler
      
      if debo_pagar
        @jugadorActual.pagar_alquiler
        
        if @jugadorActual.saldo <= 0
          @estado = EstadoJuego::ALGUNJUGADORENBANCARROTA
        end
      end
      
      casilla = obtener_casilla_jugador_actual
      tengo_propietario = casilla.tengo_propietario
      
      if @estado != EstadoJuego::ALGUNJUGADORENBANCARROTA
        if tengo_propietario
          @estado = EstadoJuego::JA_PUEDEGESTIONAR
          
        else
           @estado = EstadoJuego::JA_PUEDECOMPRAROGESTIONAR
        end
      end
      
    end
    
    def actuar_si_en_casilla_no_edificable
      @estado = EstadoJuego::JA_PUEDEGESTIONAR
      casilla_actual = @jugadorActual.casillaActual
      
      if casilla_actual.tipo == TipoCasilla::IMPUESTO
        @jugadorActual.pagar_impuesto
      else
        if casilla_actual.tipo == TipoCasilla::JUEZ
          encarcelar_jugador
        else
          if casilla_actual.tipo == TipoCasilla::SORPRESA
            @cartaActual = @mazo.at(0)
            @mazo.delete(0)
            @estado = EstadoJuego::JA_CONSORPRESA
          end
        end
      end
    end

    def aplicar_sorpresa
      @estado = EstadoJuego::JA_PUEDEGESTIONAR
      
      if @cartaActual.tipo == TipoSorpresa::SALIRCARCEL
        @jugadorActual.set_carta_libertad(@cartaActual)
        
      else
        @mazo.push(@cartaActual)
        
        case @cartaActual.tipo
        when TipoSorpresa::PAGARCOBRAR
          @jugadorActual.modificar_saldo(@cartaActual.valor)
          if
            @jugadorActual.saldo < 0
            @estado = EstadoJuego::ALGUNJUGADORENBANCARROTA
          end
        when TipoSorpresa::IRACASILLA
          valor = @cartaActual.valor
          casilla_carcel = @tablero.es_casilla_carcel(valor)
          
          if casilla_carcel
            encarcelar_jugador
          else
            mover(valor)
          end
        when TipoSorpresa::PORCASAHOTEL
          cantidad = @cartaActual.valor
          numero_total = @jugadorActual.cuantas_casas_hoteles_tengo
          @jugadorActual.modificar_saldo(cantidad*numero_total)
          
          if @jugadorActual.saldo < 0
            @estado = EstadoJuego::ALGUNJUGADORENBANCARROTA
          end
        when TipoSorpresa::PORJUGADOR
          for i in @@MAX_JUGADORES-1
            jugador = siguiente
            
            if jugador != @jugadorActual
              jugador.modificar_saldo(@cartaActual.valor)
            end
            
            if jugador.saldo < 0
              @estado = EstadoJuego::ALGUNJUGADORENBANCARROTA
            end
            
            @jugadorActual.modificar_saldo(-@cartaActual.valor)
            
            if @jugadorActual.saldo < 0
              @estado = EstadoJuego::ALGUNJUGADORENBANCARROTA
            end
          end
        end
      end
    end
    
    def cancelar_hipoteca(numeroCasilla)
      casilla = @tablero.obtener_casilla_numero(numeroCasilla)
      titulo = casilla.titulo
      cancelar = @jugadorActual.cancelar_hipoteca(titulo)
      @estado = EstadoJuego::JA_PUEDEGESTIONAR
return cancelar
    end
    
    def comprar_titulo_propiedad
      comprado = @jugadorActual.comprar_titulo_propiedad
      
      if comprado
        @estado = EstadoJuego::JA_PUEDEGESTIONAR
      end
    end
    
    def edificar_casa(numeroCasilla)
      casilla = @tablero.obtener_casilla_numero(numeroCasilla)
      titulo = casilla.titulo
      edificada = @jugadorActual.edificar_casa(titulo)
      
      if edificada
        @estado = EstadoJuego::JA_PUEDEGESTIONAR 
      end
    end
    
    def edificar_hotel(numeroCasilla)
      
    end
    
    def encarcelar_jugador
      if !@jugadorActual.tengo_carta_libertad
        casilla_carcel = @tablero.carcel
        @jugadorActual.ir_a_carcel(casilla_carcel)
        @estado = EstadoJuego::JA_ENCARCELADO
      else
        carta = @jugadorActual.devolver_carta_libertad
        @mazo.push(carta)
        @estado = EstadoJuego::JA_PUEDEGESTIONAR
      end
    end
    
    def get_valor_dado
      @dado.valor
    end
    
    def hipotecar_propiedad(numeroCasilla)
      casilla = @tablero.obtener_casilla_numero(numeroCasilla)
      titulo = casilla.titulo
      @jugadorActual.hipotecar_propiedad(titulo)
      @estado = EstadoJuego::JA_PUEDEGESTIONAR
    end

    def inicializar_cartas_sorpresa
      @mazo << Sorpresa.new("Te han pillado saqueando las arcas públicas del estado, vas a la cárcel.", @tablero.carcel.numeroCasilla, TipoSorpresa::IRACASILLA)
      @mazo << Sorpresa.new("No sabemos si estabas cerca de la casilla inicial o no, pero ahora lo vas a estar.", 1, TipoSorpresa::IRACASILLA)
      @mazo << Sorpresa.new("¿Eres supersticioso?", 13, TipoSorpresa::IRACASILLA)
      @mazo << Sorpresa.new("Resulta que un funcionario de la cárcel es amigo tuyo. De casualidades está hecha la vida. Sales de la cárcel.", 0, TipoSorpresa::SALIRCARCEL)
      @mazo << Sorpresa.new("Tus rivales te odian tanto que les obligamos a que te den lo que lleven suelto en la cartera.", 200, TipoSorpresa::PORJUGADOR)
      @mazo << Sorpresa.new("Parece que te está gustando el juego, por eso tendrás que recompensar a tus rivales.", -300, TipoSorpresa::PORJUGADOR)
      @mazo << Sorpresa.new("¡Enhorabuena! Te ha tocado la lotería, pero la agencia tributaria se va a quedar casi todo.", 250, TipoSorpresa::PAGARCOBRAR)
      @mazo << Sorpresa.new("Vamos a jugar a algo, tú me das algo de dinero y yo no te doy nada. ¿Qué te parece?", -250, TipoSorpresa::PAGARCOBRAR)
      @mazo << Sorpresa.new("Vaya, esta sorpresa parece que te va a quitar algo de dinero por los hoteles y casas de tus rivales, siempre y cuando tú estés de acuerdo... o no.", -150, TipoSorpresa::PORCASAHOTEL)
      @mazo << Sorpresa.new("Estás de suerte. Tus propiedades acaban de evadir impuestos y te dan algo más de dinero extra.", 200, TipoSorpresa::PORCASAHOTEL)
    end
    
    def inicializar_juego(nombres)
            inicializar_tablero
            inicializar_cartas_sorpresa
            inicializar_jugadores(nombres)
            salida_jugadores
    end
    
    def inicializar_jugadores(nombres)    
      for nombre in nombres
        @jugadores << Jugador.new(nombre)
      end
    end
    
    def inicializar_tablero
      @tablero = Tablero.new
    end
    
    def intentar_salir_carcel(metodo)
      if metodo == MetodoSalirCarcel::TIRANDODADO
        puts "Tirando dado..."
        resultado = tirar_dado
        puts "El resultado es: #{resultado}"
        
        if resultado >= 5
          @jugadorActual.encarcelado = false
        end
      else
        if metodo == MetodoSalirCarcel::PAGANDOLIBERTAD
          @jugadorActual.pagar_libertad(@@PRECIO_LIBERTAD)
        end
      end
      
      encarcelado = @jugadorActual.encarcelado
      
      if encarcelado
        @estado = EstadoJuego::JA_ENCARCELADO
      else
        @estado = EstadoJuego::JA_PREPARADO
      end
      
      return encarcelado
    end
    
    def jugar
      tirar_dado
      casilla_final = @tablero.obtener_casilla_final(@casillaActual)
      mover(casilla_final)
    end
    
    def mover(numCasillaDestino)
      casilla_inicial = @jugadorActual.casillaActual
      casilla_final = @tablero.obtener_casilla_numero(numCasillaDestino)
      @jugadorActual.casillaActual = casilla_final
      
      if numCasillaDestino < casilla_inicial.numeroCasilla
        @jugadorActual.modificar_saldo(@@SALDO_SALIDA)
      end
      
      if casilla_final.soy_edificable
        actuar_si_en_casilla_edificable
      else
        actuar_si_en_casilla_no_edificable
      end
    end
    
    def obtener_casilla_jugador_actual
      return @jugadorActual.casillaActual
    end
    
    def obtener_casillas_tablero
      return @tablero.casillas
    end
    
    def obtener_propiedades_jugador
      propiedades = Array.new
      
      for i in @jugadorActual.propiedades
        nombre = i.nombre
        
        if i.titulo.nombre == nombre
          propiedades << i.numeroCasilla
        end
      end
      
      return propiedades
    end
    
    def obtener_propiedades_jugador_segun_estado_hipoteca(estadoHipoteca)
      propiedades = Array.new
      
      for i in @jugadorActual.propiedades
        if @jugadorActual.propiedades[i].hipotecada == estadoHipoteca
          nombre = @jugadorActual.propiedades[i].nombre
          
          if o.titulo.nombre == nombre
          propiedades << o.numeroCasilla
          end
        end
      end
      
      return propiedades
    end
    
    def obtener_ranking
      @jugadores=@jugadores.sort
    end
    
    def obtener_saldo_jugador_actual
      @jugadorActual.saldo
    end
    
    def salida_jugadores
      r=Random.new()
      
      for i in @jugadores
        i.casillaActual = @tablero.obtener_casilla_numero(0)
      end
      
      indice = r.rand(@jugadores.size)
      @jugadorActual = @jugadores[indice]
      @estado = EstadoJuego::JA_PREPARADO
    end
    
    def set_carta_actual(cartaActual)
      
    end
    
    def siguiente_jugador
      indice = @jugadores.index(@jugadorActual)
      @jugadorActual = @jugadores.at((indice+1)%@jugadores.size)
      
      if @jugadorActual.encarcelado
        @estado = EstadoJuego::JA_ENCARCELADOCONOPCIONDELIBERTAD
        intentar_salir_carcel(MetodoSalirCarcel::TIRANDODADO)
        intentar_salir_carcel(MetodoSalirCarcel::PAGANDOLIBERTAD)
        
      else
        @estado = EstadoJuego::JA_PREPARADO
      end
      
    end
    
    def tirar_dado
      @dado.tirar
    end
    
    def vender_propiedad(numeroCasilla)
      casilla = @tablero.obtener_casilla_numero(numeroCasilla)
      @jugadorActual.vender_propiedad(casilla)
      
    end
    
    private :encarcelar_jugador, :salida_jugadores
  end
end