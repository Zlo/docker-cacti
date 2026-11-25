CACTI_URL = https://files.cacti.net/cacti/linux/cacti-latest.tar.gz
SPINE_URL = https://files.cacti.net/spine/cacti-spine-latest.tar.gz
TARBALLS  = cacti/cacti-latest.tar.gz cacti/cacti-spine-latest.tar.gz

# Download to a temporary file and only move it into place once it is
# complete and valid, so an interrupted download is not mistaken for a
# finished one on the next run.
define fetch
	mkdir -p $(@D)
	curl -fsSL --retry 3 -o $@.tmp $(1)
	gzip -t $@.tmp
	mv $@.tmp $@
endef

.PHONY: all build download update clean

all: build

download: $(TARBALLS)

cacti/cacti-latest.tar.gz:
	$(call fetch,$(CACTI_URL))

cacti/cacti-spine-latest.tar.gz:
	$(call fetch,$(SPINE_URL))

build: download
	docker compose build

# Fetch the latest Cacti and Spine releases again.
update: clean
	$(MAKE) download

clean:
	rm -f $(TARBALLS) $(addsuffix .tmp,$(TARBALLS))
