/* 
Pregunta
===========================================================================

Para resolver esta pregunta use el archivo `data.tsv`.

Construya una consulta que ordene la tabla por letra y valor (3ra columna).

Apache Hive se ejecutará en modo local (sin HDFS).

Escriba el resultado a la carpeta `output` de directorio de trabajo.

        >>> Escriba su respuesta a partir de este punto <<<
*/



DROP TABLE IF EXISTS t1;

CREATE TABLE t1 (letter STRING,
                 fecha DATE,
                 number int)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY '\t';

LOAD DATA LOCAL INPATH 'data.tsv' OVERWRITE INTO TABLE t1 ;

INSERT OVERWRITE local directory './output'
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
SELECT * FROM t1 ORDER BY letter ASC, number ASC;