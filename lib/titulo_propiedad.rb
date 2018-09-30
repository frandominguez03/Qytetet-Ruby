# encoding: utf-8
# author: Francisco Domínguez.

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
    end
    
    attr_reader :nombre, :precioC, :alquilerB, :factorB,
      :hipotecaB, :precioE, :numHoteles, :numCasas
    
    attr_accessor :hipotecada
    
    def to_s
      "nombre: #{@nombre} \n precioCompra: #{@precioC} \n alquilerBase: #{@alquierB} \n
      factorRevalorización: #{@factorR} \n hipotecaBase: #{@hipotecaB} \n precioEdificar: #{@precioE} \n
      hipotecada: #{@hipotecada} \n numHoteles: #{@numHoteles} \n numCasas: #{@numCasas}"
    end
  end
end
