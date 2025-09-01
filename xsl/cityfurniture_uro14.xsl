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
	xmlns:uro="http://www.kantei.go.jp/jp/singi/tiiki/toshisaisei/itoshisaisei/iur/uro/1.4"
	xmlns:tsml="http://www.opengis.net/tsml/1.0"
	xmlns:sos="http://www.opengis.net/sos/2.0"
	xmlns:xAL="urn:oasis:names:tc:ciq:xsdschema:xAL:2.0"
	xmlns:xlink="http://www.w3.org/1999/xlink"
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xmlns:gml="http://www.opengis.net/gml"
	xmlns:ade="http://www.3dcitydb.org/citygml-ade/3.0/citygml/1.0"
	xmlns="http://www.opengis.net/citygml/2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xalan="http://xml.apache.org/xslt">

	<xsl:template match="frn:CityFurniture">
		<xsl:copy>
			<xsl:attribute name="gml:id">
                <xsl:value-of select="@gml:id" />
            </xsl:attribute>

			<xsl:call-template name="core:AbstractOccupiedSpaceType" />

			<xsl:apply-templates select="frn:class" />
			<xsl:apply-templates select="frn:function" />
			<xsl:apply-templates select="frn:usage" />

			<xsl:call-template name="frn:AbstractGenericApplicationPropertyOfCityFurniture" />
		</xsl:copy>
	</xsl:template>
	
	<xsl:template name="frn:AbstractGenericApplicationPropertyOfCityFurniture">
	</xsl:template>

	<xsl:template match="frn:lod1TerrainIntersection">
		<xsl:element name="lod1TerrainIntersectionCurve">
			<xsl:apply-templates select="@*|node()" />
		</xsl:element>
	</xsl:template>

	<xsl:template match="frn:lod2TerrainIntersection">
		<xsl:element name="lod2TerrainIntersectionCurve">
			<xsl:apply-templates select="@*|node()" />
		</xsl:element>
	</xsl:template>

	<xsl:template match="frn:lod3TerrainIntersection">
		<xsl:element name="lod3TerrainIntersectionCurve">
			<xsl:apply-templates select="@*|node()" />
		</xsl:element>
	</xsl:template>

	<!-- Change or remove all LOD4 to LOD3 depending on the parameter lod4ToLod3 -->
	<xsl:template match="frn:lod4TerrainIntersection">
		<xsl:if test="$lod4ToLod3='true'">
			<xsl:element name="lod3TerrainIntersectionCurve">
				<xsl:apply-templates select="@*|node()" />
			</xsl:element>
		</xsl:if>
	</xsl:template>

	<xsl:template match="frn:lod1ImplicitRepresentation">
		<xsl:for-each select="./*">
			<xsl:element name="lod1ImplicitRepresentation">
				<xsl:call-template name="core:ImplicitGeometryType" />
			</xsl:element>
		</xsl:for-each>
	</xsl:template>

	<xsl:template match="frn:lod2ImplicitRepresentation">
		<xsl:element name="lod2ImplicitRepresentation">
			<xsl:for-each select="./*">
				<xsl:element name="ImplicitGeometry">
					<xsl:call-template name="core:ImplicitGeometryType"/>
				</xsl:element>
			</xsl:for-each>
		</xsl:element>
	</xsl:template>

	<xsl:template match="frn:lod3ImplicitRepresentation">
		<xsl:for-each select="./*">
			<xsl:element name="lod3ImplicitRepresentation">
				<xsl:call-template name="core:ImplicitGeometryType" />
			</xsl:element>
		</xsl:for-each>
	</xsl:template>

	<!-- Change or remove all LOD4 to LOD3 depending on the parameter lod4ToLod3 -->
	<xsl:template match="frn:lod4ImplicitRepresentation">
		<xsl:if test="$lod4ToLod3='true'">
			<xsl:for-each select="./*">
				<xsl:element name="lod3ImplicitRepresentation">
					<xsl:call-template name="core:ImplicitGeometryType" />
				</xsl:element>
			</xsl:for-each>
		</xsl:if>
	</xsl:template>

	<xsl:template match="frn:lod1Geometry">
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
				<xsl:element name="lod1MultiSurface">
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
						<xsl:element name="lod1Solid">
							<xsl:apply-templates select="@*|node()" />
						</xsl:element>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<!-- If this is a gml:MultiCurve, then rename to lodXMultiCurve -->
							<xsl:when test="gml:MultiCurve">
								<xsl:element name="lod1MultiCurve">
									<xsl:apply-templates select="@*|node()" />
								</xsl:element>
							</xsl:when>
							<xsl:otherwise>
								<!-- If this is a gml:MultiSurface, then rename to lodXMultiSurface -->
								<xsl:if test="gml:MultiSurface">
									<xsl:element name="lod1MultiSurface">
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

	<xsl:template match="frn:lod2Geometry">
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
				<xsl:element name="lod2MultiSurface">
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
						<xsl:element name="lod2Solid">
							<xsl:apply-templates select="@*|node()" />
						</xsl:element>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<!-- If this is a gml:MultiCurve, then rename to lodXMultiCurve -->
							<xsl:when test="gml:MultiCurve">
								<xsl:element name="lod2MultiCurve">
									<xsl:apply-templates select="@*|node()" />
								</xsl:element>
							</xsl:when>
							<xsl:otherwise>
								<!-- If this is a gml:MultiSurface, then rename to lodXMultiSurface -->
								<xsl:if test="gml:MultiSurface">
									<xsl:element name="lod2MultiSurface">
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

	<xsl:template match="frn:lod3Geometry">
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
				<xsl:element name="lod3MultiSurface">
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
						<xsl:element name="lod3Solid">
							<xsl:apply-templates select="@*|node()" />
						</xsl:element>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<!-- If this is a gml:MultiCurve, then rename to lodXMultiCurve -->
							<xsl:when test="gml:MultiCurve">
								<xsl:element name="lod3MultiCurve">
									<xsl:apply-templates select="@*|node()" />
								</xsl:element>
							</xsl:when>
							<xsl:otherwise>
								<!-- If this is a gml:MultiSurface, then rename to lodXMultiSurface -->
								<xsl:if test="gml:MultiSurface">
									<xsl:element name="lod3MultiSurface">
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
	<xsl:template match="frn:lod4Geometry">
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
					<xsl:element name="lod3MultiSurface">
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
							<xsl:element name="lod3Solid">
								<xsl:apply-templates select="@*|node()" />
							</xsl:element>
						</xsl:when>
						<xsl:otherwise>
							<xsl:choose>
								<!-- If this is a gml:MultiCurve, then rename to lodXMultiCurve -->
								<xsl:when test="gml:MultiCurve">
									<xsl:element name="lod3MultiCurve">
										<xsl:apply-templates select="@*|node()" />
									</xsl:element>
								</xsl:when>
								<xsl:otherwise>
									<!-- If this is a gml:MultiSurface, then rename to lodXMultiSurface -->
									<xsl:if test="gml:MultiSurface">
										<xsl:element name="lod3MultiSurface">
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
	
	<!-- ++++++++++++++++++++++++++++++++++++++++ -->
	<!-- +++++++++++++++++ COPY +++++++++++++++++ -->
	<!-- ++++++++++++++++++++++++++++++++++++++++ -->
	<xsl:template match="frn:class |
						frn:function |
						frn:usage">
		<xsl:copy>
			<xsl:apply-templates select="@*|node()" />
		</xsl:copy>
	</xsl:template>
	
	<!-- ++++++++++++++++++++++++++++++++++++++++ -->
	<!-- ++++++++++++++++ REMOVE ++++++++++++++++ -->
	<!-- ++++++++++++++++++++++++++++++++++++++++ -->
	<!-- <xsl:template match="" /> -->

</xsl:stylesheet>
