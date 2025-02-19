# Calcula a variação de temperatura para todos os países

echo "variacao_C_por_ano,pais"

for arquivo in dados/temperatura/*.csv #começam com a e terminam com qqr coisa e sao csv
do
	python code/variacao_temperatura.py $arquivo
done
