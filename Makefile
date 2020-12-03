APP = /ella-admin

.PHONY: help Makefile

# Put it first so that "make" without argument is like "make help".
help:
	@echo "View the docs at: http://localhost:7000"
	@echo "View the  Django Interface at: http://localhost:8000"

# These were grabbed from .envs/.local/.postgres
POSTGRES_HOST=postgres
POSTGRES_PORT=5432
POSTGRES_DB=mlpa_reporting
POSTGRES_USER=vFUHHxfWQRErYOhtOTxuxMvRDMwDaLUK
POSTGRES_PASSWORD=AklAYVHYsbuauu1oCEOifGBvRq2O2Ow1mjMXdx9C0bDA5g6xKixO4uYTLFC3IRFC

build:
	docker-compose -f local.yml build

stop:
	docker-compose -f local.yml stop

dev:
	docker-compose -f local.yml up -d  --remove-orphans
	$(MAKE) help


wait:
	docker-compose -f local.yml exec postgres \
		bash -c \
		"while ! pg_isready --host ${POSTGRES_HOST} --dbname=${POSTGRES_DB} --username=${POSTGRES_USER}; do sleep 5; done"

load:
	$(MAKE) wait
	@echo "Loading in database dump"
	docker-compose -f local.yml exec  \
		postgres \
		bash -c "cat /data/MLPA-Data-Model.sql |PGPASSWORD=${POSTGRES_PASSWORD} psql -h ${POSTGRES_HOST} -U ${POSTGRES_USER} --dbname=${POSTGRES_DB}"

dump_schema:
	$(MAKE) wait
	@echo "Dumping database schema"
	docker-compose -f local.yml exec  \
		postgresql \
		bash -c "PGPASSWORD=${POSTGRES_PASSWORD} pg_dump -s -h ${POSTGRES_HOST} -U ${POSTGRES_USER} ${POSTGRES_DB}  > /data/${POSTGRES_DB}_db_schema.sql"



clean:
	docker-compose -f local.yml stop; docker-compose -f local.yml rm -f -v

logs:
	docker-compose -f local.yml logs

logs-scroll:
	docker-compose -f local.yml logs -f

jupyter-token:
	docker-compose -f local.yml logs jupyter | grep 127 | grep token | tail -n 5

restart:
	docker-compose -f local.yml restart

makemigrations:
	docker-compose -f local.yml run --rm django python manage.py makemigrations

migrate:
	docker-compose -f local.yml run --rm django python manage.py migrate

superuser:
	docker-compose -f local.yml run --rm django python manage.py createsuperuser
