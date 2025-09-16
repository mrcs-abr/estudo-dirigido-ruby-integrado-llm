# estudo-dirigido-ruby-integrado-llm

Este repositório detalha a resolução de 6 exercícios propostos na disciplina de Engenharia de Software, utilizando Gemini 2.5 Pro como apoio durante o processo de desenvolvimento utilizando a linguagem de programação Ruby.

## Exercício 01: Palíndromos e Contagem de Palavras (`exercicio01.rb`)

### Explicação do Algoritmo

1. **`palindrome?(string)`**

      * **Objetivo:** Verificar se uma string é um palíndromo, ignorando maiúsculas/minúsculas, pontuação e espaços.
      * **Estrutura:** A função primeiramente processa a string de entrada para criar uma versão "limpa". Ela converte todos os caracteres para minúsculo com `downcase` e remove todos os caracteres que não são palavras (letras e números) com `gsub(/\W/, "")`. O resultado é uma string contendo apenas os caracteres relevantes para a verificação. Por fim, ela compara essa string limpa com a sua versão invertida (`filtered_string.reverse`). Se forem iguais, a string original é um palíndromo.

2. **`count_words(string)`**

      * **Objetivo:** Contar a frequência de cada palavra em uma string.
      * **Estrutura:** A função utiliza uma abordagem funcional e concisa. Primeiramente, a string é convertida para minúsculo. Em seguida, `scan(/\w+/)` extrai todas as sequências de "caracteres de palavra" (letras, números e underscore), retornando um array de palavras. O método `each_with_object(Hash.new(0))` é então encadeado. Ele itera sobre cada palavra e utiliza um objeto que é passado de iteração em iteração — neste caso, um Hash inicializado com um valor padrão de 0. Para cada palavra, `counts[word] += 1` incrementa o contador daquela palavra no Hash. O resultado final é o Hash preenchido com a contagem de cada palavra.

### Implementações Alternativas

* **`palindrome?` (Paradigma Imperativo)**

  * **Implementação:** Poderíamos usar dois ponteiros, um no início e outro no fim da string limpa, movendo-os em direção ao centro e comparando os caracteres em cada posição.
  * **Vantagens:** Em linguagens de baixo nível, poderia ser marginalmente mais eficiente em termos de memória, pois não cria uma nova string invertida.
  * **Desvantagens:** Em Ruby, o código é mais verboso e menos idiomático. A versão com `.reverse` é altamente otimizada e sua clareza supera qualquer ganho mínimo de performance para strings de tamanho normal.

* **`count_words` (Paradigma Funcional com `group_by`)**

  * **Implementação:** `string.downcase.scan(/\w+/).group_by(&:itself).transform_values(&:count)`
  * **Vantagens:** É uma abordagem puramente funcional e extremamente expressiva. `group_by` é uma ferramenta poderosa para agrupar elementos de uma coleção, tornando o propósito do código muito claro para quem conhece o método.
  * **Desvantagens:** Pode ser um pouco menos performático para datasets muito grandes, pois cria arrays intermediários para cada grupo de palavras antes de contá-los. A versão com `each_with_object` constrói o hash final diretamente, sendo geralmente mais eficiente.

-----

## Exercício 02: Pedra-Papel-Tesoura (`exercicio02.rb`)

### Explicação do Algoritmo

1. **`rps_game_winner(game)`**

      * **Objetivo:** Determinar o vencedor de uma única partida de Pedra-Papel-Tesoura.
      * **Estrutura:** A função primeiro valida as entradas, garantindo que o jogo tenha exatamente dois jogadores (`game.length == 2`) e que as estratégias sejam válidas ('R', 'P' ou 'S'), lançando exceções customizadas (`WrongNumberOfPlayersError`, `NoSuchStrategyError`) caso contrário. A lógica de vitória é implementada usando um Hash `wins_against` que mapeia cada jogada para a jogada que ela vence. A função trata o caso de empate e, em seguida, verifica se a jogada do jogador 1 vence a do jogador 2.

2. **`rps_tournament_winner(tournament)`**

      * **Objetivo:** Determinar o vencedor de um torneio estruturado como arrays aninhados.
      * **Estrutura:** A função utiliza **recursão** para resolver o problema, espelhando a estrutura do torneio.
          * **Caso Base:** A condição `left_side[1].is_a?(String)` verifica se o elemento é uma partida única (um array de jogador e jogada) em vez de outro bracket de torneio. Se for uma partida, ela chama `rps_game_winner` para obter o vencedor.
          * **Passo Recursivo:** Se não for o caso base, a função se chama recursivamente para a chave esquerda (`tournament[0]`) e direita (`tournament[1]`) do torneio. Em seguida, ela usa `rps_game_winner` para determinar qual dos dois vencedores da sub-chave avança.

### Implementações Alternativas

