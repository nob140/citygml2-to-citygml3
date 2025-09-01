/*
 * citygml2-to-citygml3
 *
 * Developer:
 * Son H. Nguyen (son.nguyen@tum.de)
 *
 * With support regarding CityGML encodings from
 * Thomas H. Kolbe (thomas.kolbe@tum.de)
 * Tatjana Kutzner (kutzner@tum.de)
 *
 * MIT License
 *
 * Copyright (c) 2018 Chair of Geoinformatics, Technical University of Munich
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.HashMap;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.TransformerFactoryConfigurationError;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;

// nob140 20250825
import org.w3c.dom.Document;

public class Transform {
	public static final String sourceXMLFile = "INPUT_FILE";
	public static final String sourceXSLFile = "XSL_FILE";
	public static final String outputXMLFile = "OUTPUT_FILE";
	public static final String lod4ToLod3 = "LOD4_TO_LOD3";
	public static final String changeLod4Geometry = "LOD4_GEOMETRY";

	public static HashMap<String, String> SETTINGS = new HashMap<>();

	// nobu140 20250825
	public static String getXsl(String xmlFilename) throws Exception {
        // parse XML file and check namespace
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        factory.setNamespaceAware(true); // to recognize Namespace
        DocumentBuilder builder = factory.newDocumentBuilder();
        Document document = builder.parse(new File(xmlFilename));

        // check uro namespace
        String uroNamespace = document.lookupNamespaceURI("uro");
        if ("http://www.kantei.go.jp/jp/singi/tiiki/toshisaisei/itoshisaisei/iur/uro/1.4".equals(uroNamespace)) {
            return "Transform_uro14.xsl";
        } else if ("https://www.geospatial.jp/iur/uro/3.1".equals(uroNamespace)) {
            return "Transform_uro31.xsl";
        } else {
            System.out.println("Unsupported namespace: " + uroNamespace);
            return "Transform_uro14.xsl"; // return default
        }
	}

	public static void readConfigs(String filename) {
		BufferedReader br = null;
		try {
			br = new BufferedReader(new FileReader(filename));
			String line = "";
			while ((line = br.readLine()) != null) {
				if (line.trim().length() == 0 || line.trim().startsWith("#")) {
					continue;
				}

				String[] ss = line.split("=");
				SETTINGS.put(ss[0], ss[1].replaceAll("\\\\", "/"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				if (br != null) {
					br.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	public static void main(String[] args) throws TransformerFactoryConfigurationError, TransformerException, IOException {
		readConfigs("SETTINGS.txt");

		String sourceXMLFile = SETTINGS.get(Transform.sourceXMLFile);
		String sourceXSLFile = SETTINGS.get(Transform.sourceXSLFile);
		String outputXMLFile = SETTINGS.get(Transform.outputXMLFile);
		String lod4ToLod3 = SETTINGS.get(Transform.lod4ToLod3);
		String changeLod4Geometry = SETTINGS.get(Transform.changeLod4Geometry);

		String outputXMLFile_tmp = "output/Tmp.gml";

		// nob140 20250825 using args to process multiple input files
		if (args.length == 2) {
			System.out.println("2 args: " + args[0] + ", " + args[1]);
			sourceXMLFile = args[0];
			outputXMLFile = args[1];
		}else if (args.length == 3) {
			System.out.println("3 args: " + args[0] + ", " + args[1] + ", " + args[2]);
			sourceXMLFile = args[0];
			sourceXSLFile = args[1];
			outputXMLFile = args[2];
		}

		// nob140 20250818 replace XSLTC to Saxon to avoid 64KB problem
		System.setProperty("javax.xml.transform.TransformerFactory","net.sf.saxon.TransformerFactoryImpl");

		System.out.println("Transforming...");
		long startTime = System.nanoTime();

		// nob140 20250825 replace XSL filename based on the XML's uro version
		try {
			sourceXSLFile = getXsl(sourceXMLFile);
			System.out.println("Using XSL file: " + sourceXSLFile);
		} catch (Exception e){
			System.err.println("Error selecting XSL file: " + e.getMessage());
			e.printStackTrace();
			return; // terminate process
		}

		Source xmlInput = new StreamSource(new File(sourceXMLFile));
		Source xsl = new StreamSource(new File(sourceXSLFile));
		File outputXMLTmp = new File(outputXMLFile_tmp);
		javax.xml.transform.Result xmlOutput = new StreamResult(outputXMLTmp);

		Transformer transformer = TransformerFactory.newInstance().newTransformer(xsl);
		transformer.setParameter("lod4ToLod3", lod4ToLod3);
		transformer.setParameter("changeLod4Geometry", changeLod4Geometry);
		transformer.transform(xmlInput, xmlOutput);

		BufferedReader bReader = new BufferedReader(new java.io.FileReader(outputXMLTmp));
		BufferedWriter bWriter = new BufferedWriter(new FileWriter(new File(outputXMLFile)));

		String line = null;

		// nob140 20250823
		int found = 0;

		String xsdLocation = "https://schemas.opengis.net/citygml/";

		ArrayList<String[]> ns = new ArrayList<>();
		ns.add(new String[] { "app", "http://www.opengis.net/citygml/appearance/3.0", xsdLocation + "appearance/3.0/appearance.xsd" });
		ns.add(new String[] { "bldg", "http://www.opengis.net/citygml/building/3.0", xsdLocation + "building/3.0/building.xsd" });
		ns.add(new String[] { "brid", "http://www.opengis.net/citygml/bridge/3.0", xsdLocation + "bridge/3.0/bridge.xsd" });
		ns.add(new String[] { "con", "http://www.opengis.net/citygml/construction/3.0", xsdLocation + "construction/3.0/construction.xsd" });
		ns.add(new String[] { "core", "http://www.opengis.net/citygml/3.0", xsdLocation + "3.0/core.xsd" });
		//ns.add(new String[] { "dem", "http://www.opengis.net/citygml/relief/3.0", xsdLocation + "relief/3.0/relief.xsd" });
		//ns.add(new String[] { "dyn", "http://www.opengis.net/citygml/dynamizer/3.0", xsdLocation + "dynamizer/3.0/dynamizer.xsd" });
		ns.add(new String[] { "frn", "http://www.opengis.net/citygml/cityfurniture/3.0", xsdLocation + "cityfurniture/3.0/cityFurniture.xsd" });
		ns.add(new String[] { "grp", "http://www.opengis.net/citygml/cityobjectgroup/3.0", xsdLocation + "cityobjectgroup/3.0/cityObjectGroup.xsd" });
		ns.add(new String[] { "gen", "http://www.opengis.net/citygml/generics/3.0", xsdLocation + "generics/3.0/generics.xsd" });
		ns.add(new String[] { "luse", "http://www.opengis.net/citygml/landuse/3.0", xsdLocation + "landuse/3.0/landUse.xsd" });
		//ns.add(new String[] { "pcl", "http://www.opengis.net/citygml/pointcloud/3.0", xsdLocation + "pointcloud/3.0/pointCloud.xsd" });
		ns.add(new String[] { "tran", "http://www.opengis.net/citygml/transportation/3.0", xsdLocation + "transportation/3.0/transportation.xsd" });
		ns.add(new String[] { "tun", "http://www.opengis.net/citygml/tunnel/3.0", xsdLocation + "tunnel/3.0/tunnel.xsd" });
		//ns.add(new String[] { "veg", "http://www.opengis.net/citygml/vegetation/3.0", xsdLocation + "vegetation/3.0/vegetation.xsd" });
		//ns.add(new String[] { "vers", "http://www.opengis.net/citygml/versioning/3.0", xsdLocation + "versioning/3.0/versioning.xsd" });
		ns.add(new String[] { "wtr", "http://www.opengis.net/citygml/waterbody/3.0", xsdLocation + "waterbody/3.0/waterBody.xsd" });

		//nob140 20250816 uro
		ns.add(new String[] { "uro", "https://nob140.github.io/iur-ade-citygml3/uro/3.9", "https://nob140.github.io/iur-ade-citygml3/uro/3.9.0/urbanObject.xsd" });

		//ns.add(new String[] { "tsml", "http://www.opengis.net/tsml/1.0", "http://schemas.opengis.net/tsml/1.0/timeseriesML.xsd" });
		//ns.add(new String[] { "sos", "http://www.opengis.net/sos/2.0", "http://schemas.opengis.net/sos/2.0/sosGetObservation.xsd" });
		//ns.add(new String[] { "xAL", "urn:oasis:names:tc:ciq:xsdschema:xAL:2.0", "http://schemas.opengis.net/citygml/xAL/xAL.xsd" });
		ns.add(new String[] { "xAL", "urn:oasis:names:tc:ciq:xal:3", "http://docs.oasis-open.org/ciq/v3.0/cs02/xsd/default/xsd/xAL.xsd" });
		ns.add(new String[] { "xlink", "http://www.w3.org/1999/xlink", "" });
		ns.add(new String[] { "xsi", "http://www.w3.org/2001/XMLSchema-instance", "" });
		//ns.add(new String[] { "gml", "http://www.opengis.net/gml/3.2", "" });
		ns.add(new String[] { "gml", "http://www.opengis.net/gml/3.2", "http://schemas.opengis.net/gml/3.2.1/gml.xsd" });
		//ns.add(new String[] { "ade", "http://www.3dcitydb.org/citygml-ade/3.0/citygml/1.0", "" });

		// nob140 20250829 avoid using default namespace 
		//ns.add(new String[] { "", "http://www.opengis.net/citygml/3.0", "" });

		while ((line = bReader.readLine()) != null) {
			// nob140 20250823 skip until the end of the first tag to delete unexpected text
			if (found == 1){
				if (line.trim().endsWith(">")) {
					found = 2;
				}
				continue;
			}else

			if ((found == 0) && (line.trim().contains("<CityModel"))) {
				found = 1;

				// nob140 20250829 add core:
				//line = "<CityModel gml:id=\"cm1\" ";
				line = "<core:CityModel gml:id=\"cm1\" ";
				for (int i = 0; i < ns.size(); i++) {
					line += "xmlns" + (ns.get(i)[0].equals("") ? "" : ":") + ns.get(i)[0] + "=\"" + ns.get(i)[1] + "\" ";
				}

				line += "xsi:schemaLocation=\"";
				for (int i = 0; i < ns.size(); i++) {
					line += (ns.get(i)[2].equals("") ? "" : (ns.get(i)[1] + " " + ns.get(i)[2] + " "));
				}

				// Remove the last whitespace
				line = line.substring(0, line.length() - 1);
				line += "\">";
			}

			// nob140 20250829 add core:
			else if ((found == 2) && (line.trim().contains("</CityModel>"))) {
				line = "</core:CityModel>";
			}

			bWriter.write(line);
			bWriter.newLine();
		}

		bReader.close();
		bWriter.close();
		// Remove temp file
		Files.delete(outputXMLTmp.toPath());

		long endTime = System.nanoTime();
		System.out.println("Transformation done in " + ((long) ((endTime - startTime) / 1e6)) / 1000. + " seconds!\n" + "File output: " + outputXMLFile);
	}
}
