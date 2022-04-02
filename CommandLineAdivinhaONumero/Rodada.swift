//
//  Rodada.swift
//  CommandLineAdivinhaONumero
//
//  Created by Ricardo Venieris on 29/03/22.
//

class Rodada {
    var jogador1:Jogador
    var jogador2:Jogador
    
    init(jogador1:Jogador, jogador2:Jogador) {
        self.jogador1 = jogador1
        self.jogador2 = jogador2
    }

    /**
     Joga uma rodada de acordo com a regra
     */
    func joga() {
        // Jogador 1 escolhe um número para ser adivinhado
        jogador1.escolheNumero()
        
        var resultadoChute:ResultadoPalpite = .nenhumPalpite
        
        // Enquanto Jogador 2 não acerta o número escolhido...
        while (resultadoChute != .escolhidoIgualAoPalpite) {
            // pegamos o palpite do jogador 2
            let palpite = jogador2.chuta()
            // perguntamos ao jogador 1 qual o resultado do chute (maior, menor, acertou)
            resultadoChute = jogador1.checaSeAcertou(chute: palpite)
            // jogador 2 é informado do resultado do chute
            jogador2.trataResultado(chute: resultadoChute)
            
            
            // Mostramos na tela o resultado do chute
            switch resultadoChute {
                
            case .escolhidoMaiorQuePalpite:
                print("O número em minha mente é MAIOR que \(palpite)")
                print()

            case .escolhidoMenorQuePalpite:
                print("O número em minha mente é MENOR que \(palpite)")
                print()

            case .escolhidoIgualAoPalpite:
                print("Parabéns! Você acertou o número: \(palpite)")
                print()

            case .nenhumPalpite:
                break // faz nada
            }
        }
        
        // Ao final da rodada, informamos o vencedor
        print("-------------------------------------------------")
        print(jogador2.nome, "acertou em", jogador2.palpites, "tentativas")
        print("-------------------------------------------------")
        print("\n\n\n\n\n")
    }
    
    /**
     Reset os jogadores e troca as posições do Jogador 1 com o  2
     Deve ser chamado ao final de cada rodada
     */
    func resetAndSwap() {
        jogador1.reset()
        jogador2.reset()
        swap(&jogador1, &jogador2)
    }
}


