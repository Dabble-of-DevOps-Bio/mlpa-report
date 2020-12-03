DROP TABLE genes;
DROP TABLE genes_variations;
DROP TABLE genes_variants;
DROP TABLE results;
DROP TABLE ;

CREATE TABLE "genes" (
  "id" int UNIQUE PRIMARY KEY NOT NULL,
  "name" varchar NOT NULL
);

CREATE TABLE "genes_variations" (
  "gene_id" int NOT NULL,
  "variation_id" int NOT NULL
);

CREATE TABLE "variations" (
  "id" int UNIQUE PRIMARY KEY NOT NULL,
  "variation" varchar NOT NULL
);

CREATE TABLE "variations_results" (
  "variation_id" int NOT NULL,
  "result_id" int NOT NULL
);

CREATE TABLE "results" (
  "id" int UNIQUE PRIMARY KEY NOT NULL,
  "result" varchar NOT NULL
);

CREATE TABLE "interpretations" (
  "id" int UNIQUE PRIMARY KEY NOT NULL,
  "interpretations" text
);

CREATE TABLE "results_interpretations" (
  "result_id" id NOT NULL,
  "interpretations_id" int NOT NULL
);

ALTER TABLE "genes_variations" ADD FOREIGN KEY ("gene_id") REFERENCES "genes" ("id");

ALTER TABLE "genes_variations" ADD FOREIGN KEY ("variation_id") REFERENCES "variations" ("id");

ALTER TABLE "results_interpretations" ADD FOREIGN KEY ("result_id") REFERENCES "results" ("id");

ALTER TABLE "results_interpretations" ADD FOREIGN KEY ("interpretations_id") REFERENCES "interpretations" ("id");

ALTER TABLE "variations_results" ADD FOREIGN KEY ("result_id") REFERENCES "results" ("id");
ALTER TABLE "variations_results" ADD FOREIGN KEY ("variation_id") REFERENCES "variations" ("id");
