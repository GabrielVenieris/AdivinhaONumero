//
//  Jogador.swift
//  CommandLineAdivinhaONumero
//
//  Created by Ricardo Venieris on 29/03/22.
//

/**
Tipo Enumerado com os possíveis valores de resultado de um palpite
*/

enum ResultadoPalpite {
    case nenhumPalpite
    case escolhidoMaiorQuePalpite
    case escolhidoMenorQuePalpite
    case escolhidoIgualAoPalpite
}

/**
 Jogador genérico (classe pai)
 Implementa métodos para 2 papéis
 - Papel A: Quem escolhe o número a ser adivinhado
 - Papel B: Quem adivinha o número
 */
class Jogador {
    let nome:String // Nome do Jogador
    var numeroEscolhido:Int = -1 // Número escolhido para ser adivinhado
    var palpites:Int = 0 // Quantidade de palpites feitos pelo jogador que vai adivinhar
    let gameRange:ClosedRange = 0...100 // Parte da regra do jogo, adivinhe um numero de 0 a 100

    init(_ nome:String) {
        self.nome = nome
        
    }

    // Papel A
    
    /**
     Método que escolhe o número a ser adivinhado
     como a implementação é completamente DIFERENTE entre Humano e Robô, na classe pai (genérica) não há implementação.
     */
    func escolheNumero() {}
    
    /**
     Ao receber um chute (palpite) do outro jogador, retorna o resultado do chute (maior, menor ou igual)
     como a implementação é IGUAL para Humano e Robô, a classe pai (genérica) implementa a função.
     adicionado a palavra "final" para garantir que não seja possível fazer override (sobreescrita)
     */
    final func checaSeAcertou(chute: Int)->ResultadoPalpite {
        // recebe o chute e verifica se acertou
        switch numeroEscolhido {
        case ..<chute:
            return .escolhidoMenorQuePalpite
        case (chute+1)... :
            return .escolhidoMaiorQuePalpite
        case chute:
            return .escolhidoIgualAoPalpite
        default:
            return .nenhumPalpite
        }
        
    }
    
    
    // Papel B
    
    /**
     Método que gera um chute (palpite)
     nesse caso, todas as classes filhas precisam adicionar 1 ao contador de palpites e depois executar os comandos especializados (diferentes para Humanos e Robôs).
     Não esqueça de na classe filha, o fazer override, adicionar "super.chu
     */
    func chuta()->Int {
        palpites = palpites + 1
        return -100000000
    }
    
    /**
     Ao receber o resultado do chute do primeiro jogador, decide o que fazer com essa informação para ajustar o palpite.
     Repare que para o jogador Humano nada precisa ser feito, apenas para o Robô
     */
    func trataResultado(chute: ResultadoPalpite) { }
    
    
    /**
     Reinicia variáveis para a próxima rodada
     Antes do início de uma rodada, essa função deve ser chamada
     */
    func reset() {
        numeroEscolhido = -1
        palpites = 0
    }
}
