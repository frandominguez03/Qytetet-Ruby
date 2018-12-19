# encoding: utf-8

module ModeloQytetet
  class Sorpresa

    def initialize(nuevo_texto, nuevo_valor,  nuevo_tipo)
      @texto = nuevo_texto
      @tipo = nuevo_tipo
      @valor = nuevo_valor
    end
    attr_reader :texto, :valor, :tipo

    def to_s
      "Texto: #{@texto} \n Valor: #{@valor} \n Tipo: #{@tipo}"
    end
  end
end