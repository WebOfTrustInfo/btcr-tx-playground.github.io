# index.html always returns error so ignore these as failed compilation
TOP_DIR:=$(shell pwd)
TARGET_DIR:=$(TOP_DIR)/js/build
SUBMODULE_DIR:=$(TOP_DIR)/external

BTCRDIDUTILS_SOURCE=$(SUBMODULE_DIR)/btcr-did-tools-js/btcrDidUtils.js
BTCRDIDUTILS:=$(TARGET_DIR)/btcrDidUtils.js

TXREFCONVERTER_SOURCE:=$(SUBMODULE_DIR)/txref-conversion-js/txrefConverter-browserified.js 
TXREFCONVERTER:=$(TARGET_DIR)/txrefConverter-browserified.js


.IGNORE: index.html $(BTCRDIDUTILS)
.PHONY: update update-all build-dir

all: index.html $(BTCRDIDUTILS) $(TXREFCONVERTER)

index.html: index.xsl btcr.html
	xsltproc index.xsl --html external/coinbin/index.html > index.html

clean:
	rm index.html;
	rm -R build

target-dir:
	mkdir -p $(TARGET_DIR)

update:
	git submodule update --init

update-all: update
	git submodule foreach git pull origin master

# Prepare the external javascript resources
# The btcrDidUtils.js file needs to be built using npm.  This is separated from the
# action to copy the file so that we don't need to build the file each time
$(BTCRDIDUTILS_SOURCE): update-all
	cd $(SUBMODULE_DIR)/btcr-did-tools-js; \
	npm install;

# Once built the js file needs to be copied to the resource dir
# As a workaround we add 'user-agent' to the unsafeHeaders variable
$(BTCRDIDUTILS): target-dir $(BTCRDIDUTILS_SOURCE)
	cp $(BTCRDIDUTILS_SOURCE) $(BTCRDIDUTILS); \
	sed -i 's/var unsafeHeaders = \[/var unsafeHeaders = \[ '"'"'user-agent'"'"',/g' js/build/btcrDidUtils.js

# The txref-converter javascript should already be compiled and ready for inclusion
$(TXREFCONVERTER): update-all target-dir
	cp $(TXREFCONVERTER_SOURCE) $(TXREFCONVERTER)

deps: $(BTCRDIDUTILS)
