TAG = pihole

.PHONY: run

run:
	$(MAKE) clean
	docker compose up --build --detach

cli:
	docker exec -it $(TAG) /bin/bash

clean: 
	-docker rm --force $(TAG)

follow:
	docker logs --follow $(TAG)
