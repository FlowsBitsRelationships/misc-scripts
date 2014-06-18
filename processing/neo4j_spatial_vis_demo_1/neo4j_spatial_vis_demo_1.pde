import com.francisli.processing.http.*;
import com.francisli.processing.http.JSONObject;
import processing.net.*; 
import java.util.Map;

HttpClient client;
Node_Factory nodester;
HashMap<String,String> hm = new HashMap<String,String>();

void setup(){
  size(800, 800);
  background(25);
  
  client = new HttpClient(this, "sg20141.sb02.stations.graphenedb.com", 24789);
  nodester = new Node_Factory();
  
  // Get all nodes
  //hm.put("query", "start n = node:tweets_1('withinDistance:[22.280893,114.173035,5.0]') return n.text");
  //client.POST("/db/data/cypher", hm );
  client.GET("/db/data/ext/SpatialPlugin");
}

// The http library provides this method to receive an HttpResponse
void responseReceived(HttpRequest request, HttpResponse response) {
  JSONObject queryresult = response.getContentAsJSONObject();
  println ("Received!");
  println(response.statusMessage);

}

void draw(){}

