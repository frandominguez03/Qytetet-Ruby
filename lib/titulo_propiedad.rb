# encoding: utf-8
# author: Francisco Domínguez.

module ModeloQytetet
  class TituloPropiedad
    
    def initialize(nombre, precioC, alquilerB, factorR, hipotecaB, precioE)
      @nombre = nombre
      @precioCompra = precioC
      @alquilerBase = alquilerB
      @factorRevalorizacion = factorR
      @hipotecaBase = hipotecaB
      @precioEdificar = precioE
      @hipotecada = false
      @numHoteles = 0
      @numCasas = 0
      @propietario = nil
      @propiedades = Array.new
    end
    
    attr_reader :nombre, :precioCompra, :alquilerBase, :factorRevalorizacion,
      :hipotecaBase, :precioEedificar, :numHoteles, :numCasas
    
    attr_accessor :hipotecada, :propietario
    
    protected
    def calcular_coste_cancelar
      
    end
    
    def calcular_coste_hipotecar
      
    end
    
    def calcular_importe_alquiler
      
    end
    
    def calcular_precio_venta
      
    end
    
    def cancelar_hipoteca
      
    end
    
    def cobrar_alquiler(coste)
      
    end
    
    def edificar_casa
      
    end
    
    def edificar_hotel
      
    end
    
    def hipotecar
      
    end
    
    def propietario_encarcelado
      
    end
    
    def tengo_propietario
      
    end
    
    def to_s
      "\n nombre: #{@nombre} \n precioCompra: #{@precioCompra} \n alquilerBase: #{@alquierBase} \n factorRevalorización: #{@factorRevalorizacion} \n hipotecaBase: #{@hipotecaBase} \n precioEdificar: #{@precioEdificar} \n hipotecada: #{@hipotecada} \n numHoteles: #{@numHoteles} \n numCasas: #{@numCasas}"
    end
  end
end
