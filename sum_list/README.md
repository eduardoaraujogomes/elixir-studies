Faaala Dev!

Quando começamos estudar sobre programação funcional, um dos conceitos essenciais de se aprender é o conceito de **recursão**.

Recursão nada mais é que uma função chamando a si mesma num loop infinito até chegar num ponto de parada. Ficou meio confuso? Vou exemplificar aqui usando JavaScript mas não se preocupe com a linguagem usada. Recursão é apenas um conceito que pode ser aplicado em outras linguagens assim como a programação orientada à objetos:

```jsx
function recursiveCheckIsTenOrMore(value) {
	if (value >= 10) {
		console.log(value);
		return;
	} else {
			console.log(value);
			recursiveCheckIsTenOrMore(value + 1);
		}
}
```

O objetivo da recursão é lidar de forma mais natural com problemas que dependem de repetições sem que para isso você utilize um laço **for** ou **while** por exemplo.

Vamos para mais um exemplo prático..

Suponhamos que um sistema possui uma lista com e-mails de usuários para os quais precisa enviar algum email. Nesse caso, precisamos passar por cada endereço de email nessa lista para então realizar o envio de email, correto?
Teríamos então algo como o seguinte código:

```jsx
function sendMailFromList([email, ...rest]) {
	sendMailMessage(email); // Chamada da função responsável por enviar um email
	if (rest.length === 0) {
		return;
	}

	sendMailFromList(rest);
}
```

No código acima, temos uma função que recebe a lista de endereço de e-mails `sendMailFromList` onde o primeiro email da lista fica na variável `email` e o restante dos elementos ficam na variável `rest`. Após isso, a função responsável pelo envio de e-mails `sendMailMessage` é chamada com o parâmetro `email` que possui o endereço de email do destinatário e logo depois verificamos se o tamanho da lista `rest` é zero. Caso seja, a função para sua execução com o `return` e caso contrário, a função `sendMailFromList` é chamada novamente com `rest` sendo o parâmetro.

Assim, a lista passada por parâmetro no processo de recursividade sempre terá um elemento a menos até que chegue a zero elementos e a condição do `if` seja satisfeita.

Espero que até aqui tenha ficado mais claro o que é recursão: uma função que executa a si mesma afim de iterar sobre algo até que a condição de parada seja satisfeita. Simples né? 💜

 

## O "problema" da recursão

Se você já usa ou usou o paradigma funcional seja no trabalho ou em algum estudo que fez, é  provável que já tenha visto ou ouvido em algum lugar que **recursão é ineficiente** e, acredite ou não, isso não é totalmente mentira.

Partindo para mais um exemplo prático, vamos analisar o seguinte código:

```jsx
function sum([num, ...rest]) {
	if (rest.length === 0) {
		return num;
	} else {
		return num + sum(rest);	
	}
}
```

O que essa função faz é bem simples: recebe uma lista de números e retorna a soma de todos eles. Simplesmente isso!

Agora, olhando pelo lado computacional da coisa vamos analisar o que está acontecendo em cada loop dessa recursão. Considere `[1, 2, 3, 4]` como parâmetro para a primeira chamada da função.

1. No primeiro loop, a condição do `if` não será satisfeita, pois a lista possui 3 valores: 2, 3 e 4. 
    
    A linha `return num + sum(rest);` será equivalente a expressão matemática $1 + x$, ou seja, `num` possui o valor 1 da lista e a chamada da função `sum` que ainda não possui retorno e vai ficar pendente até que o ultimo loop ocorra. Vamos anotando isso:
    
    ```bash
    1 + x = ?
    ```
    
2. No segundo loop, a condição do `if` não será satisfeita, pois a lista possui 2 valores: 3 e 4. 
    
    A linha `return num + sum(rest);` será equivalente a expressão matemática $2 + y$, com `num` possuindo o valor 2 da lista e a chamada da função `sum` que ainda não possui retorno e vai ficar pendente até que o ultimo loop ocorra.
    
    Lembra do primeiro loop quando tínhamos $1 + x$ onde $x$ era o resultado da seguinte chamada da função? agora sabemos que o valor de $x$ é $2 + y$. 
    
    Então:
    
    ```bash
    1 + x = ?
    x = 2 + y
    ```
    
3. No terceiro loop, a condição do `if` não será satisfeita, pois a lista possui 1 valor: 4.
    
    A linha `return num + sum(rest);` será equivalente a expressão matemática $3 + z$, com `num` possuindo o valor 3 da lista e a chamada da função `sum` que ainda não possui retorno e vai ficar pendente até que o ultimo loop ocorra.
    
    Seguindo a lógica do passo anterior, sabemos que o valor de $y$ é $3 + z$.
    
    ```bash
    1 + x = ?
    x = 2 + y
    y = 3 + z
    ```
    
