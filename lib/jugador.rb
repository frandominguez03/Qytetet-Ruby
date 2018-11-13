# encoding: utf-8
# author: Francisco Domínguez

module ModeloQytetet
  class Jugador
    
    def initialize(nombre)
      @encarcelado = false
      @nombre = nombre
      @saldo = 7500
      @cartaLibertad = nil
      @casillaActual = 0
      @propiedades = Array.new
    end
    
    attr_reader :nombre, :propiedades, :saldo
    attr_accessor :encarcelado, :cartaLibertad, :casillaActual
    
    def cancelar_hipoteca(titulo)
      
    end
    
    def comprar_titulo_propiedad
      coste_compra = @casillaActual.coste
      comprado = false
      
      if coste_compra < @saldo
        titulo = @casillaActual.asignar_propietario(@jugadorActual)
        @propiedades.push(titulo)
        modificar_saldo(-coste_compra)
        comprado = true
      end
      
      return comprado
    end
    
    def cuantas_casas_hoteles_tengo
      contador = 0
      
      for i in @propiedades.size
         contador = contador + @propiedades[i].getNumCasas + @propiedades[i].getNumHoteles
      end
      
      return contador
    end
    
    def debo_pagar_alquiler
      titulo = @casillaActual.titulo
      es_de_mi_propiedad = es_de_mi_propiedad(titulo)
      
      if !es_de_mi_propiedad && titulo.tengo_propietario
        tiene_propietario = true
      end
      
      if !es_de_mi_propiedad && tiene_propietario
        encarc = titulo.propietario_encarcelado
      end
      
      if !es_de_mi_propiedad && tiene_propietario && !encarc
        esta_hipotecada = titulo.hipotecada
      end
      
      return !es_de_mi_propiedad && tiene_propietario && !encarc && !esta_hipotecada
    end
    
    def devolver_carta_libertad
      intermedia = Sorpresa.new(@cartaLibertad.getTexto, @cartaLibertad.getValor, @cartaLibertad.getTipo)
      @cartaLibertad = nil
      return intermedia
    end
    
    def edificar_casa(titulo)
      num_casas = titulo.numCasas
      
      if num_casas < 4
        hay_espacio = true
        coste_edificar_casa = titulo.precioEdificar
        tengo_saldo = tengo_saldo(coste_edificar_casa)
        
        if tengo_saldo
          titulo.edificar_casa
          @jugadorActual.modificar_saldo(-coste_edificar_casa)
          edificada = true
        end
      end
      
      return hay_espacio && tengo_saldo
    end
    
    def edificar_hotel(titulo)
      
    end
    
    def eliminar_de_mis_propiedades(titulo)
      titulo.propietario = nil
      precio_venta = titulo.calcular_precio_venta
      modificar_saldo(precio_venta)
    end
    
    def es_de_mi_propiedad(titulo)
      tiene = false
      
      for i in @propiedades
        if @propiedades[i].getTitulo == titulo
          tiene = true
        end
      end
      
      return tiene
    end
    
    def estoy_en_calle_libre
      
    end
    
    def hipotecar_propiedad(titulo)
      coste_hipoteca = titulo.hipotecar
      modificar_saldo(coste_hipoteca)
    end
    
    def get_casilla_actual
      return @casillaActual
    end
    
    def ir_a_carcel(casilla)
      @casillaActual = casilla
      @encarcelado = true
    end
    
    def modificar_saldo(cantidad)
      @saldo = @saldo + cantidad
    end
    
    def obtener_capital
      saldo_total = 0
      
      for i in @propiedades
        saldo_total = saldo_total + i.getPrecioCompra + i.getNumCasas*i.getPrecioEdificar
        + i.getNumHoteles*i.getPrecioEdificar
        
        if i.getHipotecada
          saldo_total = saldo_total - i.getHipotecaBase
        end
        
      end
      
      return saldo_total
    end
    
    def obtener_propiedades(hipotecada)
      propiedades = Array.new
      
      for i in @propiedades
        if @propiedades[i].getHipotecada == hipotecada
          propiedades << @propiedades[i]
        end
      end
      
      return propiedades
    end
    
    def pagar_alquiler
      coste_alquiler = @casillaActual.pagar_alquiler
      modificar_saldo(-coste_alquiler)
    end
    
    def pagar_impuesto
      
    end
    
    def pagar_libertad(cantidad)
      tengo_saldo = tengo_saldo(cantidad)
      
      if tengo_saldo
        @encarcelado == false
        modificar_saldo(-cantidad)
      end
    end
    
    def tengo_carta_libertad
      return @cartaLibertad != nil
    end
    
    def tengo_saldo(cantidad)
      return @saldo > cantidad
    end
    
    def vender_propiedad(casilla)
      titulo = casilla.titulo
      @propiedades.delete(titulo)
      eliminar_de_mis_propiedades(titulo)
      
    end
    
    def to_s
      "Jugador: #{@nombre} \n capital: #{obtener_capital} \n encarcelado: #{@encarcelado} \n propiedades: #{@propiedades} \n saldo: #{@saldo} \n casillaActual: #{@casillaActual}"
    end
    
    def <=>(otroJugador)
      otro_capital = otroJugador.obtener_capital
      mi_capital = obtener_capital
      
      if (otro_capital>mi_capital)
        return 1 end
      
      if (otro_capital<mi_capital)
        return -1 end
      
      return 0
  end
    
    private :es_de_mi_propiedad, :eliminar_de_mis_propiedades, :tengo_saldo
  end
end
