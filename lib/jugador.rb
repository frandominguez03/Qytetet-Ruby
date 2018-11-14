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
      cancelar = false
      coste_cancelar = titulo.calcular_coste_cancelar
      
      if tengo_saldo(coste_cancelar)
        cancelar=true
        
        titulo.cancelar_hipoteca
      end
    
    return cancelar
    end
    
    def comprar_titulo_propiedad
      coste_compra = @casillaActual.coste
      comprado = false
      
      if coste_compra < @saldo
        titulo = @casillaActual.asignar_propietario(self)
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
      esdemipropiedad = es_de_mi_propiedad(titulo)
      
      if !esdemipropiedad
        tiene_propietario = titulo.tengo_propietario
      end
      
      if !esdemipropiedad && tiene_propietario
        encarc = titulo.propietario_encarcelado
      end
      
      if !esdemipropiedad && tiene_propietario && !encarc
        esta_hipotecada = titulo.hipotecada
      end
      
      debo_pagar = !esdemipropiedad && tiene_propietario && !encarc && !esta_hipotecada
      
      return debo_pagar
    end
    
    def devolver_carta_libertad
      intermedia = Sorpresa.new(@cartaLibertad.getTexto, @cartaLibertad.getValor, @cartaLibertad.getTipo)
      @cartaLibertad = nil
      return intermedia
    end
    
    def edificar_casa(titulo)
      num_casas = titulo.numCasas
      edificada = false
      
      if num_casas < 4
        hay_espacio = true
        coste_edificar_casa = titulo.precioEdificar
        tengosaldo = tengo_saldo(coste_edificar_casa)
        
        if tengosaldo && hay_espacio
          titulo.edificar_casa
          modificar_saldo(-coste_edificar_casa)
          edificada = true
        end
      end
      
      return edificada
    end
    
    def edificar_hotel(titulo)
    num_hoteles = titulo.numHoteles
    edificada=false
    
    if num_hoteles < 4
      coste_edificar_hotel=titulo.precioEdificar
      tengosaldo=tengo_saldo(coste_edificar_hotel)
      
      if tengosaldo
        titulo.edificar_hotel
        @jugadorActual.modificar_saldo(-coste_edificar_hotel)
        edificada=true
      end
    end
    return edificada
end
    
    def eliminar_de_mis_propiedades(titulo)
      titulo.propietario = nil
      precio_venta = titulo.calcular_precio_venta
      modificar_saldo(precio_venta)
    end
    
    def es_de_mi_propiedad(titulo)
      tiene = false
      
      for i in @propiedades
        if i == titulo
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
        puts i.precioCompra
        saldo_total = saldo_total + i.precioCompra + i.numCasas*i.precioEdificar
        + i.numHoteles*i.precioEdificar
        
        if i.hipotecada
          saldo_total = saldo_total - i.hipotecaBase
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
      resultado = false
      
      if @saldo > cantidad
        resultado = true
      end
      
      return resultado
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
