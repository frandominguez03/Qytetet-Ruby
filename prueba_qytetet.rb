# encoding: utf-8
# author: Francisco Domínguez.

module ModeloQytetet
  class PruebaQytetet
    juego = Qytetet.new()
  
    def self.main
      Qytetet.inicializarCartasSorpresa()
    end
  end
end