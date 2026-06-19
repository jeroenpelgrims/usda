data:
	./download.sh ./out

sqlite: data
	./sqlite/create.sh ./out

docker:
	docker build --no-cache -t usda . && docker run -v ./out:/out --rm usda
