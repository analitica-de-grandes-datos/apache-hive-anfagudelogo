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
    letra,
    t1.monto,
    count(*)
FROM(
SELECT
    c2,
    monto
FROM t0 LATERAL VIEW explode(map_keys(c3)) exploded_table AS monto) t1 LATERAL VIEW explode(t1.c2) exploded_table AS letra
GROUP BY letra, t1.monto;