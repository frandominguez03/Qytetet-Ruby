# encoding: utf-8
# author: Francisco Domínguez.

module ModeloQytetet
  class Tablero
    
    def initialize
      inicializar
    end
    
    attr_reader :carcel, :casillas
    
    def to_s
      "Tablero: \n Casillas: #{@casillas} \n Carcel: #{@carcel}"
    end
    
    def inicializar
      @casillas = Array.new
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
      @casillas << Casilla.new2(:SALIDA, 0)
      @casillas << Casilla.new(:CALLE, 1, titulos[contador])
      @casillas << Casilla.new2(:SORPRESA, 2)
      @casillas << Casilla.new(:CALLE, 3, titulos[contador+1])
      @casillas << Casilla.new2(:JUEZ, 4)
      @casillas << Casilla.new(:CALLE, 5, titulos[contador+1])
      @casillas << Casilla.new2(:PARKING, 6)
      @casillas << Casilla.new(:CALLE, 7, titulos[contador+1])
      @casillas << Casilla.new2(:SORPRESA, 8)
      @casillas << Casilla.new(:CALLE, 9, titulos[contador+1])
      @casillas << Casilla.new(:CALLE, 10, titulos[contador+1])
      @casillas << Casilla.new(:CALLE, 11, titulos[contador+1])
      @casillas << Casilla.new2(:IMPUESTO, 12)
      @casillas << Casilla.new(:CALLE, 13, titulos[contador+1])
      @casillas << Casilla.new2(:CARCEL, 14)
      @carcel = @casillas[14]
      @casillas << Casilla.new(:CALLE, 15, titulos[contador+1])
      @casillas << Casilla.new2(:SORPRESA, 16)
      @casillas << Casilla.new(:CALLE, 17, titulos[contador+1])
      @casillas << Casilla.new(:CALLE, 18, titulos[contador+1])
      @casillas << Casilla.new(:CALLE, 19, titulos[contador+1])
      
    end
    
    private :inicializar
  end
end
