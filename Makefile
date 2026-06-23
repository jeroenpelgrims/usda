.PHONY: sqlite data clean postgres

sqlite: ./out/usda.db
data: ./out/datasets

clean:
	rm -rf out

./out/datasets:
	./download.sh ./out/datasets

./out/usda.db: out/datasets
	./sqlite/create.sh ./out/datasets ./out

postgres: sqlite
	docker build -f postgres/Dockerfile .
