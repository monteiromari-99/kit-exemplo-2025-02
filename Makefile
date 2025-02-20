# formato geral de um Makefile
#
# alvo: pre-requisito1 pre-requisito2...
#	comandos que usam os pre-requisitos para gerar o alvo

all: paper/paper.pdf  resultados/numero_de_dados.txt resultados/variacao_temperatura.csv 
	#nenhum comando, o "all" é um alvo ficticio
# resultados/variacao_temperatura.csv figuras/variacao_temperatura.png esses pre requisitos nao sao mais necessarios uma vez que temos o paper

clean:
	rm -r -f resultados dados figuras paper/paper.pdf
	
paper/paper.pdf: paper/paper.tex figuras/variacao_temperatura.png paper/paises.tex
	tectonic -X compile paper/paper.tex
	
paper/paises.tex: dados/temperature-data.zip code/lista_paises.py
	python code/lista_paises.py dados/temperatura/* > paper/paises.tex

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
	
