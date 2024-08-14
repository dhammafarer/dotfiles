docker run -p 5050:80 \
    -e 'PGADMIN_DEFAULT_EMAIL=pgadmin@example.com' \
    -e 'PGADMIN_DEFAULT_PASSWORD=K4HeAk1xzNg4OZ9zAZVKSSwXs' \
    --network spabreaks_default \
    --name pgadmin \
    -d dpage/pgadmin4:latest
