# encoding: utf-8

module ModeloQytetet
  class TituloPropiedad
    
    def initialize(nombre, precioC, alquilerB, factorR, hipotecaB, precioE)
      @nombre = nombre
      @precioC = precioC
      @alquilerB = alquilerB
      @factorR = factorR
      @hipotecaB = hipotecaB
      @precioE = precioE
      @hipotecada = false
      @numHoteles = 0
      @numCasas = 0
      @propietario=nil
    end
    
    attr_reader :nombre, :precioC, :alquilerB, :factorB,
      :hipotecaB, :precioE, :numHoteles, :numCasas
    
    attr_accessor :hipotecada,:propietario
    
    def to_s
      "nombre: #{@nombre} \n precioCompra: #{@precioC} \n alquilerB: #{@alquierB} \n
      factorRevalorización: #{@factorR} \n hipotecaBase: #{@hipotecaB} \n precioEdificar: #{@precioE} \n
      hipotecada: #{@hipotecada} \n numHoteles: #{@numHoteles} \n numCasas: #{@numCasas}"
    end
    
    public
    def calcular_coste_cancelar
      coste_cancelar=0
      coste_cancelar=calcular_coste_hipotecar + calcular_coste_hipotecar*0.1
      return coste_cancelar
      
    end
    
    def calcular_coste_hipotecar
      coste_hipotecar=0
      coste_hipotecar=@hipotecaB + @numCasas*0.5*@hipotecaB + @numHoteles*@hipotecaB
      return coste_hipotecar
    end
    
    def calcular_importe_alquiler
      coste_alquiler=0
      coste_alquiler=@alquilerB+ @numHoteles*0.5 + @numCasas*0.2
      @propietario.modificar_saldo(coste_alquiler)
      return coste_alquiler
    end
    
    def calcular_precio_venta
      coste_venta=0
      coste_venta=@precioC+(@numCasas+@numHoteles)*@precioE*@factorR
      return coste_venta
    end
    
    def cancelar_hipoteca
      @hipotecada=false
    end
    
    def edificar_casa
      @numCasas=@numCasas+1
    end
    
    def edificar_hotel    
      @numHoteles=@numHoteles+1
      @numCasas = @numCasas - 4
    end
    
    def hipotecar
      coste_hipoteca=calcular_coste_hipotecar    
      @hipotecada=true
      return coste_hipoteca
    end
    
    def pagar_alquiler
      coste_alquiler=calcular_importe_alquiler
      @propietario.modificar_saldo(coste_alquiler)
      return coste_alquiler
    end
    
    def propietario_encarcelado
      resultado=false
      if @propietario.encarcelado
        resultado=true
      end
      return resultado
    end
    
    def tengo_propietario
      return @propietario!=nil
    end
  end
end
