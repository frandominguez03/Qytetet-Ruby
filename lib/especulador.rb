module ModeloQytetet
  class Especulador < Jugador
    attr_accessor :fianza
    def self.copia(unJugador, fianza)
      @fianza
      especulador = super(unJugador)
      especulador.fianza = fianza
      
      return especulador
    end
    
    
    def pagar_impuesto
      modificar_saldo(-casilla_actual.precioC/2)
    end
    
    def convertirme(fianza)
      return self
    end
    
    def debo_ir_a_carcel
      resultado = false
      
      if super && !pagar_fianza
        resultado = true
      end
      
      return resultado
    end
    
    
    def pagar_fianza
      puede_pagar = false
      
      if tengo_saldo(@fianza)
        modificar_saldo(-@fianza)
        puede_pagar = true
      end
      
      return puede_pagar
    end
    
    
    def puedo_edificar_casa(titulo)
      hay_espacio = titulo.numCasas < 8
      tengo_saldo = false
      
      if hay_espacio
        coste_edificar = titulo.precioEdificar
        tengo_saldo = super.tengo_saldo(coste_edificar)
      end
      
      return hay_espacio && tengo_saldo
    end
    
    def puedo_edificar_hotel(titulo)
      num_hoteles = titulo.numHoteles
      tengo_saldo = super.tengo_saldo(titulo.precioEdificar)
      
      return num_hoteles < 8 && tengo_saldo
    end
    
    def to_s
      return super + " \nFianza: #{@fianza}"
    end
    
    private:pagar_fianza
  end
end