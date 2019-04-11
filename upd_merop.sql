DELETE FROM "MEROP" WHERE "KVD"='';

CREATE TABLE "MEROPT"
(
  "IDN" integer,
  "PY" character varying(3),
  "NKAR" character varying(9),
  "DATA" date,
  "KISP" smallint,
  "KVD" character varying(4),
  "TEXTMER" character varying(100),
  "MATHELP" integer,
  "ORG" character varying(60),
  "OBR" character varying(150)
)
WITH (
  OIDS=FALSE
);

INSERT into "MEROPT" select distinct * from "MEROP";

DELETE FROM "MEROP";

INSERT into "MEROP" select * from "MEROPT";

DROP TABLE "MEROPT";

 