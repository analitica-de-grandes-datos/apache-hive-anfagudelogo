/*

Pregunta
===========================================================================

Escriba una consulta que calcule la cantidad de registros por clave de la 
columna 3. En otras palabras, cuántos registros hay que tengan la clave 
`aaa`?

Apache Hive se ejecutará en modo local (sin HDFS).

Escriba el resultado a la carpeta `output` de directorio de trabajo.

*/

DROP TABLE IF EXISTS t0;
CREATE TABLE t0 (
    c1 STRING,
    c2 ARRAY<CHAR(1)>, 
    c3 MAP<STRING, INT>
    )
    ROW FORMAT DELIMITED 
        FIELDS TERMINATED BY '\t'
        COLLECTION ITEMS TERMINATED BY ','
        MAP KEYS TERMINATED BY '#'
        LINES TERMINATED BY '\n';
LOAD DATA LOCAL INPATH 'data.tsv' INTO TABLE t0;

INSERT OVERWRITE local directory 'output'
ROW FORMAT DELIMITED FIELDS TERMINATED BY ','
SELECT
    t1.monto,
    count(*)
FROM(
    SELECT
        monto
    FROM t0 LATERAL VIEW explode(map_keys(c3)) exploded_table AS monto) t1
GROUP BY t1.monto;

