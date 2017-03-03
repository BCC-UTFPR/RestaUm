posicao = {
	linha,
	coluna,
}

guardarPrioridade = {
	linha,
	coluna,
	peso,
	direcao,
}

-- função para construir o tabuleiro que guarda as posições
function constroiTabuleiroPeso(linhas, colunas)
	matrizPeso = {} -- cria a matriz
	for i = 1, linhas do
		matrizPeso[i] = {} -- cria a linha
		for j = 1, colunas do
			if ((i == 1 and j == 3) or (i == 1 and j == 4) or (i == 1 and j == 5) or 
				(i == 2 and j == 3) or (i == 2 and j == 4) or (i == 2 and j == 5) or
				(i == 3 and j == 1) or (i == 4 and j == 1) or (i == 5 and j == 1) or
				(i == 3 and j == 2) or (i == 4 and j == 2) or (i == 5 and j == 2) or
				(i == 3 and j == 6) or (i == 4 and j == 6) or (i == 5 and j == 6) or
				(i == 3 and j == 7) or (i == 4 and j == 7) or (i == 5 and j == 7) or
				(i == 6 and j == 3) or (i == 6 and j == 4) or (i == 6 and j == 5) or
				(i == 7 and j == 3) or (i == 7 and j == 4) or (i == 7 and j == 5)) then
					matrizPeso[i][j] = 9
			end
			if ((i == 1 and j == 1) or (i == 1 and j == 2) or
				(i == 2 and j == 1) or (i == 2 and j == 2) or
				(i == 1 and j == 6) or (i == 1 and j == 7) or
				(i == 2 and j == 6) or (i == 2 and j == 7) or
				(i == 6 and j == 1) or (i == 6 and j == 2) or
				(i == 7 and j == 1) or (i == 7 and j == 2) or
				(i == 6 and j == 6) or (i == 6 and j == 7) or	
				(i == 7 and j == 6) or (i == 7 and j == 7)) then
					matrizPeso[i][j] = "#"
			end			
			if ((i == 3 and j == 3) or (i == 3 and j == 4) or (i == 3 and j == 5) or 
				(i == 4 and j == 3) or (i == 4 and j == 4) or (i == 4 and j == 5) or
				(i == 5 and j == 3) or (i == 5 and j == 4) or (i == 5 and j == 5)) then
					matrizPeso[i][j] = 8
			end
		end
	end
end

-- função que constrói o tabuleiro real
function constroiTabuleiro(linhas, colunas)
	matriz = {} -- cria a matriz
	for i = 1, linhas do
		matriz[i] = {} -- cria a linha
		for j = 1, colunas do
			if ((i == 1 and j == 1) or (i == 1 and j == 2) or
				(i == 2 and j == 1) or (i == 2 and j == 2) or
				(i == 1 and j == 6) or (i == 1 and j == 7) or
				(i == 2 and j == 6) or (i == 2 and j == 7) or
				(i == 6 and j == 1) or (i == 6 and j == 2) or
				(i == 7 and j == 1) or (i == 7 and j == 2) or
				(i == 6 and j == 6) or (i == 6 and j == 7) or	
				(i == 7 and j == 6) or (i == 7 and j == 7)) then
					matriz[i][j] = "-"
				else if (i == 4 and j == 4) then
					matriz[i][j] = 0
			else
				matriz[i][j] = "x"
				end
			end
		end
	end
end

-- função para procurar a posição vazia
function procuraVazia(tabuleiro, tabuleiroPeso)
	for i = 1, 7 do
		for j = 1, 7 do
			if (tabuleiro[i][j] == 0) then
				if(verificaComida(tabuleiro, tabuleiroPeso, i, j)  == true) then
					return true
				end
			end
		end
	end
end

