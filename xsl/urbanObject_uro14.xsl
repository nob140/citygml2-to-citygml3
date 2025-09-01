<?xml version="1.0" encoding="UTF-8"?>
<!-- nob140 20250824 for Munakata City -->
<xsl:stylesheet 
    version="2.0"
	xmlns:bldg="http://www.opengis.net/citygml/building/2.0"
	xmlns:grp="http://www.opengis.net/citygml/cityobjectgroup/2.0"
	xmlns:con="http://www.opengis.net/citygml/construction/3.0"
	xmlns:core="http://www.opengis.net/citygml/2.0"
	xmlns:gen="http://www.opengis.net/citygml/generics/2.0"
    xmlns:uro="http://www.kantei.go.jp/jp/singi/tiiki/toshisaisei/itoshisaisei/iur/uro/1.4"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xalan="http://xml.apache.org/xslt"
	xmlns:pbase="http://www.opengis.net/citygml/profiles/base/2.0"
	xmlns:smil20lang="http://www.w3.org/2001/SMIL20/Language"
	xmlns:smil20="http://www.w3.org/2001/SMIL20/"
	xmlns:sch="http://www.ascc.net/xml/schematron">

    <!-- nob140 20250823 special cases -->
    <!-- Munakata City -->
	<xsl:template match="uro:buildingDetails">
        <xsl:element name="bldg:adeOfAbstractBuilding">
            <xsl:element name="uro:BuildingProperties">
                <xsl:element name="uro:buildingDetailAttribute">
                    <xsl:apply-templates select="uro:BuildingDetails"/>
                </xsl:element>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    <xsl:template match="uro:BuildingDetails">
        <xsl:element name="uro:BuildingDetailAttribute">
            <xsl:apply-templates select="@*|node()" />
        </xsl:element>
    </xsl:template>

    <xsl:template match="uro:extendedAttribute">
        <xsl:element name="bldg:adeOfAbstractBuilding">
            <xsl:element name="uro:BuildingProperties">
                <xsl:element name="uro:keyValuePairAttribute">
                    <xsl:apply-templates select="uro:KeyValuePair"/>
                </xsl:element>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    <xsl:template match="uro:KeyValuePair">
        <xsl:element name="uro:KeyValuePairAttribute">
            <xsl:apply-templates select="@*|node()" />
        </xsl:element>
    </xsl:template>

    <!-- Taito City -->
	<xsl:template match="uro:buildingIDAttribute">
        <xsl:element name="bldg:adeOfAbstractBuilding">
            <xsl:element name="uro:BuildingProperties">
                <xsl:element name="uro:buildingIDAttribute">
                    <xsl:apply-templates select="uro:BuildingIDAttribute"/>
                </xsl:element>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    <xsl:template match="uro:BuildingIDAttribute">
        <xsl:element name="uro:BuildingIDAttribute">
            <xsl:apply-templates select="@*|node()" />
        </xsl:element>
    </xsl:template>

    <xsl:template match="uro:bldgDataQualityAttribute">
        <xsl:element name="bldg:adeOfAbstractBuilding">
            <xsl:element name="uro:BuildingProperties">
                <xsl:element name="uro:dataQualityAttribute">
                    <xsl:apply-templates select="uro:DataQualityAttribute"/>
                </xsl:element>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    <xsl:template match="uro:DataQualityAttribute">
        <xsl:element name="uro:DataQualityAttribute">
            <xsl:apply-templates select="@*|node()" />
            <xsl:apply-templates select="uro:publicSurveyDataQualityAttribute"/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="uro:publicSurveyDataQualityAttribute">
        <xsl:element name="uro:publicSurveyDataQualityAttribute">
            <xsl:element name="uro:PublicSurveyDataQualityAttribute">
                <xsl:apply-templates select="@*|node()" />
            </xsl:element>
        </xsl:element>
    </xsl:template>

    <xsl:template match="uro:bldgDisasterRiskAttribute">
        <xsl:element name="bldg:adeOfAbstractBuilding">
            <xsl:element name="uro:BuildingProperties">
                <xsl:element name="uro:buildingDisasterRiskAttribute">
                    <xsl:apply-templates select="uro:HighTideRiskAttribute"/>
                    <xsl:apply-templates select="uro:LandSlideRiskAttribute"/>
                    <xsl:apply-templates select="uro:RiverFloodingRiskAttribute"/>
                </xsl:element>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    <xsl:template match="uro:HighTideRiskAttribute">
        <xsl:element name="uro:HighTideRiskAttribute">
            <xsl:apply-templates select="@*|node()" />
        </xsl:element>
    </xsl:template>
    <xsl:template match="uro:LandSlideRiskAttribute">
        <xsl:element name="uro:LandSlideRiskAttribute">
            <xsl:apply-templates select="@*|node()" />
        </xsl:element>
    </xsl:template>
    <xsl:template match="uro:RiverFloodingRiskAttribute">
        <xsl:element name="uro:RiverFloodingRiskAttribute">
            <xsl:apply-templates select="@*|node()" />
        </xsl:element>
    </xsl:template>

</xsl:stylesheet>
