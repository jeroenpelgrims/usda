docker build --no-cache -t usda . && docker run -v ./out:/out -e POSTGRES_PASSWORD=postgres -p 5433:5432 --rm usda