4. Agora no último loop a coisa muda um pouco já que a lista `rest` está vazia e a condição no `if` será satisfeita.
    
    Logo, o retorno será `num` que possui o valor 4 (o último valor da lista). E pimba!!! sabemos que o valor de $z$ é $4$.
    
    Então:
    
    ```bash
    1 + x = ?
    x = 2 + y
    y = 3 + z
    z = 4
    ```
    
    Agora o compilador irá resolver todas as chamadas que ficaram pendentes enquanto suas sucessoras não eram resolvidas. Dito isso, ele vai fazer exatamente o processo inverso (de baixo para cima) na ordem em que a função foi recursivamente chamada e irá resolver os cálculos pendentes assim como iremos fazer "na mão":
    
    1. Agora que temos o valor de $z$:
        
        ```bash
        1 + x = ?
        x = 2 + y
        y = 3 + 4 -> valor de z foi substituído
        z = 4
        ```
        
    2. Com o valor de $y$:
        
        ```bash
        1 + x = ?
        x = 2 + 7 -> valor de y foi substituído
        y = 3 + 4
        z = 4
        ```
        
    3. E por último com o valor de $x$:
        
        ```bash
        1 + 9 = ? -> valor de x foi substituído
        x = 2 + 7
        y = 3 + 4
        z = 4
        ```
        
    4. Após esse último passo que ficou pendente, o retorno de $1 + 9$ é feito e temos o resultado da primeira chamada (aquela que teve a lista completa quando rodamos `sum([1,2,3,4])`). Traduzindo, o retorno da chamada após toda a recursão será `10`.
    

Agora voltando para o que foi discutido no início dessa seção, você viu quantos passos foram necessários para chegar ao resultado dessa simples conta? Se considerarmos que cada passo dessa operação é uma execução de função que consome memória, processamento, etc, significa dizer que estamos gastando muito (dependendo da operação) por algo, até então, simples. E é por isso que dizem que recursão é ineficiente.

Eu até citei que recursão ser ineficiente não era *totalmente* mentira. Isso porque atualmente temos otimizações de operações com recursão como a *tail call optimization*.

## Entendendo Tail Call Optimization (TCO)

Essa técnica nos permite usar a recursão sem que façamos o uso excessivo e desnecessário dos recursos da máquina.

Quando nosso computador precisa executar algum programa mais pesado ou até mesmo jogos que exigem alto processamento e acaba fazendo isso de forma lenta ou travando, é comum ouvirmos alguém falar que um upgrade de memória resolveria o problema (ou até nós mesmos vamos lá e fazemos isso), e de fato resolve.

Isso acontece porque essa memória é usada para armazenar o código compilado do programa no momento em que o executamos e também é usada para armazenar as informações usadas nessa execução.

Para que fique mais claro, vamos para mais um exemplo prático:

```jsx
function functionOne() {
	const name = 'Danilo Vieira';

	functionTwo(name);
}

function functionTwo(data) {
	console.log(data);
}

functionOne();
```

Se fossemos executar esse código, ele seria compilado e então salvo na memória, e também o passo a passo que esse código irá seguir quando executado: primeiro a função `functionOne` é chamada, depois a variável `name` é declarada com o valor `'Danilo Vieira'` e que dentro dessa função, a função `functionTwo` é chamada com `name` sendo o parâmetro.. e seguindo isso até o fim do script.

> A parte da memória que armazena quais funções estão sendo chamadas e qual argumento é passado para elas é a *stack*, já as variáveis contendo seus valores ficam numa parte chamada *heap*.
> 

Considerando que é necessário armazenar na memória cada função que é chamada, isso implica dizer que, em uma recursão, o computador precisa armazenar na *stack* inúmeras vezes que a função foi chamada (exatamente a mesma função).

Sabendo que recursão é ineficiente simplesmente por ter que armazenar na memória inúmeras chamadas de uma função a si mesma, você não acha que seria ótimo caso houvesse um jeito de fazer isso sem armazenar na memória as chamadas da função?

Veja bem: porque precisamos armazenar na stack a informação de cada chamada de uma função a si mesma se o fluxo será sempre o mesmo? Seria muito mais vantajoso se pudéssemos armazenar a chamada da função apenas uma vez e reutilizar ela mudando apenas os parâmetros que serão passados. E é exatamente isso que a **Tail Call Optimization** faz!

Isso não é bem um padrão de código ou conceito que existe na programação. Na verdade é o compilador que percebe quando estamos usando a TCO e otimiza a chamada da função por nós. E antes que você me pergunte como ele faz isso, a resposta é: simplesmente pela forma como escrevemos uma função recursiva. Se a última operação feita dentro de uma função é uma chamada a si mesma, então o TCO é usado.

Vejamos dois códigos que fazem a mesma coisa. Um sem TCO e outro com:

```jsx
// Sem TCO
function nonOptimized([num, ...rest]) {
	if (rest.length === 0) {
		return num;
	}

	return num + nonOptimized(rest);
}

nonOptimized([1, 2, 3, 4]);

// Com TCO
function optimized([num, ...rest], acc = 0) {
	if (rest.length === 0) {
		return acc + num;
	}

	return optimized(rest, acc + num);
}

optimized([1, 2, 3, 4]);
```

A diferença entre as funções `nonOptimized` e `optimized` é que a primeira não é otimizada pelo fato de que precisamos executar as chamadas até o fim para então somarmos o resultado do último loop com o seu resultado anterior.

Por outro lado, a função `optimized` é um pouco diferente já que possui um parâmetro a mais que é o `acc` (abreviação para *accumulator* - acumulador). Ele vai guardando o valor da soma a cada loop em vez de aguardar que o último loop se resolva e quando a lista fica vazia, o valor total da soma é retornado (repare que para a última soma ocorrer, é necessário que façamos a soma do último valor da lista que está armazenado em `num`).

Por isso o compilador consegue identificar que essa função é recursiva e aplica o TCO para que a stack não armazene cada chamada da função.

## Conclusão

Espero que com essa explicação acerca de **Recursão** e **Tail Call Optimization**, tenha ficado mais claro qual a melhor maneira de iterar sobre alguma lista. Fazendo assim, um melhor uso da memória e consequentemente construindo um software mais otimizado.

