ifndef VERSION
$(error VERSION must be supplied.  Don't include the 'v')
endif

ACCOUNT = franzinc

# Strip any '.rcN' from VERSION.
FINAL_VERSION=$(shell echo $(VERSION) | sed -e 's/\.rc.*$$//')

TAG = $(ACCOUNT)/agraph:v$(VERSION)
LATEST_TAG = $(ACCOUNT)/agraph:latest

TGZ = agraph-$(FINAL_VERSION)-linuxamd64.64.tar.gz

default: Dockerfile
	docker build -t $(TAG) .
	docker tag $(TAG) $(LATEST_TAG)

Dockerfile: FORCE
	sed -e 's/__TGZ__/$(TGZ)/g' \
	    -e 's/__VERSION__/$(VERSION)/g' \
	    -e 's/__FINAL_VERSION__/$(FINAL_VERSION)/g' \
	    Dockerfile.in > Dockerfile

# Unless you work at Franz, Inc you should ignore this rule:
push: FORCE
	docker push $(TAG)
	docker push $(LATEST_TAG)

FORCE:
