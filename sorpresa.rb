# encoding: utf-8
# author: Francisco Domínguez.

class Sorpresa
  attr_reader :texto, :tipo, :valor
  
  def initialize(nuevo_texto, nuevo_valor,  nuevo_tipo)
    @texto = nuevo_texto
    @tipo = nuevo_tipo
    @valor = nuevo_valor
  end
  
  def to_s
    "Texto: #{@texto} \n Valor: #{@valor} \n Tipo: #{@tipo}"
  end
end