set PLATFORM=1C
set RELEASE=16
docker login
docker build --tag vagurko/docker-1c-postgrespro:%PLATFORM%-%RELEASE% .
docker push vagurko/docker-1c-postgrespro:%PLATFORM%-%RELEASE%
