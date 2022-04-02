//
//  JogadorRobo.swift
//  CommandLineAdivinhaONumero
//
//  Created by Ricardo Venieris on 29/03/22.
//

import Darwin

class JogadorRobo:Jogador {
    /*
     Variáveis auxiliares para ajustar o range dos palpites
     */
    private var lastMin = 0
    private var lastMax = 100
    private var lastTry = -1

    /**
     Numero escolhido por algorítmo aleatório
     */
    override func escolheNumero() {
        numeroEscolhido = Int.random(in: self.gameRange)
        print("\(self.nome), escolheu um numero entre '\(self.gameRange.lowerBound)' e '\(self.gameRange.upperBound)' para ser adivinhado")
        print("")
    }
    
    override func chuta() -> Int {
        let _ = super.chuta()
        let chute = chuteBinario()
        print(chute)
        sleep(1)
        lastTry = chute
        return chute
    }
    
    /**
     Palpite selecionado através de algorítmo de busca binária
     */
    private func chuteBinario()->Int {
        var palpite = (lastMin+lastMax)/2
        if palpite == lastMin && palpite == lastTry {
            palpite = lastMax
        }
        return palpite
    }
    
    /**
     Trata o resultado do palpite, ajustando os valores de limites da busca binária
     */
    override func trataResultado(chute: ResultadoPalpite) {
        switch chute {
        case .escolhidoMaiorQuePalpite:
            // se lastMin == lastTry arredondou pra baixo na última tentativa (lastMin já foi tentado)
            if lastMin == lastTry { lastTry = lastTry + 1 }
            lastMin = lastTry
        case .escolhidoMenorQuePalpite:
            if lastMax == lastTry { lastTry = lastTry - 1 }
            lastMax = lastTry
        case .escolhidoIgualAoPalpite:
            lastMin = lastTry
            lastMin = lastTry
        case .nenhumPalpite:
            break // faz nada
        }
    }
    
    /**
     Reseta também as variáveis de controle para a próxima rodada
     */
    override func reset() {
        super.reset()
        lastMin = 0
        lastMax = 100
        lastTry = -1
    }

}