* **Recursão vs. Iteração**
  * **Implementação (Iterativa):** Seria possível resolver o torneio de forma iterativa, usando uma fila (queue). Começaríamos com uma fila de todos os jogos da primeira rodada. Em um loop, removeríamos dois "vencedores" (ou jogos), jogaríamos a partida entre eles e adicionaríamos o vencedor de volta à fila. O processo continuaria até que apenas um vencedor restasse.
  * **Vantagens:** Uma abordagem iterativa evitaria o risco de "stack overflow" para torneios com uma profundidade extremamente grande, o que não é um problema prático aqui.
  * **Desvantagens:** O código seria significativamente mais complexo e menos intuitivo. A solução recursiva é mais elegante e mapeia diretamente a estrutura de dados do problema, tornando-a mais fácil de entender.

-----

## Exercício 03: Agrupando Anagramas (`exercicio03.rb`)

### Explicação do Algoritmo

* **`combine_anagrams(words)`**
  * **Objetivo:** Agrupar palavras de uma lista que são anagramas umas das outras.
  * **Estrutura:** A estratégia central é encontrar uma "chave" ou representação canônica para cada grupo de anagramas. A chave escolhida é a string de letras da palavra, em minúsculo e em ordem alfabética.
    <!-- end list -->
    1. Um Hash (`anagram_groups`) é inicializado para armazenar os grupos.
    2. A função itera sobre cada palavra da lista de entrada.
    3. Para cada palavra, a chave canônica é gerada: `word.downcase.chars.sort.join`.
    4. A palavra original é então adicionada ao array de valores no Hash correspondente a essa chave.
    5. No final, o método `.values` do Hash é chamado para retornar apenas os arrays de palavras agrupadas.

### Implementações Alternativas

* **Uso de `group_by` (Paradigma Funcional)**
  * **Implementação:** `words.group_by { |word| word.downcase.chars.sort.join }.values`
  * **Vantagens:** Esta é a forma mais idiomática e concisa de resolver este problema em Ruby. O código é declarativo e expressa a intenção diretamente: "agrupe as palavras pela sua forma canônica". É mais legível e menos propenso a erros do que a construção manual do Hash.
  * **Desvantagens:** Nenhuma significativa para este caso de uso. A performance é comparável à da abordagem manual e a clareza é muito superior.

-----

## Exercício 04: Classes de Sobremesa (`exercicio04.rb`)

### Explicação do Algoritmo

* **Estrutura:** Este exercício demonstra os conceitos de **Herança** e **Polimorfismo** em Orientação a Objetos.
    1. **Classe `Dessert`:** É a classe base, com atributos `name` e `calories`. Possui um método `healthy?` que retorna `true` se as calorias forem menores que 200, e um método `delicious?` que sempre retorna `true`.
    2. **Classe `JellyBean`:** Herda de `Dessert` (`JellyBean < Dessert`). Ela adiciona um novo atributo, `flavor`.
    3. **Sobrescrita de Métodos (Overriding):**
          * `JellyBean` define seu próprio método `initialize`, que não chama o `initialize` da classe mãe (`super`).
          * Ela também sobrescreve o método `delicious?`. Para instâncias de `JellyBean`, este método retorna `false` se o sabor for `"black licorice"`, demonstrando polimorfismo — o comportamento do método depende do tipo de objeto que o invoca.

### Implementações Alternativas

* **Uso de `super` no construtor**

  * **Implementação:** O construtor de `JellyBean` deveria reutilizar a lógica da classe mãe para inicializar `@name` e `@calories`.

        ```ruby
        def initialize(name, calories, flavor)
          super(name, calories) # Chama o initialize de Dessert
          @flavor = flavor
        end
        ```

  * **Vantagens:** Promove o princípio de "Don't Repeat Yourself" (DRY). Mantém a responsabilidade de inicializar os atributos da classe base na própria classe base. Se `Dessert` mudar seu construtor, `JellyBean` se adaptará automaticamente. É uma prática padrão e mais robusta em OOP.
  * **Desvantagens:** Nenhuma. É a forma correta de implementar a inicialização em uma subclasse.

* **Uso de Mixins**

  * **Implementação:** Se a lógica de `healthy?` ou `delicious?` fosse ser compartilhada por outras classes não relacionadas (ex: `Fruit`, `Drink`), poderíamos extraí-la para um Módulo (Mixin).

        ```ruby
        module Edible
          def delicious?
            true # Comportamento padrão
          end
        end

        class Dessert
          include Edible
          # ...
        end
        ```

  * **Vantagens:** Permite a reutilização de código entre classes que não compartilham uma relação de herança direta. Ajuda a manter o código organizado e evita a duplicação.
  * **Desvantagens:** Para um caso simples como este, pode ser um exagero. A herança direta é mais apropriada quando existe uma clara relação "é um" (`JellyBean` é uma `Dessert`).

-----

## Exercício 05: Metaprogramação - `attr_accessor_with_history` (`exercicio05.rb`)

### Explicação do Algoritmo

