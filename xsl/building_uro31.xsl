<?xml version="1.0" encoding="UTF-8"?>
<!-- 
citygml2-to-citygml3

Developer:
Son H. Nguyen (son.nguyen@tum.de)

With support regarding CityGML encodings from
Thomas H. Kolbe (thomas.kolbe@tum.de)
Tatjana Kutzner (kutzner@tum.de)

MIT License

Copyright (c) 2018 Chair of Geoinformatics, Technical University of Munich

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
-->

<!-- added uro nob140 20250817 -->
<!-- nob140 20250824 for Taito City -->
<xsl:stylesheet
	version="2.0"
	xmlns:app="http://www.opengis.net/citygml/appearance/2.0"
	xmlns:brid="http://www.opengis.net/citygml/bridge/2.0"
	xmlns:bldg="http://www.opengis.net/citygml/building/2.0"
	xmlns:frn="http://www.opengis.net/citygml/cityfurniture/2.0"
	xmlns:grp="http://www.opengis.net/citygml/cityobjectgroup/2.0"
	xmlns:con="http://www.opengis.net/citygml/construction/3.0"
	xmlns:pcl="http://www.opengis.net/citygml/pointcloud/3.0"
	xmlns:core="http://www.opengis.net/citygml/2.0"
	xmlns:dyn="http://www.opengis.net/citygml/dynamizer/3.0"
	xmlns:gen="http://www.opengis.net/citygml/generics/2.0"
	xmlns:luse="http://www.opengis.net/citygml/landuse/2.0"
	xmlns:dem="http://www.opengis.net/citygml/relief/2.0"
	xmlns:tex="http://www.opengis.net/citygml/texturedsurface/2.0"
	xmlns:tran="http://www.opengis.net/citygml/transportation/2.0"
	xmlns:tun="http://www.opengis.net/citygml/tunnel/2.0"
	xmlns:veg="http://www.opengis.net/citygml/vegetation/2.0"
	xmlns:vers="http://www.opengis.net/citygml/versioning/3.0"
	xmlns:wtr="http://www.opengis.net/citygml/waterbody/2.0"
    xmlns:uro="https://www.geospatial.jp/iur/uro/3.1"
	xmlns:tsml="http://www.opengis.net/tsml/1.0"
	xmlns:sos="http://www.opengis.net/sos/2.0"
	xmlns:xAL="urn:oasis:names:tc:ciq:xsdschema:xAL:2.0"
	xmlns:xlink="http://www.w3.org/1999/xlink"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:gml="http://www.opengis.net/gml"
	xmlns:ade="http://www.3dcitydb.org/citygml-ade/3.0/citygml/1.0"
	xmlns="http://www.opengis.net/citygml/2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xalan="http://xml.apache.org/xslt"
	xmlns:pbase="http://www.opengis.net/citygml/profiles/base/2.0"
	xmlns:smil20lang="http://www.w3.org/2001/SMIL20/Language"
	xmlns:smil20="http://www.w3.org/2001/SMIL20/"
	xmlns:sch="http://www.ascc.net/xml/schematron">

	<xsl:template name="bldg:AbstractBuildingType">
		<xsl:call-template name="con:AbstractConstructionType" />

		<xsl:apply-templates select="bldg:class" />
		<xsl:apply-templates select="bldg:function" />
		<xsl:apply-templates select="bldg:usage" />
		<xsl:apply-templates select="bldg:roofType" />
		<xsl:apply-templates select="bldg:storeysAboveGround" />
		<xsl:apply-templates select="bldg:storeysBelowGround" />
		<xsl:apply-templates select="bldg:storeyHeightsAboveGround" />
		<xsl:apply-templates select="bldg:storeyHeightsBelowGround" />

		<xsl:apply-templates select="bldg:buildingConstructiveElement" />

		<!-- rename all OuterBuildingInstallation and InteriorBuildingInstallaion to BuildingInstallation -->
		<xsl:apply-templates select="bldg:outerBuildingInstallation | bldg:interiorBuildingInstallation" />
		
		<!-- move and rename bldg:Room/bldg:roomInstallation/bldg:IntBuildingInstallation to Building/bldg:buildingFurniture/bldg:BuildingInstallation -->
		<xsl:apply-templates select="bldg:interiorRoom/bldg:Room/bldg:roomInstallation/bldg:IntBuildingInstallation" /> <!-- NEW -->

		<xsl:apply-templates select="bldg:interiorRoom" />
		<!-- move bldg:Room/bldg:interiorFurniture/bldg:BuildingFurniture to Building/bldg:buildingFurniture/bldg:BuildingFurniture -->
		<xsl:apply-templates select="bldg:interiorRoom/bldg:Room/bldg:interiorFurniture/bldg:BuildingFurniture" /> <!-- NEW -->
		
		<xsl:apply-templates select="bldg:buildingSubdivision" />

		<xsl:apply-templates select="bldg:address" />

		<xsl:call-template name="bldg:AbstractGenericApplicationPropertyOfAbstractBuilding" />

		<!-- nob140 20250817 Tentative Urban Planning ADE direct implementation, any good way to implement ADE hook here !? -->
		<xsl:if test="uro:*">
			<bldg:adeOfAbstractBuilding>
				<uro:BuildingProperties>
					<!-- nob140 20250824 for Taito City -->
					<xsl:apply-templates select="uro:bldgDataQualityAttribute" />
					<xsl:apply-templates select="uro:buildingDetailAttribute" />

					<!-- nob140 20250824 for Munakata City -->
					<xsl:apply-templates select="uro:buildingDetails" />

					<!-- nob140 20250824 for Taito City -->
					<xsl:apply-templates select="uro:bldgDisasterRiskAttribute" />
					<xsl:apply-templates select="uro:buildingIDAttribute" />

					<!-- nob140 20250824 for Munakata City -->
					<xsl:apply-templates select="uro:extendedAttribute" />

					<!-- nob140 20250824 for Taito City -->
					<xsl:apply-templates select="uro:bldgKeyValuePairAttribute" />
				</uro:BuildingProperties>
			</bldg:adeOfAbstractBuilding>
		</xsl:if>
	</xsl:template>

	<xsl:template name="bldg:AbstractGenericApplicationPropertyOfAbstractBuilding">
	</xsl:template>
	
	<xsl:template match="bldg:Building">
		<xsl:copy>
			<xsl:attribute name="gml:id">
                <xsl:value-of select="@gml:id" />
            </xsl:attribute>
	            
			<xsl:call-template name="bldg:AbstractBuildingType" />
			<xsl:apply-templates select="bldg:consistsOfBuildingPart" />
			<xsl:call-template name="bldg:AbstractGenericApplicationPropertyOfBuilding" />
		</xsl:copy>
	</xsl:template>
	
	<xsl:template name="bldg:AbstractGenericApplicationPropertyOfBuilding">
	</xsl:template>

	<xsl:template match="bldg:yearOfConstruction">
		<xsl:element name="con:dateOfConstruction">
			<xsl:value-of select="concat(text(), '-01-01')" /> <!-- Convert from year to date -->
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="bldg:yearOfDemolition">
		<xsl:element name="con:dateOfDemolition">
			<xsl:value-of select="concat(text(), '-01-01')" /> <!-- Convert from year to date -->
		</xsl:element>
	</xsl:template>

	<xsl:template match="bldg:yearOfRenovation">
		<xsl:element name="con:constructionEvent">
			<xsl:element name="con:event">endOfRenovation</xsl:element>
			<xsl:element name="con:dateOfEvent">
				<xsl:choose>
					<xsl:when test="contains(text(), 'T')">
						<xsl:value-of select="concat(text(), '-01-01')"/> <!-- Convert from year to date -->
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="concat(text(), '-01-01T00:00:00')"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:element>
		</xsl:element>
	</xsl:template>

	<!-- Transform bldg:measuredHeight -->
	<xsl:template match="bldg:measuredHeight">
		<xsl:element name="con:height">
			<xsl:element name="con:Height">
				<xsl:element name="con:highReference">highestRoofEdge</xsl:element>
				<xsl:element name="con:lowReference">lowestGroundPoint</xsl:element>
				<xsl:element name="con:status">measured</xsl:element>
				<xsl:element name="con:value">
					<xsl:if test="@uom">
						<xsl:attribute name="uom">
							<xsl:value-of select="@uom"/>
						</xsl:attribute>
					</xsl:if>
					<xsl:value-of select="text()"/>
				</xsl:element>
			</xsl:element>
		</xsl:element>
	</xsl:template>

	<!-- Change namespace bldg to con -->
	<xsl:template match="bldg:GroundSurface">
		<xsl:element name="con:GroundSurface">
			<xsl:call-template name="con:AbstractConstructionSurfaceType" />
			<xsl:call-template name="con:AbstractGenericApplicationPropertyOfGroundSurface" />
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="bldg:RoofSurface">
		<xsl:element name="con:RoofSurface">
			<xsl:call-template name="con:AbstractConstructionSurfaceType" />
			<xsl:call-template name="con:AbstractGenericApplicationPropertyOfRoofSurface" />
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="bldg:CeilingSurface">
		<xsl:element name="con:CeilingSurface">
			<xsl:call-template name="con:AbstractConstructionSurfaceType" />
			<xsl:call-template name="con:AbstractGenericApplicationPropertyOfCeilingSurface" />
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="bldg:OuterCeilingSurface">
		<xsl:element name="con:OuterCeilingSurface">
			<xsl:call-template name="con:AbstractConstructionSurfaceType" />
			<xsl:call-template name="con:AbstractGenericApplicationPropertyOfOuterCeilingSurface" />
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="bldg:FloorSurface">
		<xsl:element name="con:FloorSurface">
			<xsl:call-template name="con:AbstractConstructionSurfaceType" />
			<xsl:call-template name="con:AbstractGenericApplicationPropertyOfFloorSurface" />
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="bldg:OuterFloorSurface">
		<xsl:element name="con:OuterFloorSurface">
			<xsl:call-template name="con:AbstractConstructionSurfaceType" />
			<xsl:call-template name="con:AbstractGenericApplicationPropertyOfOuterFloorSurface" />
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="bldg:WallSurface">
		<xsl:element name="con:WallSurface">
			<xsl:call-template name="con:AbstractConstructionSurfaceType" />
			<xsl:call-template name="con:AbstractGenericApplicationPropertyOfWallSurface" />
		</xsl:element>
	</xsl:template>

	<xsl:template match="bldg:ClosureSurface">
		<xsl:element name="ClosureSurface">
			<xsl:call-template name="core:AbstractThematicSurfaceType"/>
			<xsl:call-template name="core:AbstractGenericApplicationPropertyOfClosureSurface"/>
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="bldg:InteriorWallSurface">
		<xsl:element name="con:InteriorWallSurface">
			<xsl:call-template name="con:AbstractConstructionSurfaceType" />
			<xsl:call-template name="con:AbstractGenericApplicationPropertyOfInteriorWallSurface" />
		</xsl:element>
	</xsl:template>
	
