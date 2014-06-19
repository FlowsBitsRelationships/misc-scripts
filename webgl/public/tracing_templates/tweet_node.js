var template_constructor = function(trace_json){

     console.log( trace_json);
     
     var x = Math.round(trace_json.lat);
     var y = Math.round(trace_json.lon);
     
    geometry = new THREE.CubeGeometry(1, 1, 1);
    material = new THREE.MeshBasicMaterial({
            color : 0x00ff00,
            wireframe: true
        });
        
    cube = new THREE.Mesh(geometry, material);
    cube.position.set(5, 4, 5);
    console.log( "created trace!");
    
    return cube
}