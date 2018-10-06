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
      @mazo = Array.new
      @jugadores = Array.new
      @cartaActual = nil
      @jugadorActual = nil
      @dado = Dado.instance
      inicializar_tablero
    end

    attr_reader :mazo, :jugadores, :jugadorActual, :dado
    attr_accessor :cartaActual
    
    def to_s
      "Tablero: #{@tablero} \n Mazo: #{@mazo} \n cartaActual: #{@cartaActual}
       \n jugadorActual: #{@jugadorActual}"
    end
    
    protected
    def actuar_si_en_casilla_edificable
      
    end
    
    def actuar_si_en_casilla_no_edificable
      
    end
    
    public
    def aplicar_sorpresa
      
    end
    
    def cancelar_hipoteca(numeroCasilla)
      
    end
    
    def comprar_titulo_propiedad
      
    end
    
    def edificar_casa(numeroCasilla)
      
    end
    
    def edificar_hotel(numeroCasilla)
      
    end
    
    def encarcelar_jugador
      
    end
    
    def get_valor_dado
      
    end
    
    def hipotecar_propiedad(numeroCasilla)
      
    end

    def inicializar_cartas_sorpresa
      @mazo = Array.new

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
    end
    
    def inicializar_jugadores(nombres)
      for i in nombres.length
        nombres[i] = Jugador.new
      end
    end
    
    def inicializar_tablero
      @tablero = Tablero.new
    end
    
    def intentar_salir_carcel
      
    end
    
    def jugar
      
    end
    
    protected
    def mover(numCasillaDestino)
      
    end
    
    public
    def obtener_casilla_jugador_actual
      
    end
    
    def obtener_casillas_tablero
      
    end
    
    def obtener_propiedades_jugador
      
    end
    
    def obtener_propiedades_jugador_segun_estado_hipoteca(estadoHipoteca)
      
    end
    
    def obtener_ranking
      
    end
    
    def obtener_saldo_jugador_actual
      
    end
    
    def salida_jugadores
      
    end
    
    def set_carta_actual(cartaActual)
      
    end
    
    def siguiente_jugador
      
    end
    
    protected
    def tirar_dado
      
    end
    
    public
    def vender_propiedad(numeroCasilla)
      
    end
    
    private :encarcelar_jugador, :inicializar_jugadores,
      :inicializar_tablero, :salida_jugadores
  end
end