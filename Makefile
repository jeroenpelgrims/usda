data:
	./download.sh ./out

sqlite:
	docker build --no-cache -t usda . && docker run -v ./out:/out --rm usda
