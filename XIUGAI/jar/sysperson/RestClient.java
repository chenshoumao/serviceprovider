

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.ws.rs.core.MediaType;

import com.sun.jersey.api.client.Client;
import com.sun.jersey.api.client.ClientResponse;
import com.sun.jersey.api.client.WebResource;



public class RestClient {

	
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		try {

			Client client = Client.create();
			WebResource webResource = client.resource("http://localhost:9081/SyncPerson/person/create/addpreson");
			//String input = "{\"singer\":\"Metallica\",\"title\":\"Fade To Black\"}";
		/*	String ixml="<?xml version=\"1.0\" encoding=\"UTF-8\"?>" +
					"<Document>" +
						"<ITEM><ID>10002</ID><CODE>8100120</CODE>" +
						"<NAME>曹永红</NAME><COMPANYCODE>10000103</COMPANYCODE>" +
						"<COMPANYNAME>陕西省煤炭运销（集团）有限责任公司</COMPANYNAME><UNITCODE/><UNITNAME/>" +
						"<POST>核算中心副主任</POST><STATUS>2</STATUS></ITEM><ITEM>" +
						"<ID>10003</ID><CODE>8100120</CODE>" +
						"<NAME>曹永红</NAME><COMPANYCODE>10000103</COMPANYCODE>" +
						"<COMPANYNAME>陕西省煤炭运销（集团）有限责任公司</COMPANYNAME><UNITCODE/><UNITNAME/>" +
						"<POST>核算中心副主任</POST><STATUS>3</STATUS></ITEM><ITEM><ID>10004</ID>" +
						"<CODE>8100120</CODE>" +
						"<NAME>曹永红</NAME><COMPANYCODE>10000103</COMPANYCODE>" +
						"<COMPANYNAME>陕西省煤炭运销（集团）有限责任公司</COMPANYNAME>" +
						"<UNITCODE/><UNITNAME/><POST>核算中心副主任</POST><STATUS>4</STATUS></ITEM></Document>";*/
			
			String ixml="<?xml version=\"1.0\" encoding=\"UTF-8\"?>" +
					"<Document>" +
						"<ITEM><ID>10002</ID><CODE>fff</CODE><MAIL>1223991507@qq.com</MAIL>" +
						"<NAME>CEHNENE</NAME><COMPANYCODE>10000103</COMPANYCODE>" +
						"<COMPANYNAME>陕西省煤炭运销（集团）有限责任公司</COMPANYNAME><UNITCODE/><UNITNAME/>" +
						"<POST>核算中2心副主任</POST><STATUS>2</STATUS></ITEM>" +
					"</Document>";
						
			ClientResponse response = webResource.type("application/xml").post(ClientResponse.class, ixml);
			if (response.getStatus() != 200) {
				throw new RuntimeException("Failed : HTTP error code : "
						+ response.getStatus());
			}
			System.out.println("Output from Server .... \n");
			String output = response.getEntity(String.class);
			System.out.println(output);

		} catch (Exception e) {

			e.printStackTrace();

		}

	}

}
