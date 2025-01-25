# Compra Remota Segura

**DCC030 Blockchain & Criptomoedas**

**Universidade Federal de Minas Gerais 2024/02**

Bernardo Reis de Almeida e Gustavo Tavares Corrêa

## 1. Abstract
O presente projeto de desenvolvimento de software busca explorar diferentes maneiras de se implementar uma compra remota segura com base em contratos inteligentes.

## 2. Descrição
Existem vários riscos quando se pensa em compras online, tanto para o comprador, quanto para o vendedor. Para este, o cliente pode forjar um pagamento e exigir a entrega do produto, enquanto para aquele, o bem adquirido pode nunca ser enviado. Uma maneira de resolver esse conflito é delegar autoridade a uma plataforma terceira, como um banco ou instituição de comércio, centralizando o processo. Porém, essa abordagem exige confiança nesse intermediador, o qual pode arbitrariamente manipular as transações.
	Uma alternativa a esse cenário surge com plataformas baseadas em blockchain. Um exemplo seria a rede Ethereum, na qual programas arbitrários podem ser elaborados e executados de maneira transparente e descentralizada. Qualquer membro que participe das operações é capaz de validá-las, não havendo necessidade por controle terceiro. Naturalmente, existem vantagens e desvantagens entre essas duas abordagens. Na própria documentação da linguagem de programação Solidity, utilizada para a implementação de contratos inteligentes em Ethereum, é apresentado um mecanismo simples de compra e de venda, mas o autor deixa claro que ele não resolve todos os problemas.
Nesse contexto, a ideia deste projeto é avaliar de quais maneiras é possível implementar um programa de compra remota seguro utilizando contratos inteligentes. Soluções já existentes na literatura serão exploradas, seus pontos fortes e fracos, suas garantias e suas vulnerabilidades serão discutidas e, ao final, será implementado um contrato inteligente exemplar. Em suma, deseja-se avaliar o quão seguro é possível criar uma plataforma de compra e venda online utilizando tecnologias de blockchain e se, de fato, seu uso é justificado em comparação a abordagens tradicionais ou se elas atenderiam a requisitos diferentes.

## 3. Resultados Esperados
O primeiro resultado esperado deste projeto é uma análise das possibilidades já existentes para implementação de mecanismos de compra remota segura. Em particular, deseja-se responder às perguntas de se existe uma solução baseada em blockchain que é totalmente segura e, caso contrário, quais são as vantagens e desvantagens de cada uma ou quais são os cenários nos quais são aplicáveis.
	O segundo resultado deste projeto é uma implementação de um contrato inteligente para um sistema de compra e venda online. Caso seja identificada uma forma totalmente segura e viável de o realizar, ela será a abordagem adotada. Caso contrário, um ou mais casos de uso específicos serão escolhidos e contratos serão implementados para ele, juntamente com uma demonstração prática de seus diferenciais e de suas vulnerabilidades.
 
## 4. Métodos Utilizados
O primeiro resultado será baseado em um estudo extenso da literatura existente. Isso pode incluir a documentação de linguagens de programação para plataformas de blockchain, artigos científicos, livros didáticos, dentre outros. O segundo resultado, por sua vez, será alcançado com o uso da linguagem de programação Solidity para a implementação de um contrato para a rede Ethereum. No caso, não será utilizada a rede principal para fins de teste, mas sim uma rede secundária ou simulada que não envolva custos monetários.
