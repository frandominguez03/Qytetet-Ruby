# encoding: utf-8
# author: Francisco Domínguez

module ModeloQytetet
  class Jugador
    
    def initialize(nombre)
      @encarcelado = false
      @nombre = nombre
      @saldo = 7500
      @cartaLibertad = nil
      @casillaActual = nil
      @propiedades = nil
      @propietario = nil
    end
    
    attr_reader :nombre, :propiedades, :saldo
    attr_accessor :encarcelado, :cartaLibertad, :casillaActual
    
    protected
    def cancelar_hipoteca(titulo)
      
    end
    
    def comprar_titulo_propiedad
      
    end
    
    def cuantas_casas_hoteles_tengo
      
    end
    
    def debo_pagar_alquiler
      
    end
    
    def devolver_carta_libertad
      
    end
    
    def edificar_casa(titulo)
      
    end
    
    def edificar_hotel(titulo)
      
    end
    
    def eliminar_de_mis_propiedades(titulo)
      
    end
    
    def es_de_mi_propiedad(titulo)
      
    end
    
    def estoy_en_calle_libre
      
    end
    
    def hipotecar_propiedad(titulo)
      
    end
    
    def ir_a__carcel(casilla)
      
    end
    
    def modificar_saldo(cantidad)
      
    end
    
    def obtener_capital
      
    end
    
    def obtener_propiedades(hipotecada)
      
    end
    
    def pagar_alquiler
      
    end
    
    def pagar_impuesto
      
    end
    
    def pagar_libertad(cantidad)
      
    end
    
    def tengo_carta_libertad
      
    end
    
    def tengo_saldo(cantidad)
      
    end
    
    def vender_propiedad(casilla)
      
    end
    
    private :es_de_mi_propiedad, :eliminar_de_mis_propiedades, :tengo_saldo
  end
end
