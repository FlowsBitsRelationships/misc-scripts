var template_constructor = function(trace_json){

     console.log( trace_json);
     
     var x = (trace_json.lat-22.28)*1000;
     var y = (trace_json.lon-114.15)*1000;
     
     console.log("x: "+x+",y: "+y);
    geometry = new THREE.CubeGeometry(8, 8, 8);
    material = new THREE.MeshBasicMaterial({
            color : 0x00ff00,
            wireframe: true
        });
        
    cube = new THREE.Mesh(geometry, material);
    cube.position.set(x, y, 0);
    console.log( "created trace!");
    
    return cube
}