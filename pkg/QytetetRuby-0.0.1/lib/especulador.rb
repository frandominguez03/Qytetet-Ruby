# encoding: utf-8
# author: Francisco Domínguez

module ModeloQytetet
  class Especulador < Jugador
    def self.copia(unJugador, fianza)
      @fianza = fianza
      super(unJugador)
    end
    
    protected
    def pagar_impuesto
      this.saldo = super/2;
    end
    
    def convertirme
      return this
    end
    
    def debo_ir_a_carcel
      resultado = false
      
      if super && !pagar_fianza
        resultado = true
      end
      
      return resultado
    end
    
    private
    def pagar_fianza
      puede_pagar = false
      
      if this.saldo > this.fianza
        this.saldo = saldo-fianza
        puede_pagar = true
      end
      
      return puede_pagar
    end
    
    protected
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
      return super + " Especulador: #{@fianza}"
    end
  end
end
