<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    version="2.0"
	xmlns:app="http://www.opengis.net/citygml/appearance/2.0"
	xmlns:bldg="http://www.opengis.net/citygml/building/2.0"
	xmlns:grp="http://www.opengis.net/citygml/cityobjectgroup/2.0"
	xmlns:con="http://www.opengis.net/citygml/construction/3.0"
	xmlns:core="http://www.opengis.net/citygml/2.0"
	xmlns:gen="http://www.opengis.net/citygml/generics/2.0"
    xmlns:uro="http://www.kantei.go.jp/jp/singi/tiiki/toshisaisei/itoshisaisei/iur/uro/1.4"
	xmlns:xlink="http://www.w3.org/1999/xlink"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:gml="http://www.opengis.net/gml"
	xmlns="http://www.opengis.net/citygml/2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xalan="http://xml.apache.org/xslt">

    <!-- Match the UrbanObject root element -->

    <!-- Map specific elements -->
	<!-- nob140 20250817 -->
	<xsl:template match="uro:buildingDetails">
        <xsl:element name="bldg:adeOfAbstractBuilding">
            <xsl:apply-templates select="uro:BuildingDetails"/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="uro:buildingIDAttribute">
        <xsl:element name="uro:BuildingIDAttribute">
            <!-- nob140 20250818 assume all attributes are defined with same name -->
            <xsl:apply-templates select="@*|node()" />
            <!--
            <xsl:apply-templates select="uro:BuildingDetails"/>
            -->
        </xsl:element>
    </xsl:template>
    <xsl:template match="uro:BuildingDetails">
        <xsl:element name="uro:BuildingIDAttribute">
            <!-- nob140 20250818 assume all attributes are defined with same name -->
            <xsl:apply-templates select="@*|node()" />
            <!--
            <xsl:apply-templates select="uro:buildingFootprintArea"/>
            <xsl:apply-templates select="uro:siteArea"/>
            <xsl:apply-templates select="uro:buildingStructureType"/>
            <xsl:apply-templates select="uro:urbanPlanType"/>
            <xsl:apply-templates select="uro:areaClassificationType"/>
            
			<xsl:apply-templates select="uro:prefecture"/>
			<xsl:apply-templates select="uro:city"/>
			<xsl:apply-templates select="uro:surveyYear"/>
            -->
        </xsl:element>
    </xsl:template>

    <xsl:template match="uro:extendedAttribute">
        <xsl:element name="bldg:adeOfAbstractBuilding">
            <xsl:apply-templates select="uro:KeyValuePair"/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="uro:KeyValuePair">
        <xsl:element name="uro:KeyValuePairAttribute">
            <!-- nob140 20250818 assume all attributes are defined with same name -->
            <xsl:apply-templates select="@*|node()" />
            <!--
            <xsl:apply-templates select="uro:key"/>
            <xsl:apply-templates select="uro:codeValue"/>
            -->
        </xsl:element>
    </xsl:template>

</xsl:stylesheet>
