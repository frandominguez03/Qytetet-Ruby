# encoding: utf-8
require_relative "casilla"
require_relative "calle"
require_relative "titulo_propiedad"
require_relative "tipo_casilla"
module ModeloQytetet
  class Tablero
    
    def initialize
      inicializar
    end
    
    def self.new_casillas(casillas,carcel)
      @casillas = casillas
      @carcel=carcel
    end
    
    attr_reader :carcel, :casillas
    
    def to_s
      "Tablero: \n Casillas: #{@casillas} \n Carcel: #{@carcel}"
    end
    
    private
    def inicializar
      @casillas=Array.new
      titulos = Array.new
      contador = 0
      # Creamos primero todos los titulos de propiedad
     titulos << TituloPropiedad.new("Calle Willyrex", 625, 75, 12, 350, 400)
      titulos << TituloPropiedad.new("Calle Guerrero", 700, 50, 10, 550, 250)
      titulos << TituloPropiedad.new("Calle Cabronazi", 550, 80, 15, 600, 750)
      titulos << TituloPropiedad.new("Calle Giorgio", 890, 65, 13, 1000, 300)
      titulos << TituloPropiedad.new("Calle Picaporte", 740, 55, 19, 300, 575)
      titulos << TituloPropiedad.new("Calle Potter", 675, 60, 20, 475, 750)
      titulos << TituloPropiedad.new("Calle Petunia", 925, 90, 17, 875, 600)
      titulos << TituloPropiedad.new("Calle Motorola", 777, 85, 15, 750, 470)
      titulos << TituloPropiedad.new("Calle Focus", 830, 100, 16, 675, 500)
      titulos << TituloPropiedad.new("Calle Rengar", 900, 80, 12, 200, 450)
      titulos << TituloPropiedad.new("Calle Jesucristo", 1000, 60, 11, 250, 325)
      titulos << TituloPropiedad.new("Calle Ruby", 500, 95, 14, 175, 275)
      
      # Ahora creamos todas las casillas
      @casillas << Casilla.new(0,TipoCasilla::SALIDA, 1000)
      @casillas << Calle.new(1, titulos[0])
      @casillas << Casilla.new(2,TipoCasilla::SORPRESA, 0)
      @casillas << Calle.new(3, titulos[1])
      @casillas << Casilla.new(4,TipoCasilla::JUEZ, 0)
      @casillas << Calle.new( 5, titulos[2])
      @casillas << Casilla.new(6,TipoCasilla::PARKING, 0)
      @casillas << Calle.new(7, titulos[3])
      @casillas << Casilla.new(8,TipoCasilla::SORPRESA, 0)
      @casillas << Calle.new(9, titulos[4])
      @casillas << Calle.new(10, titulos[5])
      @casillas << Calle.new(11, titulos[6])
      @casillas << Casilla.new(12,TipoCasilla::IMPUESTO, 500)
      @casillas << Calle.new(13, titulos[7])
      @casillas << Casilla.new(14,TipoCasilla::CARCEL, 0)
      @carcel = @casillas[14]
      @casillas << Calle.new(15, titulos[8])
      @casillas << Casilla.new(16,TipoCasilla::SORPRESA, 0)
      @casillas << Calle.new(17, titulos[9])
      @casillas << Calle.new(18, titulos[10])
      @casillas << Calle.new(19, titulos[11])
      
    end
    
    public
    def es_casilla_carcel(numero_casilla)
      return @carcel.numCasilla==numero_casilla
      
    end
    
    def obtener_casilla_final(casilla,desplazamiento)
      return @casillas[(casilla.numCasilla+desplazamiento)%20]
    end
    
    def obtener_casilla_numero(numero_casilla)
      return @casillas[numero_casilla]
    end
  end
end
