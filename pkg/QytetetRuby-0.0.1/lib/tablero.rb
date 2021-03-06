# encoding: utf-8
# author: Francisco Domínguez.

module ModeloQytetet
  class Tablero
    
    def initialize
      @casillas = Array.new
      inicializar
    end
    
    def to_s
      "Tablero: \n Casillas: #{@casillas.join("\n")} \n Carcel: #{@carcel}"
    end
    
    attr_reader :carcel, :casillas

    def es_casilla_carcel(numeroCasilla)
      return numeroCasilla == @carcel;
    end
    
    def inicializar
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
      @casillas << Casilla.new(TipoCasilla::SALIDA, 0, 1000)
      @casillas << Calle.new(1, titulos[contador])
      @casillas << Casilla.new(TipoCasilla::SORPRESA, 2, 0)
      @casillas << Calle.new(3, titulos[contador+=1])
      @casillas << Casilla.new(TipoCasilla::JUEZ, 4, 0)
      @casillas << Calle.new( 5, titulos[contador+=1])
      @casillas << Casilla.new(TipoCasilla::PARKING, 6, 0)
      @casillas << Calle.new(7, titulos[contador+=1])
      @casillas << Casilla.new(TipoCasilla::SORPRESA, 8, 0)
      @casillas << Calle.new(9, titulos[contador+=1])
      @casillas << Calle.new(10, titulos[contador+=1])
      @casillas << Calle.new(11, titulos[contador+=1])
      @casillas << Casilla.new(TipoCasilla::IMPUESTO, 12, 0)
      @casillas << Calle.new(13, titulos[contador+=1])
      @casillas << Casilla.new(TipoCasilla::CARCEL, 14, 0)
      @carcel = @casillas[14]
      @casillas << Calle.new(15, titulos[contador+=1])
      @casillas << Casilla.new(TipoCasilla::SORPRESA, 16, 0)
      @casillas << Calle.new(17, titulos[contador+=1])
      @casillas << Calle.new(18, titulos[contador+=1])
      @casillas << Calle.new(19, titulos[contador+=1])
      
    end
    
    def obtener_casilla_final(casilla, desplazamiento)
      return @casillas[casilla+desplazamiento]%20;
    end
    
    def obtener_casilla_numero(numeroCasilla)
      return @casillas[numeroCasilla];
    end
    
    private :inicializar
  end
end
