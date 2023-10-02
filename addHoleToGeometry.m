% Add a function to create a hole in the geometry
function addHoleToGeometry(model, geom, x, y, hole_radius, hole_depth, cyl_name, diff_name)
    try
        % Create a cylinder to represent the hole
   
        model.component('imp1').geom('geom1').create(cyl_name, 'Cylinder');
        model.component('imp1').geom('geom1').feature(cyl_name).set('r', hole_radius);
        model.component('imp1').geom('geom1').feature(cyl_name).set('h', hole_depth);
        model.component('imp1').geom('geom1').feature(cyl_name).set('pos', {num2str(x), num2str(y), num2str(hole_depth / 2)});
        
        % Run the cylinder operation
        model.component('imp1').geom('geom1').run(cyl_name);
        
        % Create a 'Difference' operation to subtract the cylinder from the geometry
        model.component('imp1').geom('geom1').create(diff_name, 'Difference');
        model.component('comp1').geom('geom1').feature('diff1').selection('input').set({'imp1'});
        model.component('comp1').geom('geom1').feature('diff1').selection('input2').set({cyl_name});
        model.component('comp1').geom('geom1').run('diff1');
        % Access the geometry
        geom = model.component('comp1').geom('geom1');
        
 
end