function verificaComida(tabuleiro, tabuleiroPeso, linha, coluna)
	entrou = false 
	guardarPrioridade.peso = 0
	
	if(linha >= 3) then
		if(tabuleiro[linha-1][coluna] == "x" and tabuleiro[linha-2][coluna] == "x") then
			guardarPrioridade.linha = linha-2
			guardarPrioridade.coluna = coluna
			guardarPrioridade.peso = tabuleiroPeso[linha-2][coluna]
			guardarPrioridade.direcao = "CIMA"
			
			entrou = true 
		end
	end
	if(linha <= 5) then
		if(tabuleiro[linha+1][coluna] == "x" and tabuleiro[linha+2][coluna] == "x") then
			if(guardarPrioridade.peso < tabuleiroPeso[linha+1][coluna]) then
				guardarPrioridade.linha = linha+2
				guardarPrioridade.coluna = coluna
				guardarPrioridade.peso = tabuleiroPeso[linha+1][coluna]
				guardarPrioridade.direcao = "BAIXO"
				
				entrou = true
			end
		end
	end
	if(coluna >= 3) then
		if(tabuleiro[linha][coluna-1] == "x" and tabuleiro[linha][coluna-2] == "x") then
			if(guardarPrioridade.peso < tabuleiroPeso[linha][coluna-2]) then
				guardarPrioridade.linha = linha
				guardarPrioridade.coluna = coluna-2
				guardarPrioridade.peso = tabuleiroPeso[linha][coluna-2]
				guardarPrioridade.direcao = "DIR"
				
				entrou = true
			end
		end
	end
	if(coluna <= 5) then
		if(tabuleiro[linha][coluna+1] == "x" and tabuleiro[linha][coluna+2] == "x") then
			if(guardarPrioridade.peso < tabuleiroPeso[linha][coluna+2]) then
				guardarPrioridade.linha = linha
				guardarPrioridade.coluna = coluna+2
				guardarPrioridade.peso = tabuleiroPeso[linha][coluna+2]
				guardarPrioridade.direcao = "ESQ"		
				entrou = true
			end
		end
	end
	
	if(entrou == true) then
		movimentar(tabuleiro, guardarPrioridade)
	end
	
	return entrou
end

-- função para movimentar os pegs
function movimentar(tabuleiro, guardarPrioridade)
	if(guardarPrioridade.direcao == "CIMA") then
		tabuleiro[guardarPrioridade.linha][guardarPrioridade.coluna] = 0
		tabuleiro[guardarPrioridade.linha+1][guardarPrioridade.coluna] = 0
		tabuleiro[guardarPrioridade.linha+2][guardarPrioridade.coluna] = "x"
	end
	if(guardarPrioridade.direcao == "BAIXO") then
		tabuleiro[guardarPrioridade.linha][guardarPrioridade.coluna] = 0
		tabuleiro[guardarPrioridade.linha-1][guardarPrioridade.coluna] = 0
		tabuleiro[guardarPrioridade.linha-2][guardarPrioridade.coluna] = "x"
	end
	if(guardarPrioridade.direcao == "DIR") then
		tabuleiro[guardarPrioridade.linha][guardarPrioridade.coluna] = 0
		tabuleiro[guardarPrioridade.linha][guardarPrioridade.coluna+1] = 0
		tabuleiro[guardarPrioridade.linha][guardarPrioridade.coluna+2] = "x"
	end
	if(guardarPrioridade.direcao == "ESQ") then
		tabuleiro[guardarPrioridade.linha][guardarPrioridade.coluna] = 0
		tabuleiro[guardarPrioridade.linha][guardarPrioridade.coluna-1] = 0
		tabuleiro[guardarPrioridade.linha][guardarPrioridade.coluna-2] = "x"
	end
end

function contarPecas(tabuleiro)
	cont = 0
	for i = 1, 7 do
		for j = 1, 7 do
			if (tabuleiro[i][j] == "x") then 
				cont = cont + 1
			end
		end
	end
	io.write("Restaram: "..cont)
end

-- função para printar o tabuleiro
function printarTabuleiro(tabuleiro)
	for i = 1, 7 do
		for j = 1, 7 do
			io.write(matriz[i][j].."   ")
		end
	print("\n")
	end
	io.write("--------------------------\n")
end

function inicializaJogo(tabuleiro)
	math.randomseed(os.time())
	mov = math.random(4)
	
	if (mov == 1) then
		guardarPrioridade.linha = 4
		guardarPrioridade.coluna = 4
		guardarPrioridade.direcao = "CIMA"
		movimentar(tabuleiro, guardarPrioridade)
	end
	if (mov == 2) then
		guardarPrioridade.linha = 4
		guardarPrioridade.coluna = 4
		guardarPrioridade.direcao = "BAIXO"
		movimentar(tabuleiro, guardarPrioridade)
	end
	if (mov == 3) then
		guardarPrioridade.linha = 4
		guardarPrioridade.coluna = 4
		guardarPrioridade.direcao = "DIR"
		movimentar(tabuleiro, guardarPrioridade)
	end
	if (mov == 4) then
		guardarPrioridade.linha = 4
		guardarPrioridade.coluna = 4
		guardarPrioridade.direcao = "ESQ"
		movimentar(tabuleiro, guardarPrioridade)
	end
end

function forcaBruta(tabuleiro, tabuleiroPeso)
	inicializaJogo(tabuleiro)
	printarTabuleiro(tabuleiro)
	for j = 1, 40 do
		if(procuraVazia(tabuleiro, tabuleiroPeso) == true) then
			printarTabuleiro(tabuleiro)
		end
	end
end


constroiTabuleiro(7, 7)
constroiTabuleiroPeso(7, 7)
printarTabuleiro(tabuleiro)
forcaBruta(matriz, matrizPeso)
