# index.html always returns error so ignore these as failed compilation
.IGNORE: index.html btcrDidUtils.js

.PHONY: update

all: index.html btcrDidUtils.js

index.html: index.xsl btcr.html
	xsltproc index.xsl --html external/coinbin/index.html > index.html

clean:
	rm index.html

update:
	git submodule update --init

update-all: update
	git submodule foreach git pull origin master

btcrDidUtils.js:
	cd external/btcr-did-tools-js; \
	npm install
