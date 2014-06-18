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
  
  client = new HttpClient(this, "localhost", 7474);
  nodester = new Node_Factory();
  
  // Get all nodes
  hm.put("query", "MATCH (n) RETURN n");
  client.POST("/db/data/cypher", hm );
  
  // Get all relationships
  hm.put("query", "MATCH (n)-[r]->() RETURN r AS rels");
  client.POST("/db/data/cypher", hm );
}

// The http library provides this method to receive an HttpResponse
void responseReceived(HttpRequest request, HttpResponse response) {
  JSONObject queryresult = response.getContentAsJSONObject();
  
  // When a queryresult is received, call the appropriate Node_Factory method
  if (queryresult.get("data").get(0).get(0).get("start") != null){
    println ("RELATIONSHIPS!");
    nodester.make_relationships(queryresult);
  }else{
    println ("NODES!");
    nodester.make_nodes(queryresult);
  }
}

void draw(){}

