var sc = new scene_controller();
var dbc = new db_controller();

sc.set_frame("spatial");
 
$("button#query").unbind("click");
$("button#query").click(function () {
    var query = $("#query").val();
    sc.set_tracing_template("tweet_node");

    sc.clear_scene();

    dbc.cypher_neo4j(query, function(json){
        sc.add_tracing(json);
    });
});