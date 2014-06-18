// Hashmap of node ids to nodes. 
// Global used by Node_Factory and Relationships
HashMap<String,Node> nm = new HashMap<String,Node>();

// A class for making nodes and relationships
class Node_Factory{
  
  Node_Factory(){}
  
  void make_nodes(JSONObject queryresult){
    JSONObject data = queryresult.get("data");
    int NodeCount = data.size();
    
    for (int i = 0; i < NodeCount; i = i+1) {
      String Idx = reverse(split(data.get(i).get(0).get("self").toString(), "/"))[0];
      JSONObject Properties = data.get(i).get(0).get("data");
      Node myNode = new Node(Properties);
      nm.put(Idx, myNode);
      myNode.display();
    }
  }
  
  void make_relationships(JSONObject queryresult){
    JSONObject data = queryresult.get("data");
    int RelCount = data.size();
    
    for (int i = 0; i < RelCount; i = i+1) {
      JSONObject Properties = data.get(i).get(0);
      Relationship myRel = new Relationship(Properties);
      if (myRel.type.equals("End Node Index")){
      //if (myRel.type.equals("Random Node Index")){
        myRel.display();
      }
    }
    
  }
}

// A Node class
class Node { 
  int x;
  int y;
  int size;
  color tone;
  
  Node(JSONObject Properties){
    x = round(Properties.get("Start Node Eastings").floatValue()); 
    y = round(Properties.get("Start Node Northings").floatValue());
    
    JSONObject len = Properties.get("Road Length"); 
    if (len != null) {
      size = round(len.floatValue());
    }else{
      size = 30;
    }
    
    tone = color(100, 100, 100, 70);
    if (Properties.get("Region").toString().equals("HK")){
      tone = color(204, 153, 0, 70);
    } if (Properties.get("Region").toString().equals("K")){
      tone = color(204, 103, 100, 70);
    } if (Properties.get("Region").toString().equals("ST")){
      tone = color(104, 153, 0, 70);
    } if (Properties.get("Region").toString().equals("TM")){
      tone = color(204, 253, 20, 70);
    } 
  }
  
  void display() {
    fill(tone);
    ellipse(x/50-16200, y/50-16200, size/50, size/50); 
  }
}

// A Relationship class
class Relationship { 
  String type;
  String start;
  String end;
  
  Relationship(JSONObject Properties){
    type = reverse(split(Properties.get("type").toString(), "/"))[0];
    start = reverse(split(Properties.get("start").toString(), "/"))[0];
    end = reverse(split(Properties.get("end").toString(), "/"))[0];
  }
  
  void display(){
    line(nm.get(start).x/50-16200, nm.get(start).y/50-16200, nm.get(end).x/50-16200, nm.get(end).y/50-16200);
  }
}
