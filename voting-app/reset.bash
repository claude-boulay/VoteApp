#permets de vider la tables votes
docker exec -it $(docker ps -q -f name=vote-app_postgres) psql -U postgres -d postgres -c "DELETE FROM votes;"