docker compose down

rm -rf target/

echo "Removed Target Folder"

mvn clean package

docker compose build

docker compose up -d

