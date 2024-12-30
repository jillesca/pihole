TAG = pihole

.PHONY: run

run:
	$(MAKE) clean
	docker compose up --detach

cli:
	docker exec -it $(TAG) /bin/bash

clean: 
	-docker compose down

follow:
	docker logs --follow $(TAG)
