.DEFAULT_GOAL := all
.PHONY: all sqlite data clean postgres

all: postgres
	docker compose up -d
sqlite: ./out/usda.db
data: ./out/datasets

clean:
	rm -rf out

./out/datasets:
	./download.sh ./out/datasets

./out/usda.db: out/datasets
	./sqlite/create.sh ./out/datasets ./out

postgres: sqlite
	docker build -t usda -f postgres/Dockerfile . 
