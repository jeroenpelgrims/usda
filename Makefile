.PHONY: sqlite data clean
sqlite: ./out/usda.db
data: ./out/datasets
clean:
	rm -rf out

./out/datasets:
	./download.sh ./out/datasets

./out/usda.db: out/datasets
	./sqlite/create.sh ./out/datasets ./out
