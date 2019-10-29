<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:xhtml="http://www.w3.org/1999/xhtml">

	<!--
		Varibables that are used in this stylesheet
	-->
	<!-- File where BTCR elements that will replace those in the input file -->
	<xsl:variable name="home" select="document('btcr.html',/html)" />
	<!-- The location of the coinbin repository -->
	<xsl:variable name="coinbin" select="'external/coinbin/'" />


	<!--
		Preparing the document
	-->
	<!-- Set the output type to html -->
	<xsl:output method="html"
		doctype-public="-//W3C//DTD HTML 4.01//EN"
		doctype-system="http://www.w3.org/TR/html4/strict.dtd"
		indent="yes"/>
	<!--
		Copy all the lines from input which should be the file 
		external/coinbin/index.html
	-->
	<xsl:template match="@*|node()">
		<xsl:copy>
			<xsl:apply-templates select="@*"/>
			<xsl:apply-templates select="node()"/>
		</xsl:copy>
	</xsl:template>


	<!--
		Modify the attributes so that they point to the resources in
		the git submodule, located in the external/coinbin directory
	-->
	<!-- Modify the link href attributes -->
	<xsl:template match="link/@href">
		<xsl:attribute name="href">
			<xsl:value-of select="concat($coinbin,.)"/>
		</xsl:attribute>
	</xsl:template>
	<!-- Modify the script src attributes -->
	<xsl:template match="script/@src">
		<xsl:attribute name="src">
			<xsl:value-of select="concat($coinbin,.)"/>
		</xsl:attribute>
	</xsl:template>
	<!-- Modify the image href attributes -->
	<xsl:template match="img/@src">
		<xsl:attribute name="src">
			<xsl:value-of select="concat($coinbin,.)"/>
		</xsl:attribute>
	</xsl:template>
	<!--
		in valid HTML you don't need to specify the type if it is javascript so
		here we remove the 'type' attribute from script tag
	-->
	<xsl:template match="script/@type" />


	<!--
		This replaces the existing home div from the input with that
		from the btcr.html file
	-->
	<!-- Replace the title -->	
	<xsl:template match="//head/title">
		<xsl:copy-of select="$home//head/title"/>
	</xsl:template>
	<!-- Insert the script tags -->
	<xsl:template match="//head">
		<xsl:apply-templates />
		<xsl:copy-of select="$home//head/script" />
	</xsl:template>
	<!-- replace the Home tab -->
	<xsl:template match="//div[@id='home']">
		<xsl:copy-of select="$home//body/div[@id='home']" />
	</xsl:template>
	<!-- replace the home button -->
	<xsl:template match="//a[@id='homeBtn']">
		<xsl:copy-of select="$home//body/a[@id='homeBtn']" />
	</xsl:template>
	<!-- replace the About tab -->
	<xsl:template match="//div[@id='about']">
		<xsl:copy-of select="$home//body/div[@id='about']" />
	</xsl:template>
	<!-- Replace links on footer -->
	<xsl:template match="//a[@href='https://github.com/OutCast3k/coinbin/']/@href">
		<xsl:attribute name="href">
			<xsl:value-of select="'https://github.com/WebOfTrustInfo/btcr-tx-playground.github.io'"/>
		</xsl:attribute>
	</xsl:template>
	


	<!--
		Change default settings
	-->
	<!-- Change deafault wallet type -->
	<xsl:template match="//input[@id=walletSegwit]/@checked" />
	<xsl:template match="//input[@id='walletSegwitp2sh' or @id='walletSegwitBech32']">
		<xsl:copy>
			<xsl:apply-templates select="@*"/>
			<xsl:attribute name="disabled">disabled</xsl:attribute>
			<xsl:apply-templates select="node()"/>
		</xsl:copy>
	</xsl:template>
	<!-- Change default address type -->
	<xsl:template match="//button[@id='walletToBtn']/text()">Legacy</xsl:template>
	<!-- Sort the network options in settings tab so that Bitcoin (Testnet) is first -->
	<xsl:template match="//select[@id='coinjs_coin']">
		<xsl:copy>
			<xsl:apply-templates select="@*" />
			<xsl:apply-templates select="option">
				<xsl:sort select="substring(@value,1,1)" data-type="text" order="ascending" />
				<xsl:sort select="substring(@value,9,1)" data-type="text" order="descending" />
			</xsl:apply-templates>
		</xsl:copy>
	</xsl:template>	

</xsl:stylesheet>
