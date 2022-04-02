//
//  Partida.swift
//  CommandLineAdivinhaONumero
//
//  Created by Ricardo Venieris on 29/03/22.
//

/**
 Uma Partida é composta por 'N' Sets
 - 1 Set é comporto por 2 rodadas, cada uma com 1 jogador diferente escolhendo o número
 - Ao criarmos uma partida nova, o construtor já a inicializa.
 */
class Partida {
    // Totalizadores de controle e para placar final
    var totalSet:Int
    var jogador1:Jogador
    var jogador2:Jogador
    var totalTentativasJogador1:Int = 0
    var totalTentativasJogador2:Int = 0
    
    var mediaJogador1:Int { totalTentativasJogador1 / totalSet}
    var mediaJogador2:Int { totalTentativasJogador2 / totalSet}
    var msgVencedor:String{
        if totalTentativasJogador1<totalTentativasJogador2 {
            return "\(jogador1.nome) venceu!"
        } // else
        if totalTentativasJogador1>totalTentativasJogador2 {
            return "\(jogador2.nome) venceu!"
        } // else
        return "Empatou!"
        
    }

    // Constrói uma partida já a inicializando
    init(totalSet:Int) {
        self.totalSet = totalSet
        // Cria jogador, perguntando o nome dele
        self.jogador1 = Partida.readJogador(1) // <-Isso..
        self.jogador2 = Self.readJogador(2) // <-é igual a isso.
        print("\n\n\n\n")
        
        // Inicia a partida
        rodaPartida()
    }
    
    /**
     Inicia uma partida
     */
    private func rodaPartida() {
        print("Iniciando Partida")
        print("-----------------")

        // Cria uma rodada com os 2 jogadores
        let rodada = Rodada(jogador1: jogador1, jogador2: jogador2)

        // Para cada Set
        for setNo in 1...totalSet {
            print("Set \(setNo)")
            print("--------")
            
            // Roda uma rodada, coletando o total de palpites do jogador 2
            let palpitesJ2 = rodaRodada(letra: "A", rodada: rodada)
            // Reseta a rodada
            rodada.resetAndSwap()
            print("Digite 'enter' para continuar")
            let _ = readLine()

            // Roda uma rodada, coletando o total de palpites do jogador 1
            let palpitesJ1 = rodaRodada(letra: "B", rodada: rodada)
            rodada.resetAndSwap()
            // Reseta a rodada
            print("Digite 'enter' para continuar")
            let _ = readLine()
                        

            // Acumula os totais do Set
            totalTentativasJogador1 += palpitesJ1
            totalTentativasJogador2 += palpitesJ2
            
        }
        
        // Ao final da partida, mostra o placar
        print("Placar da partida: \(totalSet) sets")
        print("-----------------------------------------------")
        print(jogador1.nome, "Total palpites:", totalTentativasJogador1, "  média:", mediaJogador1)
        print(jogador2.nome, "Total palpites:", totalTentativasJogador2, "  média:", mediaJogador2)
        print("-----------------------------------------------")
        print(msgVencedor)
        print("-----------------------------------------------")
        print()
    }
    
    // Roda uma rodada sempre retornando a quantidade de tentativas do jogador adivinho da vez
    private func rodaRodada(letra:String, rodada:Rodada)->Int {
        print("")
        print("Rodada \(letra):")
        print(rodada.jogador1.nome, "Escolhe um número")
        print(rodada.jogador2.nome, "Adivinha o número")
        rodada.joga()
        return rodada.jogador2.palpites
        
    }
    
    /**
     Método da classe (static) que cria um jogador à partir de uma entrada no console
     */
    private static func readJogador(_ numeroPrompt:Int)->Jogador {
        print("Digite o nome do Jogador \(numeroPrompt) (enter para Robô)")
        let nome = readLine() ?? ""
        
        let jogador = nome.isEmpty ? JogadorRobo("🤖 Mac-\(numeroPrompt)") : JogadorHumano(nome)
        return jogador
    }
}
