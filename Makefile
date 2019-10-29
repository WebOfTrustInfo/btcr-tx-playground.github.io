# index.html always returns error so ignore these as failed compilation
.IGNORE: index.html

all: index.html

index.html: index.xsl btcr.html
	xsltproc index.xsl --html external/coinbin/index.html > index.html

clean:
	rm index.html
