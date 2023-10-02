function make_holes_and_run_write_data(x_array, y_array, hole_depth_array, hole_radius_array, length_of_array)
    import com.comsol.model.*
    import com.comsol.model.util.*

    % Load the COMSOL model
    model = mphload('C:\Users\advai\Desktop\Advait_idea\For Deep neural network\modelrunner.mph');
    geom = model.component('comp1').geom('geom1');

    % Loop through the array and create holes
    for i = 1:length_of_array
        x = x_array(i);
        y = y_array(i);
        hole_depth = hole_depth_array(i);
        hole_radius = hole_radius_array(i);
        
        % Generate a unique name for each cylinder and difference
        cyl_name = ['cyl_', num2str(i)];
        diff_name = ['diff_', num2str(i)];
        
        % Call the function to create a hole with the specified name
        addHoleToGeometry(model, geom, x, y, hole_radius, hole_depth, cyl_name, diff_name);
    end

    % Save the modified model
    mphsave(model, 'modified_model.mph');

    % Launch the model and run the solution
    model.sol('sol1').runAll();

    % Evaluate potential at all nodes
    result = mpheval(model, {'V'});
    potentialValues = result.d1;
    nodeCoordinates = result.p;
    
    % Create a CSV file to save data
    csv_filename = 'data.csv';
    fid = fopen(csv_filename, 'w');
    fprintf(fid, 'x,y,z,potential\n');

    % Write data for all nodes to CSV file
    for i = 1:size(nodeCoordinates, 1)
        x = nodeCoordinates(i, 1);
        y = nodeCoordinates(i, 2);
        z = nodeCoordinates(i, 3);
        potential = potentialValues(i);

        fprintf(fid, '%f,%f,%f,%f\n', x, y, z, potential);
    end

    fclose(fid);
end
