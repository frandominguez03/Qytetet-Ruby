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
      :hipotecaBase, :precioEdificar, :numHoteles, :numCasas
    
    attr_accessor :hipotecada, :propietario
    
    protected
    def calcular_coste_cancelar
      
    end
    
    def calcular_coste_hipotecar
      return @hipotecaBase + @numCasas*0.5*@hipotecaBase + @numHoteles*hipotecaBase
    end
    
    def calcular_importe_alquiler
      return @alquilerBase + (@numCasas*0.5 + @numHoteles*2)
    end
    
    def calcular_precio_venta
      return @precioCompra + (@numCasas+@numHoteles) * @precioEdificar  * @factorRevalorizacion
    end
    
    def cancelar_hipoteca
      
    end
    
    def cobrar_alquiler(coste)
      
    end
    
    def edificar_casa
      @numCasas = @numCasas+1
    end
    
    def edificar_hotel
      
    end
    
    def hipotecar
      coste_hipoteca = calcular_coste_hipotecar
      @hipotecada = true
      
      return coste_hipoteca
    end
    
    def pagar_alquiler
      coste_alquiler = calcular_importe_alquiler
      @propietario.modificar_saldo(coste_alquiler)
      
      return coste_alquiler
    end
    
    def propietario_encarcelado
      return @propietario.encarcelado
    end
    
    def tengo_propietario
      return @propietario != nil
    end
    
    def to_s
      "\n nombre: #{@nombre} \n precioCompra: #{@precioCompra} \n alquilerBase: #{@alquierBase} \n factorRevalorización: #{@factorRevalorizacion} \n hipotecaBase: #{@hipotecaBase} \n precioEdificar: #{@precioEdificar} \n hipotecada: #{@hipotecada} \n numHoteles: #{@numHoteles} \n numCasas: #{@numCasas}"
    end
  end
end
