// Class for managing ThreeJS methods and interaction with scene
function scene_controller() {

	var self = this;

	var scene,
	camera,
	renderer,
	geometry,
	material,
	cube;
    
    var tracing_template;

	// **** Utility methods ****
    
    // Set the default value for all variables
	var __construct = function (that) {

		scene = new THREE.Scene();
		camera = new THREE.PerspectiveCamera(75, window.innerWidth / window.innerHeight, 0.1, 1000);
		renderer = new THREE.WebGLRenderer();

		renderer.setSize(window.innerWidth, window.innerHeight);

		document.body.appendChild(renderer.domElement);

		geometry = new THREE.CubeGeometry(1, 1, 1);
		material = new THREE.MeshBasicMaterial({
				color : 0x00ff00
			});
		cube = new THREE.Mesh(geometry, material);

		scene.add(cube);

		camera.position.z = 5;

	}(this);
    
    // Clear the scene geometry
	self.clear_scene = function () {
		console.log("clear_scene();");
	};
    
    // Render the scene
	self.render = function () {
		requestAnimationFrame(self.render);

		cube.rotation.x += 0.01;
		cube.rotation.y += 0.01;

		renderer.render(scene, camera);
	};

	// Visualization methods
    // Changes the canvas (and redraws geometry) according to the selected frame
	self.set_frame = function (frame_name) {
    
		console.log("set_frame("+frame_name+")");
        
        switch (frame_name) {
        
			case "interaction":
                console.log("interaction");
            break
            
			case "temporal":
                console.log("temporal");
            break
            
			case "spatial":
                console.log("spatial");
            break
            
        };
        
	};
    
    // Changes the active template.
	self.set_tracing_template = function (tracing_template_name) {
    
         // Each template has a constructor function called template_constructor
        $.getScript( "tracing_templates/"+tracing_template_name+".js", function(script) {
           tracing_template = template_constructor;
        });
	};
    
    // adds the appropriate geometry  when a json is received from db_controller
    
    // Tracings are created by combining a set of data with a corresponding 
    // tracing template (which receives each data element and correctly generates the 
    // corresponding threeJS geometry).  These templates are separate files loaded in as needed.
    // setting them procedurally will allow the same data to produce many different geometrical representations
    // and allow new types of data to be easily added/removed
	self.add_tracing = function (json) {
        json.data.forEach(function(trace_json){
            trace = tracing_template(trace_json);
            console.log(trace);
            scene.add(trace);
        });
        self.render();
	};

}


// Class for making calls to Neo4j/Postgres
function db_controller() {
    var self = this;

	var __construct = function (that) {
        // console.log("db_controller.__construct");
    }(this);
    
    // Sends a cypher query to the application
    self.cypher_neo4j = function (query_msg, ext_callback) {
        var response = $.post("/cypher", { query: query_msg }).done(function(data){
            cypher_neo4j_callback(data, ext_callback);
        });
	};
    
    // Callback for when cypher query returns results, executes external callback with results
    var cypher_neo4j_callback = function (data, ext_callback) {
        var json = JSON.parse(data)
        ext_callback(json);
    };
}
