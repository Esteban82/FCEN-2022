# Ejemplos de SED
in=example.txt

cat > $in <<-   EOF
1. hello
2. world
3. This is line three.
4. Here is the final line.
5. Nueva linea
EOF

echo Archivo original:
cat $in

# 1. Imprimir lineas (p)
#echo '1p' -n Imprimir primera linea 
#sed -n '1p' example.txt

echo -n '$p' Imprimir ultima linea:
sed -n '$p' example.txt

echo -n '1,4p' Imprimir 4 primeras lineas:
sed -n '1,4p' example.txt

echo -n '1~2p' Imprime 1 linea de cada 2.
sed -n '1~2p' example.txt

echo -n '2,+2p' Imprime linea 2, junto con las 2 siguientes
sed -n '2,+2p' example.txt

# 2. Borrar lineas
#echo '1d' Borra la primera linea 
#sed '1d' example.txt

#echo '2,3d' Borra las lineas 2 y 3
#sed '2,3d' example.txt

#echo '1!d' Borra todo excepto la primera linea (o sea solo deja la primera)
#sed '1!d' example.txt

# -i: trabaja en el mismo archivo de entrada. 

# 3. Buscar y reemplazar patrones
#sed -i 's/hello/hola/g' example.txt
#echo sed 's/hello/hola/g'
#sed 's/hello/hola/g' example.txt
echo sed 's/is/es/'
sed 's/is/es/' example.txt

echo sed 's/is/es/g'
sed 's/is/es/g' example.txt


echo Reemplazar puntos por comas sed 's/./,/g'
sed 's/./,/g' example.txt 
echo Da mal. El "." es un comodin que significa cualquier caracter. Por eso reemplaza todas las letras, incluidos los espacios por ,.
sed 's/\./,/g' example.txt



#sed -i "s/^ *//;s/ *$//;s/ \{1,\}/ /g" *.txt