* **Estrutura:** Este exercício é um exemplo de **metaprogramação**. O código adiciona um novo método, `attr_accessor_with_history`, à própria classe `Class`. Isso permite que qualquer classe no sistema o utilize para criar atributos que rastreiam seu histórico de valores.
    1. O método `attr_accessor_with_history` recebe o nome do atributo (`attr_name`).
    2. Ele cria dinamicamente um getter para o atributo (`attr_reader attr_name`) e um getter para o histórico (`attr_reader attr_name + "_history"`).
    3. O núcleo da lógica está dentro de `class_eval`. Este método executa um bloco de código de string no contexto da classe que está chamando o método.
    4. A string define o método *setter* (ex: `def bar=(value)`). Dentro deste setter:
          * Um array de histórico (`@bar_history`) é inicializado com `[nil]` na primeira vez que o setter é chamado para uma instância específica.
          * O valor do atributo (`@bar`) é atualizado.
          * O novo valor é adicionado ao final do array de histórico (`@bar_history << value`).

### Implementações Alternativas

* **Uso de `define_method` em vez de `class_eval` com String**
  * **Implementação:**

        ```ruby
        class Class
          def attr_accessor_with_history(attr_name)
            attr_name = attr_name.to_s
            attr_reader attr_name, "#{attr_name}_history"

            define_method("#{attr_name}=") do |value|
              history_var = "@#{attr_name}_history"
              if !instance_variable_defined?(history_var)
                instance_variable_set(history_var, [nil])
              end
              instance_variable_set("@#{attr_name}", value)
              instance_variable_get(history_var) << value
            end
          end
        end
        ```

  * **Vantagens:** `define_method` com um bloco é geralmente considerado mais seguro e limpo do que avaliar uma string com `class_eval`. O código dentro do bloco tem acesso ao escopo léxico, as ferramentas de análise de código conseguem entendê-lo melhor, e evita possíveis problemas de injeção de código.
  * **Desvantagens:** A sintaxe pode ser um pouco mais verbosa (ex: `instance_variable_set`), mas a robustez e clareza geralmente compensam.

-----

## Exercício 06: Metaprogramação com Moedas e Palíndromos (`exercicio06.rb`)

### Explicação do Algoritmo

1. **Conversor de Moedas na Classe `Numeric`**

      * **Estrutura:** Este código usa **monkey patching** para adicionar funcionalidades de conversão de moeda diretamente aos números (`Numeric`).
      * **`method_missing`:** É o coração da funcionalidade. Quando um método inexistente como `.dollars` é chamado em um número, `method_missing` é invocado. O código singulariza o nome do método (`dollars` -\> `dollar`) e verifica se ele existe como chave no Hash `@@currencies`. Se existir, ele multiplica o número (`self`) pela taxa de câmbio, convertendo-o para um valor base (dólares).
      * **`in(currency)`:** Este método é chamado após a primeira conversão (ex: `5.dollars.in(:euros)`). Ele pega o valor já convertido para a moeda base (dólares) e o divide pela taxa da moeda de destino.
      * **`respond_to_missing?`:** É uma boa prática usada em conjunto com `method_missing`. Ela permite que métodos como `respond_to?(:dollars)` retornem `true`, fazendo com que os objetos numéricos se comportem de forma mais consistente.

2. **Extensão de `String` e `Enumerable`**

      * **Estrutura:** O código também faz monkey patching nas classes `String` e `Enumerable` para adicionar um método `palindrome?`.
      * **`String#palindrome?`:** A lógica é idêntica à do exercício 01.
      * **`Enumerable#palindrome?`:** Adiciona a verificação de palíndromo a qualquer classe que inclua o módulo `Enumerable` (como `Array` e `Range`). A implementação `self == self.reverse` funciona perfeitamente para arrays.

## Análise e Feedback

### Tempo e Esforço

* **Entender:** O esforço para entender algumas das resoluções propostas pela llm foram medianas, as que tive mais dificuldade foram as que envolviam o paradigma funcional, pois ainda não tenho muito domínio desse paradigma de programação, entretanto, com as explicações linha a linha da llm consegui entender grande parte do código.
* **Desenvolver:** O desenvolvimento dos exercícios foi bem rápido e não houve problemas de compilação dos códigos desenvolvidos, acredito por serem exercícios comuns e que possuem um grande arcabouço de resoluções pela internet. A llm conseguiu gerar resoluções que de fato produziam saídas corretas.

### Feedback Final sobre a Experiência

Para esse cenário em específico acredito que o uso da llm foi de grande utilidade, pois os exercicios propostos possuem um grande arcabouço de resoluções pela internet. Desenvolvendo os exercicios com o uso do Gemini muitos conceitos novos da linguagem ruby e do paradigma funcional foram explicados com bastante agilidade, creio que se estivesse desenvolvendo sozinho demoraria bastante pesquisando e buscando entender as novas estrututuras.
