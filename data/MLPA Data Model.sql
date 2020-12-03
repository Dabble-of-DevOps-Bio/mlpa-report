CREATE TABLE "genes" (
  "id" int PRIMARY KEY,
  "name" varchar NOT NULL
);

CREATE TABLE "genes_variants" (
  "gene_id" int,
  "variation_id" int
);

CREATE TABLE "variations" (
  "id" int PRIMARY KEY,
  "variation" varchar NOT NULL
);

CREATE TABLE "variations_results" (
  "variation_id" int,
  "result_id" int
);

CREATE TABLE "results" (
  "id" int PRIMARY KEY,
  "result" varchar NOT NULL
);

CREATE TABLE "interpretations" (
  "id" int PRIMARY KEY,
  "interpretations" text
);

CREATE TABLE "results_interpretations" (
  "result_id" int,
  "interpretations_id" int
);

ALTER TABLE "genes" ADD FOREIGN KEY ("id") REFERENCES "genes_variants" ("gene_id");

ALTER TABLE "genes_variants" ADD FOREIGN KEY ("variation_id") REFERENCES "variations" ("id");

ALTER TABLE "variations" ADD FOREIGN KEY ("id") REFERENCES "variations_results" ("variation_id");

ALTER TABLE "results" ADD FOREIGN KEY ("id") REFERENCES "results_interpretations" ("result_id");

ALTER TABLE "interpretations" ADD FOREIGN KEY ("id") REFERENCES "results_interpretations" ("interpretations_id");

ALTER TABLE "results" ADD FOREIGN KEY ("id") REFERENCES "variations_results" ("result_id");