<!-- 	<xsl:template match="bldg:Door"> -->
<!-- 		<xsl:element name="con:DoorSurface"> -->
<!-- 			<xsl:apply-templates select="@*|node()" /> -->
<!-- 			<xsl:call-template name="con:AbstractConstructionSurfaceType" /> -->
<!-- 			<xsl:apply-templates select="bldg:address" /> -->
<!-- 			<xsl:call-template name="con:AbstractGenericApplicationPropertyOfDoorSurface" /> -->
<!-- 		</xsl:element> -->
<!-- 	</xsl:template> -->
	
<!-- 	<xsl:template match="bldg:Window"> -->
<!-- 		<xsl:element name="con:WindowSurface"> -->
<!-- 			<xsl:apply-templates select="@*|node()" /> -->
<!-- 			<xsl:call-template name="con:AbstractConstructionSurfaceType" /> -->
<!-- 			<xsl:call-template name="con:AbstractGenericApplicationPropertyOfWindowSurface" /> -->
<!-- 		</xsl:element> -->
<!-- 	</xsl:template> -->
	
	<xsl:template match="bldg:Door">
		<xsl:element name="con:DoorSurface">
			<xsl:call-template name="con:AbstractConstructiveElementType" />
			<xsl:apply-templates select="bldg:address" />
			<xsl:call-template name="con:AbstractGenericApplicationPropertyOfDoor" />
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="bldg:Window">
		<xsl:element name="con:WindowSurface">
			<xsl:call-template name="con:AbstractConstructiveElementType" />
			<xsl:call-template name="con:AbstractGenericApplicationPropertyOfWindow" />
		</xsl:element>
	</xsl:template>

	<xsl:template match="bldg:opening">
		<xsl:element name="con:fillingSurface">
			<xsl:apply-templates select="bldg:Door" />
			<xsl:apply-templates select="bldg:Window" />
			<xsl:call-template name="gml:AbstractFeatureMemberType" />
			<xsl:call-template name="gml:AssociationAttributeGroup" />
		</xsl:element>
	</xsl:template>
    
    <!-- Change gml:CompositeSurface to gml:Shell -->
	<xsl:template match="gml:exterior/gml:CompositeSurface">
		<xsl:element name="gml:Shell">
			<xsl:apply-templates select="@*|node()" />
		</xsl:element>
	</xsl:template>

    <!-- Remove namespace bldg of lodXMultiSurface -->
	<xsl:template match="bldg:lod1MultiSurface">
		<!-- nob140 20250829 add core: -->
		<xsl:element name="core:lod1MultiSurface">
			<xsl:apply-templates select="@*|node()" />
		</xsl:element>
	</xsl:template>

	<xsl:template match="bldg:lod2MultiSurface">
		<!-- nob140 20250829 add core: -->
		<xsl:element name="core:lod2MultiSurface">
			<xsl:apply-templates select="@*|node()" />
		</xsl:element>
	</xsl:template>

	<xsl:template match="bldg:lod3MultiSurface">
		<!-- nob140 20250829 add core: -->
		<xsl:element name="core:lod3MultiSurface">
			<xsl:apply-templates select="@*|node()" />
		</xsl:element>
	</xsl:template>
	
	<!-- Change or remove all LOD4 to LOD3 depending on the parameter lod4ToLod3 -->
	<xsl:template match="bldg:lod4MultiSurface">
		<xsl:if test="$lod4ToLod3='true'">
			<!-- nob140 20250829 add core: -->
			<xsl:element name="core:lod3MultiSurface">
				<xsl:apply-templates select="@*|node()" />
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="bldg:lod0Footprint">
		<!-- nob140 20250829 add core: -->
		<xsl:element name="core:lod0MultiSurface">
			<xsl:apply-templates select="@*|node()" />
		</xsl:element>
	</xsl:template>

	<xsl:template match="bldg:lod1Solid">
		<!-- nob140 20250829 add core: -->
		<xsl:element name="core:lod1Solid">
			<xsl:apply-templates select="@*|node()" />
		</xsl:element>
	</xsl:template>

	<xsl:template match="bldg:lod2Solid">
		<!-- nob140 20250829 add core: -->
		<xsl:element name="core:lod2Solid">
			<xsl:apply-templates select="@*|node()" />
		</xsl:element>
	</xsl:template>

	<xsl:template match="bldg:lod3Solid">
		<!-- nob140 20250829 add core: -->
		<xsl:element name="core:lod3Solid">
			<xsl:apply-templates select="@*|node()" />
		</xsl:element>
	</xsl:template>
	
	<!-- Change all LOD4 to LOD3 -->
	<xsl:template match="bldg:lod4Solid">
		<xsl:if test="$lod4ToLod3='true'">
			<!-- nob140 20250829 add core: -->
			<xsl:element name="core:lod3Solid">
				<xsl:apply-templates select="@*|node()" />
			</xsl:element>
		</xsl:if>
	</xsl:template>
	
	<!-- Change all lod4Geometry to either lod3MultiSurface, lod3MultiCurve or lod3Solid -->
	<xsl:template match="bldg:lod4Geometry">
		<xsl:element name="{$changeLod4Geometry}">
			<xsl:apply-templates select="@*|node()" />
		</xsl:element>
	</xsl:template>

	<xsl:template match="bldg:boundedBy">
		<!-- nob140 20250829 add core:-->
		<xsl:element name="core:boundary">
			<xsl:apply-templates select="@*|node()" />
		</xsl:element>
	</xsl:template>

	<xsl:template match="bldg:consistsOfBuildingPart">
		<xsl:apply-templates select="bldg:BuildingPart" />
	</xsl:template>

	<xsl:template match="bldg:BuildingPart">
		<xsl:element name="bldg:buildingPart">
			<xsl:element name="bldg:BuildingPart">
                <xsl:attribute name="gml:id">
                    <xsl:value-of select="@gml:id" />
                </xsl:attribute>
                <xsl:call-template name="bldg:AbstractBuildingType" />
                <xsl:call-template name="bldg:AbstractGenericApplicationPropertyOfBuildingPart" />
			</xsl:element>
		</xsl:element>
	</xsl:template>

    <xsl:template name="bldg:AbstractGenericApplicationPropertyOfBuildingPart">
    </xsl:template>
	
	<xsl:template match="bldg:interiorRoom">
		<xsl:element name="bldg:buildingRoom">
			<xsl:call-template name="gml:AbstractFeatureMemberType" />
			<xsl:apply-templates select="bldg:Room" />
		</xsl:element>
	</xsl:template>
	
	<xsl:template match="bldg:Room">
		<xsl:element name="bldg:BuildingRoom">
			<xsl:call-template name="core:AbstractUnoccupiedSpaceType" />
			<xsl:apply-templates select="bldg:class" />
			<xsl:apply-templates select="bldg:function" />
			<xsl:apply-templates select="bldg:usage" />
			<xsl:apply-templates select="bldg:RoomHeight" /> <!-- NEW TODO -->
			<xsl:apply-templates select="bldg:interiorFurniture" />
			<xsl:apply-templates select="bldg:roomInstallation" />
			<xsl:call-template name="bldg:AbstractGenericApplicationPropertyOfRoom" />
		</xsl:element>
	</xsl:template>
	
	<xsl:template name="bldg:AbstractGenericApplicationPropertyOfRoom">
	</xsl:template>
	
	<!-- Add xlink -->
	<xsl:template match="bldg:interiorFurniture">
		<xsl:element name="bldg:buildingFurniture">
			<xsl:attribute name="xlink:href">
				<xsl:value-of select="./bldg:BuildingFurniture/@gml:id" />
			</xsl:attribute>
			<xsl:call-template name="gml:AbstractFeatureMemberType" />
			<xsl:call-template name="gml:AssociationAttributeGroup" />
		</xsl:element>
	</xsl:template>
	
	<!-- Move bldg:BuildingFurniture to Building/bldg:buildingFurniture -->
	<xsl:template match="bldg:interiorRoom/bldg:Room/bldg:interiorFurniture/bldg:BuildingFurniture">
		<xsl:element name="bldg:buildingFurniture">
			<xsl:copy>
				<!-- Order of elements changed -->
				<xsl:call-template name="con:AbstractFurnitureType" />
				<xsl:apply-templates select="bldg:class" />
				<xsl:apply-templates select="bldg:function" />
				<xsl:apply-templates select="bldg:usage" />
				<xsl:call-template name="bldg:AbstractGenericApplicationPropertyOfBuildingFurniture" />
			</xsl:copy>
		</xsl:element>
	</xsl:template>

	<xsl:template match="bldg:buildingSubdivision">
		<xsl:call-template name="bldg:AbstractBuildingSubdivisionType" />
	</xsl:template>

	<xsl:template name="bldg:AbstractBuildingSubdivisionType">
		<xsl:call-template name="core:AbstractLogicalSpaceType" />
		<xsl:apply-templates select="bldg:class" />
		<xsl:apply-templates select="bldg:function" />
		<xsl:apply-templates select="bldg:elevation" />
		<xsl:apply-templates select="bldg:sortKey" />
		<xsl:apply-templates select="bldg:buildingConstructiveElement" />
		<xsl:apply-templates select="bldg:buildingFurniture" />
		<xsl:apply-templates select="bldg:buildingInstallation" />
		<xsl:apply-templates select="bldg:buildingRoom" />
		<xsl:call-template name="bldg:AbstractGenericApplicationPropertyOfAbstractBuildingSubdivision" />
	</xsl:template>

	<xsl:template name="bldg:AbstractGenericApplicationPropertyOfAbstractBuildingSubdivision">
	</xsl:template>

	<xsl:template match="bldg:outerBuildingInstallation">
		<xsl:for-each select="./bldg:BuildingInstallation">
			<xsl:call-template name="transformBuildingInstallation" />
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="bldg:interiorBuildingInstallation">
		<xsl:for-each select="./bldg:BuildingInstallation">
			<xsl:call-template name="transformBuildingInstallation" />
		</xsl:for-each>
	</xsl:template>
	
	<!-- Add xlink -->
	<xsl:template match="bldg:roomInstallation">
		<xsl:element name="bldg:buildingInstallation">
			<xsl:attribute name="xlink:href">
				<xsl:value-of select="./bldg:IntBuildingInstallation/@gml:id" />
			</xsl:attribute>
			<xsl:call-template name="gml:AbstractFeatureMemberType" />
			<xsl:call-template name="gml:AssociationAttributeGroup" />
		</xsl:element>
	</xsl:template>
	
	<!-- Move and rename bldg:IntBuildingInstallation to Building/bldg:buildingInstallation/bldg:BuildingInstallation -->
	<xsl:template match="bldg:interiorRoom/bldg:Room/bldg:roomInstallation/bldg:IntBuildingInstallation">
		<xsl:call-template name="transformBuildingInstallation" />
	</xsl:template>

	<xsl:template name="transformBuildingInstallation">
		<xsl:element name="bldg:buildingInstallation">
			<xsl:element name="bldg:BuildingInstallation">
				<!-- Order of elements changed -->
				<xsl:call-template name="con:AbstractInstallationType" />
				<xsl:apply-templates select="bldg:class" />
				<xsl:apply-templates select="bldg:function" />
				<xsl:apply-templates select="bldg:usage" />
				<xsl:call-template name="bldg:AbstractGenericApplicationPropertyOfBuildingInstallation" />
			</xsl:element>
		</xsl:element>
	</xsl:template>

	<xsl:template match="bldg:lod1Geometry">
		<xsl:choose>
			<!-- A Space in CityGML 3.0 does not allow a single surface,
			so that single surfaces such as CompositeSurface, Surface, Polygon, OrientableSurface
			and subclasses of Surface, namely TriangulatedSurface and TIN must be transformed to
			<gml:MultiSurface>
				<gml:surfaceMember>
					<the object here />
				</gml:surfaceMember>
			</gml:MultiSurface> -->
			<xsl:when test="gml:CompositeSurface | gml:Surface | gml:Polygon | gml:OrientableSurface | gml:TriangulatedSurface | gml:TIN">
				<!-- nob140 20250829 add core: -->
				<xsl:element name="core:lod1MultiSurface">
					<xsl:element name="gml:MultiSurface">
						<xsl:attribute name="gml:id">
							<xsl:value-of select="concat('_msl_', generate-id())" />
						</xsl:attribute>
						<xsl:element name="gml:surfaceMember">
							<xsl:apply-templates select="@*|node()" />
						</xsl:element>
					</xsl:element>
				</xsl:element>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<!-- If this is a gml:Solid or gml:CompositeSolid, then rename to lodXSolid -->
					<xsl:when test="gml:Solid | gml:CompositeSolid">
						<!-- nob140 20250829 add core: -->
						<xsl:element name="core:lod1Solid">
							<xsl:apply-templates select="@*|node()" />
						</xsl:element>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<!-- If this is a gml:MultiCurve, then rename to lodXMultiCurve -->
							<xsl:when test="gml:MultiCurve">
								<!-- nob140 20250829 add core: -->
								<xsl:element name="core:lod1MultiCurve">
									<xsl:apply-templates select="@*|node()" />
								</xsl:element>
							</xsl:when>
							<xsl:otherwise>
								<!-- If this is a gml:MultiSurface, then rename to lodXMultiSurface -->
								<xsl:if test="gml:MultiSurface">
									<!-- nob140 20250829 add core: -->
									<xsl:element name="core:lod1MultiSurface">
										<xsl:apply-templates select="@*|node()" />
									</xsl:element>
								</xsl:if>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="bldg:lod2Geometry">
		<xsl:choose>
			<!-- A Space in CityGML 3.0 does not allow a single surface,
			so that single surfaces such as CompositeSurface, Surface, Polygon, OrientableSurface
			and subclasses of Surface, namely TriangulatedSurface and TIN must be transformed to
			<gml:MultiSurface>
				<gml:surfaceMember>
					<the object here />
				</gml:surfaceMember>
			</gml:MultiSurface> -->
			<xsl:when test="gml:CompositeSurface | gml:Surface | gml:Polygon | gml:OrientableSurface | gml:TriangulatedSurface | gml:TIN">
				<!-- nob140 20250829 add core: -->
				<xsl:element name="core:lod2MultiSurface">
					<xsl:element name="gml:MultiSurface">
						<xsl:attribute name="gml:id">
							<xsl:value-of select="concat('_msl_', generate-id())" />
						</xsl:attribute>
						<xsl:element name="gml:surfaceMember">
							<xsl:apply-templates select="@*|node()" />
						</xsl:element>
					</xsl:element>
				</xsl:element>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<!-- If this is a gml:Solid or gml:CompositeSolid, then rename to lodXSolid -->
					<xsl:when test="gml:Solid | gml:CompositeSolid">
						<!-- nob140 20250829 add core: -->
						<xsl:element name="core:lod2Solid">
							<xsl:apply-templates select="@*|node()" />
						</xsl:element>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<!-- If this is a gml:MultiCurve, then rename to lodXMultiCurve -->
							<xsl:when test="gml:MultiCurve">
								<!-- nob140 20250829 add core: -->
								<xsl:element name="core:lod2MultiCurve">
									<xsl:apply-templates select="@*|node()" />
								</xsl:element>
							</xsl:when>
							<xsl:otherwise>
								<!-- If this is a gml:MultiSurface, then rename to lodXMultiSurface -->
								<xsl:if test="gml:MultiSurface">
									<!-- nob140 20250829 add core: -->
									<xsl:element name="core:lod2MultiSurface">
										<xsl:apply-templates select="@*|node()" />
									</xsl:element>
								</xsl:if>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<xsl:template match="bldg:lod3Geometry">
		<xsl:choose>
			<!-- A Space in CityGML 3.0 does not allow a single surface,
			so that single surfaces such as CompositeSurface, Surface, Polygon, OrientableSurface
			and subclasses of Surface, namely TriangulatedSurface and TIN must be transformed to
			<gml:MultiSurface>
				<gml:surfaceMember>
					<the object here />
				</gml:surfaceMember>
			</gml:MultiSurface> -->
			<xsl:when test="gml:CompositeSurface | gml:Surface | gml:Polygon | gml:OrientableSurface | gml:TriangulatedSurface | gml:TIN">
				<!-- nob140 20250829 add core: -->
				<xsl:element name="core:lod3MultiSurface">
					<xsl:element name="gml:MultiSurface">
						<xsl:attribute name="gml:id">
							<xsl:value-of select="concat('_msl_', generate-id())" />
						</xsl:attribute>
						<xsl:element name="gml:surfaceMember">
							<xsl:apply-templates select="@*|node()" />
						</xsl:element>
					</xsl:element>
				</xsl:element>
			</xsl:when>
			<xsl:otherwise>
				<xsl:choose>
					<!-- If this is a gml:Solid or gml:CompositeSolid, then rename to lodXSolid -->
					<xsl:when test="gml:Solid | gml:CompositeSolid">
						<!-- nob140 20250829 add core: -->
						<xsl:element name="core:lod3Solid">
							<xsl:apply-templates select="@*|node()" />
						</xsl:element>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<!-- If this is a gml:MultiCurve, then rename to lodXMultiCurve -->
							<xsl:when test="gml:MultiCurve">
								<!-- nob140 20250829 add core: -->
								<xsl:element name="core:lod3MultiCurve">
									<xsl:apply-templates select="@*|node()" />
								</xsl:element>
							</xsl:when>
							<xsl:otherwise>
								<!-- If this is a gml:MultiSurface, then rename to lodXMultiSurface -->
								<xsl:if test="gml:MultiSurface">
									<!-- nob140 20250829 add core: -->
									<xsl:element name="core:lod3MultiSurface">
										<xsl:apply-templates select="@*|node()" />
									</xsl:element>
								</xsl:if>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>

	<!-- Change or remove all LOD4 to LOD3 depending on the parameter lod4ToLod3 -->
	<xsl:template match="bldg:lod4Geometry">
		<xsl:if test="$lod4ToLod3='true'">
			<xsl:choose>
				<!-- A Space in CityGML 3.0 does not allow a single surface,
                so that single surfaces such as CompositeSurface, Surface, Polygon, OrientableSurface
                and subclasses of Surface, namely TriangulatedSurface and TIN must be transformed to
                <gml:MultiSurface>
                    <gml:surfaceMember>
                        <the object here />
                    </gml:surfaceMember>
                </gml:MultiSurface> -->
				<xsl:when test="gml:CompositeSurface | gml:Surface | gml:Polygon | gml:OrientableSurface | gml:TriangulatedSurface | gml:TIN">
					<!-- nob140 20250829 add core: -->
					<xsl:element name="core:lod3MultiSurface">
						<xsl:element name="gml:MultiSurface">
							<xsl:attribute name="gml:id">
								<xsl:value-of select="concat('_msl_', generate-id())" />
							</xsl:attribute>
							<xsl:element name="gml:surfaceMember">
								<xsl:apply-templates select="@*|node()" />
							</xsl:element>
						</xsl:element>
					</xsl:element>
				</xsl:when>
				<xsl:otherwise>
					<xsl:choose>
						<!-- If this is a gml:Solid or gml:CompositeSolid, then rename to lodXSolid -->
						<xsl:when test="gml:Solid | gml:CompositeSolid">
							<!-- nob140 20250829 add core: -->
							<xsl:element name="core:lod3Solid">
								<xsl:apply-templates select="@*|node()" />
							</xsl:element>
						</xsl:when>
						<xsl:otherwise>
							<xsl:choose>
								<!-- If this is a gml:MultiCurve, then rename to lodXMultiCurve -->
								<xsl:when test="gml:MultiCurve">
									<!-- nob140 20250829 add core: -->
									<xsl:element name="core:lod3MultiCurve">
										<xsl:apply-templates select="@*|node()" />
									</xsl:element>
								</xsl:when>
								<xsl:otherwise>
									<!-- If this is a gml:MultiSurface, then rename to lodXMultiSurface -->
									<xsl:if test="gml:MultiSurface">
										<!-- nob140 20250829 add core: -->
										<xsl:element name="core:lod3MultiSurface">
											<xsl:apply-templates select="@*|node()" />
										</xsl:element>
									</xsl:if>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="bldg:AbstractGenericApplicationPropertyOfBuildingFurniture">
	</xsl:template>
	
	<xsl:template name="bldg:AbstractGenericApplicationPropertyOfBuildingInstallation">
	</xsl:template>

	<xsl:template match="bldg:lod1TerrainIntersectionCurve | bldg:lod2TerrainIntersectionCurve | bldg:lod3TerrainIntersectionCurve">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()" />
		</xsl:copy>
	</xsl:template>

	<!-- nob140 20250825 -->
	<xsl:template match="bldg:address">
		<xsl:element name="bldg:address">
			<xsl:apply-templates select="core:Address" />
		</xsl:element>
	</xsl:template>

	<!-- Change or remove all LOD4 to LOD3 depending on the parameter lod4ToLod3 -->
	<xsl:template match="bldg:lod4TerrainIntersectionCurve">
		<xsl:if test="$lod4ToLod3='true'">
			<xsl:element name="bldg:lod3TerrainIntersectionCurve">
				<xsl:apply-templates select="@*|node()" />
			</xsl:element>
		</xsl:if>
	</xsl:template>
	
	<!-- ++++++++++++++++++++++++++++++++++++++++ -->
	<!-- +++++++++++++++++ COPY +++++++++++++++++ -->
	<!-- ++++++++++++++++++++++++++++++++++++++++ -->
<!-- nob140 20250825
	<xsl:template match="bldg:class | 
						bldg:function | 
						bldg:usage | 
						bldg:roofType | 
						bldg:conditionOfConstruction | 
						bldg:elevation | 
						bldg:storeysAboveGround | 
						bldg:storeysBelowGround | 
						bldg:storeyHeightsAboveGround | 
						bldg:storeyHeightsBelowGround | 
						bldg:address">
-->
	<xsl:template match="bldg:class | 
						bldg:function | 
						bldg:usage | 
						bldg:roofType | 
						bldg:conditionOfConstruction | 
						bldg:elevation | 
						bldg:storeysAboveGround | 
						bldg:storeysBelowGround | 
						bldg:storeyHeightsAboveGround | 
						bldg:storeyHeightsBelowGround">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()" />
		</xsl:copy>
	</xsl:template>
	
	<!-- ++++++++++++++++++++++++++++++++++++++++ -->
	<!-- ++++++++++++++++ REMOVE ++++++++++++++++ -->
	<!-- ++++++++++++++++++++++++++++++++++++++++ -->
	<xsl:template match="bldg:lod0FootPrint | 
						bldg:lod0RoofEdge | 
						bldg:lod4MultiCurve" />

</xsl:stylesheet>
