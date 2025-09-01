<?xml version="1.0" encoding="UTF-8"?>
<!-- nob140 20250824 for Taito City -->
<xsl:stylesheet 
    version="2.0"
	xmlns:bldg="http://www.opengis.net/citygml/building/2.0"
	xmlns:grp="http://www.opengis.net/citygml/cityobjectgroup/2.0"
	xmlns:con="http://www.opengis.net/citygml/construction/3.0"
	xmlns:core="http://www.opengis.net/citygml/2.0"
	xmlns:gen="http://www.opengis.net/citygml/generics/2.0"
    xmlns:uro="https://www.geospatial.jp/iur/uro/3.1"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xalan="http://xml.apache.org/xslt"
	xmlns:pbase="http://www.opengis.net/citygml/profiles/base/2.0"
	xmlns:smil20lang="http://www.w3.org/2001/SMIL20/Language"
	xmlns:smil20="http://www.w3.org/2001/SMIL20/"
	xmlns:sch="http://www.ascc.net/xml/schematron">

    <!-- uro 1.4, Munakata City -->
    <xsl:template match="uro:buildingDetails">
        <xsl:element name="uro:buildingDetailAttribute">
            <xsl:apply-templates select="uro:BuildingDetails"/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="uro:BuildingDetails">
        <xsl:element name="uro:BuildingDetailAttribute">
            <xsl:apply-templates select="@*|node()"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="uro:extendedAttribute">
        <xsl:element name="uro:keyValuePairAttribute">
            <xsl:apply-templates select="uro:KeyValuePair"/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="uro:bldgKeyValuePairAttribute">
        <xsl:element name="uro:keyValuePairAttribute">
            <xsl:apply-templates select="uro:KeyValuePair"/>
            <xsl:apply-templates select="uro:KeyValuePairAttribute"/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="uro:KeyValuePair">
        <xsl:element name="uro:KeyValuePairAttribute">
            <xsl:apply-templates select="@*|node()"/>
        </xsl:element>
    </xsl:template>

    <!-- uro 3.1, Taito City -->
	<xsl:template match="uro:buildingDetailAttribute">
        <xsl:element name="uro:buildingDetailAttribute">
            <xsl:apply-templates select="uro:BuildingDetailAttribute"/>
        </xsl:element>
    </xsl:template>
	<xsl:template match="uro:BuildingDetailAttribute">
        <xsl:element name="uro:BuildingDetailAttribute">
            <xsl:apply-templates select="@*|node()"/>
        </xsl:element>
    </xsl:template>

	<xsl:template match="uro:buildingIDAttribute">
        <xsl:element name="uro:buildingIDAttribute">
            <xsl:apply-templates select="uro:BuildingIDAttribute"/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="uro:BuildingIDAttribute">
        <xsl:element name="uro:BuildingIDAttribute">
            <xsl:apply-templates select="@*|node()"/>
        </xsl:element>
    </xsl:template>

    <xsl:template match="uro:bldgDataQualityAttribute">
        <xsl:element name="uro:buildingDataQualityAttribute">
            <xsl:apply-templates select="uro:DataQualityAttribute"/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="uro:DataQualityAttribute">
        <xsl:element name="uro:BuildingDataQualityAttribute">
            <xsl:apply-templates select="uro:srcScale"/>
            <xsl:apply-templates select="uro:geometrySrcDesc"/>
            <xsl:apply-templates select="uro:geometrySrcDescLod0"/>
            <xsl:apply-templates select="uro:geometrySrcDescLod1"/>
            <xsl:apply-templates select="uro:geometrySrcDescLod2"/>
            <xsl:apply-templates select="uro:geometrySrcDescLod3"/>
            <xsl:apply-templates select="uro:geometrySrcDescLod4"/>
            <xsl:apply-templates select="uro:thematicSrcDesc"/>
            <xsl:apply-templates select="uro:appearanceSrcDesc"/>
            <xsl:apply-templates select="uro:appearanceSrcDescLod0"/>
            <xsl:apply-templates select="uro:appearanceSrcDescLod1"/>
            <xsl:apply-templates select="uro:appearanceSrcDescLod2"/>
            <xsl:apply-templates select="uro:appearanceSrcDescLod3"/>
            <xsl:apply-templates select="uro:appearanceSrcDescLod4"/>
            <xsl:apply-templates select="uro:lod1HeightType"/>
            <xsl:apply-templates select="uro:lodType"/>
            <xsl:apply-templates select="uro:tranDataAccquisition"/>
            <xsl:apply-templates select="uro:publicSurveyDataQualityAttribute"/>
        </xsl:element>
    </xsl:template>
   
    <xsl:template match="uro:bldgDisasterRiskAttribute">
        <xsl:element name="uro:buildingDisasterRiskAttribute">
            <xsl:apply-templates select="@*|node()"/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="uro:DisasterRiskAttribute">
        <xsl:element name="uro:BuildingDisasterRiskAttribute">
            <xsl:apply-templates select="@*|node()"/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="uro:FloodingRiskAttribute">
        <xsl:element name="uro:BuildingFloodingRiskAttribute">
            <xsl:apply-templates select="@*|node()"/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="uro:RiverFloodingRiskAttribute">
        <xsl:element name="uro:BuildingRiverFloodingRiskAttribute">
            <xsl:apply-templates select="@*|node()"/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="uro:TsunamiRiskAttribute">
        <xsl:element name="uro:BuildingTsunamiRiskAttribute">
            <xsl:apply-templates select="@*|node()"/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="uro:HighTideRiskAttribute">
        <xsl:element name="uro:BuildingHighTideRiskAttribute">
            <xsl:apply-templates select="@*|node()"/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="uro:InlandFloodingRiskAttribute">
        <xsl:element name="uro:BuildingInlandFloodingRiskAttribute">
            <xsl:apply-templates select="@*|node()"/>
        </xsl:element>
    </xsl:template>
    <!-- for future implementation
    <xsl:template match="uro:ReservoirFloodingRiskAttribute">
        <xsl:element name="uro:BuildingReservoirFloodingRiskAttribute">
            <xsl:apply-templates select="@*|node()"/>
        </xsl:element>
    </xsl:template> -->
    <xsl:template match="uro:LandSlideRiskAttribute">
        <xsl:element name="uro:BuildingLandSlideRiskAttribute">
            <xsl:apply-templates select="@*|node()"/>
        </xsl:element>
    </xsl:template>

</xsl:stylesheet>
