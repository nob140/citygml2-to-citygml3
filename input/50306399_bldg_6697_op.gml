<?xml version="1.0" encoding="UTF-8"?>
<core:CityModel xmlns:grp="http://www.opengis.net/citygml/cityobjectgroup/2.0" xmlns:core="http://www.opengis.net/citygml/2.0" xmlns:pbase="http://www.opengis.net/citygml/profiles/base/2.0" xmlns:smil20lang="http://www.w3.org/2001/SMIL20/Language" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:smil20="http://www.w3.org/2001/SMIL20/" xmlns:bldg="http://www.opengis.net/citygml/building/2.0" xmlns:xAL="urn:oasis:names:tc:ciq:xsdschema:xAL:2.0" xmlns:uro="http://www.kantei.go.jp/jp/singi/tiiki/toshisaisei/itoshisaisei/iur/uro/1.4" xmlns:luse="http://www.opengis.net/citygml/landuse/2.0" xmlns:app="http://www.opengis.net/citygml/appearance/2.0" xmlns:gen="http://www.opengis.net/citygml/generics/2.0" xmlns:dem="http://www.opengis.net/citygml/relief/2.0" xmlns:tex="http://www.opengis.net/citygml/texturedsurface/2.0" xmlns:tun="http://www.opengis.net/citygml/tunnel/2.0" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:sch="http://www.ascc.net/xml/schematron" xmlns:veg="http://www.opengis.net/citygml/vegetation/2.0" xmlns:frn="http://www.opengis.net/citygml/cityfurniture/2.0" xmlns:gml="http://www.opengis.net/gml" xmlns:tran="http://www.opengis.net/citygml/transportation/2.0" xmlns:wtr="http://www.opengis.net/citygml/waterbody/2.0" xmlns:brid="http://www.opengis.net/citygml/bridge/2.0" xsi:schemaLocation="http://www.kantei.go.jp/jp/singi/tiiki/toshisaisei/itoshisaisei/iur/uro/1.4 http://www.kantei.go.jp/jp/singi/tiiki/toshisaisei/itoshisaisei/iur/schemas/uro/1.4/urbanObject.xsd  http://www.opengis.net/citygml/2.0 http://schemas.opengis.net/citygml/2.0/cityGMLBase.xsd http://www.opengis.net/citygml/landuse/2.0 http://schemas.opengis.net/citygml/landuse/2.0/landUse.xsd  http://www.opengis.net/citygml/building/2.0 http://schemas.opengis.net/citygml/building/2.0/building.xsd  http://www.opengis.net/citygml/transportation/2.0 http://schemas.opengis.net/citygml/transportation/2.0/transportation.xsd  http://www.opengis.net/citygml/generics/2.0 http://schemas.opengis.net/citygml/generics/2.0/generics.xsd  http://www.opengis.net/citygml/relief/2.0 http://schemas.opengis.net/citygml/relief/2.0/relief.xsd  http://www.opengis.net/citygml/cityobjectgroup/2.0 http://schemas.opengis.net/citygml/cityobjectgroup/2.0/cityObjectGroup.xsd  http://www.opengis.net/gml http://schemas.opengis.net/gml/3.1.1/base/gml.xsd http://www.opengis.net/citygml/appearance/2.0 http://schemas.opengis.net/citygml/appearance/2.0/appearance.xsd  ">
	<gml:boundedBy>
		<gml:Envelope srsName="http://www.opengis.net/def/crs/EPSG/0/6697" srsDimension="3">
			<gml:lowerCorner>33.91179167018762 130.48845739843006 56</gml:lowerCorner>
			<gml:upperCorner>33.911838044226855 130.48851301896923 59.19765</gml:upperCorner>
		</gml:Envelope>
	</gml:boundedBy>
	<core:cityObjectMember>
		<bldg:Building gml:id="bldg-904d80e1-c0cc-44a6-bc2f-93bfd0509ed5">
			<gen:stringAttribute name="建物ID">
				<gen:value>40220-bldg-65954</gen:value>
			</gen:stringAttribute>
			<bldg:measuredHeight uom="m">3.5</bldg:measuredHeight>
			<bldg:lod0FootPrint>
				<gml:MultiSurface>
					<gml:surfaceMember>
						<gml:Polygon>
							<gml:exterior>
								<gml:LinearRing>
									<gml:posList>33.911838044226855 130.4884889632338 56 33.91181789715876 130.48845739843006 56 33.91179167018762 130.4884815623071 56 33.911811816800565 130.48851301896923 56 33.911838044226855 130.4884889632338 56</gml:posList>
								</gml:LinearRing>
							</gml:exterior>
						</gml:Polygon>
					</gml:surfaceMember>
				</gml:MultiSurface>
			</bldg:lod0FootPrint>
			<bldg:lod1Solid>
				<gml:Solid>
					<gml:exterior>
						<gml:CompositeSurface>
							<gml:surfaceMember>
								<gml:Polygon>
									<gml:exterior>
										<gml:LinearRing>
											<gml:posList>33.911838044226855 130.4884889632338 56 33.911811816800565 130.48851301896923 56 33.91179167018762 130.4884815623071 56 33.91181789715876 130.48845739843006 56 33.911838044226855 130.4884889632338 56</gml:posList>
										</gml:LinearRing>
									</gml:exterior>
								</gml:Polygon>
							</gml:surfaceMember>
							<gml:surfaceMember>
								<gml:Polygon>
									<gml:exterior>
										<gml:LinearRing>
											<gml:posList>33.911838044226855 130.4884889632338 56 33.91181789715876 130.48845739843006 56 33.91181789715876 130.48845739843006 59.19765 33.911838044226855 130.4884889632338 59.19765 33.911838044226855 130.4884889632338 56</gml:posList>
										</gml:LinearRing>
									</gml:exterior>
								</gml:Polygon>
							</gml:surfaceMember>
							<gml:surfaceMember>
								<gml:Polygon>
									<gml:exterior>
										<gml:LinearRing>
											<gml:posList>33.91181789715876 130.48845739843006 56 33.91179167018762 130.4884815623071 56 33.91179167018762 130.4884815623071 59.19765 33.91181789715876 130.48845739843006 59.19765 33.91181789715876 130.48845739843006 56</gml:posList>
										</gml:LinearRing>
									</gml:exterior>
								</gml:Polygon>
							</gml:surfaceMember>
							<gml:surfaceMember>
								<gml:Polygon>
									<gml:exterior>
										<gml:LinearRing>
											<gml:posList>33.91179167018762 130.4884815623071 56 33.911811816800565 130.48851301896923 56 33.911811816800565 130.48851301896923 59.19765 33.91179167018762 130.4884815623071 59.19765 33.91179167018762 130.4884815623071 56</gml:posList>
										</gml:LinearRing>
									</gml:exterior>
								</gml:Polygon>
							</gml:surfaceMember>
							<gml:surfaceMember>
								<gml:Polygon>
									<gml:exterior>
										<gml:LinearRing>
											<gml:posList>33.911811816800565 130.48851301896923 56 33.911838044226855 130.4884889632338 56 33.911838044226855 130.4884889632338 59.19765 33.911811816800565 130.48851301896923 59.19765 33.911811816800565 130.48851301896923 56</gml:posList>
										</gml:LinearRing>
									</gml:exterior>
								</gml:Polygon>
							</gml:surfaceMember>
							<gml:surfaceMember>
								<gml:Polygon>
									<gml:exterior>
										<gml:LinearRing>
											<gml:posList>33.911838044226855 130.4884889632338 59.19765 33.91181789715876 130.48845739843006 59.19765 33.91179167018762 130.4884815623071 59.19765 33.911811816800565 130.48851301896923 59.19765 33.911838044226855 130.4884889632338 59.19765</gml:posList>
										</gml:LinearRing>
									</gml:exterior>
								</gml:Polygon>
							</gml:surfaceMember>
						</gml:CompositeSurface>
					</gml:exterior>
				</gml:Solid>
			</bldg:lod1Solid>
			<uro:buildingDetails>
				<uro:BuildingDetails>
					<uro:prefecture codeSpace="../../codelists/Common_prefecture.xml">40</uro:prefecture>
					<uro:city codeSpace="../../codelists/Common_localPublicAuthorities.xml">40220</uro:city>
					<uro:surveyYear>2017</uro:surveyYear>
				</uro:BuildingDetails>
			</uro:buildingDetails>
			<uro:extendedAttribute>
				<uro:KeyValuePair>
					<uro:key codeSpace="../../codelists/extendedAttribute_key.xml">2</uro:key>
					<uro:codeValue codeSpace="../../codelists/extendedAttribute_key2.xml">2</uro:codeValue>
				</uro:KeyValuePair>
			</uro:extendedAttribute>
		</bldg:Building>
	</core:cityObjectMember>
</core:CityModel>
