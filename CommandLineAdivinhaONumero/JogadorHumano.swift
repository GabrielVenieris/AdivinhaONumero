//
//  JogadorHumano.swift
//  CommandLineAdivinhaONumero
//
//  Created by Ricardo Venieris on 29/03/22.
//




class JogadorHumano:Jogador {
    
    /**
     Lê uma numérica válida do console, de acordo com a regra do jogo e retorna um número.
     */
    private func leEntradaInt()->Int {
        
        var valor:Int = -1
        
        while valor == -1 {
            guard let valorTxt = readLine(),
                  let conveInt = Int(valorTxt),
                  self.gameRange.contains(conveInt) else {
                      print("escolha inválida, tente novamente")
                      continue
                  }
            valor = conveInt
        }
        return valor
    }
    
    /**
     Implementação Humana do método, perguntando ao usuário qual o númer a ser adivinhado.
     */
    override func escolheNumero() {
        print("\(nome), escolha um numero entre '\(gameRange.lowerBound)' e '\(gameRange.upperBound)' para ser adivinhado")
        numeroEscolhido = leEntradaInt()
        
        print("\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n")
    }
    
    /**
     Implementação Humana do método, perguntando ao usuário qual o seu palpite.
     */
    override func chuta() -> Int {
        let _ = super.chuta()
        print("\(self.nome), digite seu palpite")
        return leEntradaInt()
    }
    
}
