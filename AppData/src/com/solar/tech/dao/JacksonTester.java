package com.solar.tech.dao;
import java.io.IOException;
import java.util.Iterator;
import org.codehaus.jackson.JsonNode;
import org.codehaus.jackson.JsonParseException;
import org.codehaus.jackson.map.JsonMappingException;
import org.codehaus.jackson.map.ObjectMapper;

public class JacksonTester {
	  public static void main(String args[]){
	      JacksonTester tester = new JacksonTester();
	      try {
	         ObjectMapper mapper = new ObjectMapper();
	         String jsonString = "{\"name\":\"Mahesh Kumar\", \"age\":21,\"verified\":false,\"marks\": [100,90,85]}";
	         JsonNode rootNode = mapper.readTree(jsonString);

	         JsonNode nameNode = rootNode.path("name");
	         System.out.println("Name: "+ nameNode.getTextValue());

	         JsonNode ageNode = rootNode.path("age");
	         System.out.println("Age: " + ageNode.getIntValue());

	         JsonNode verifiedNode = rootNode.path("verified");
	         System.out.println("Verified: " + (verifiedNode.getBooleanValue() ? "Yes":"No"));

	         JsonNode marksNode = rootNode.path("marks");
	         Iterator<JsonNode> iterator = marksNode.getElements();
	         System.out.print("Marks: [ ");
	         while (iterator.hasNext()) {
	            JsonNode marks = iterator.next();
	            System.out.print(marks.getIntValue() + " "); 
	         }
	         System.out.println("]");
	      } catch (JsonParseException e) {
	         e.printStackTrace();
	      } catch (JsonMappingException e) {
	         e.printStackTrace();
	      } catch (IOException e) {
	         e.printStackTrace();
	      }
	   }

}
