# formato geral de um Makefile
#
# alvo: pre-requisito1 pre-requisito2...
#	comandos que usam os pre-requisitos para gerar o alvo

all: resultados/variacao_temperatura.csv resultados/numero_de_dados.txt resultados/variacao_temperatura.csv figuras/variacao_temperatura.png
	#nenhum comando, o "all" é um alvo ficticio

clean:
	rm -r -f resultados dados figuras

resultados/numero_de_dados.txt: dados/temperature-data.zip
	mkdir -p resultados
	ls dados/temperatura/*.csv | wc -l > resultados/numero_de_dados.txt
	
dados/temperature-data.zip: code/baixa_dados.py 
	python code/baixa_dados.py dados 
	
resultados/variacao_temperatura.csv: dados/temperature-data.zip  code/variacao_temperatura_todos.sh 
	mkdir -p resultados
	bash code/variacao_temperatura_todos.sh > resultados/variacao_temperatura.csv

figuras/variacao_temperatura.png: code/plota_dados.py resultados/variacao_temperatura.csv
	mkdir -p figuras
	python code/plota_dados.py resultados/variacao_temperatura.csv figuras/variacao_temperatura.png
	
