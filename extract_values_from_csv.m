function extract_values_from_csv(csv_filename)
    % Open the CSV file for reading
    fid = fopen(csv_filename, 'r');
    i=1;
    % Read and process each line in the CSV file
    while ~feof(fid)
        % Read the next line
        line = fgetl(fid);

        % Split the line into cells using ',' as the delimiter
        cells = strsplit(line, ',');

        % Extract specific values (1st, 5th, 9th, etc.) from cells
        x_array = str2double(cells(1:4:end));
        y_array = str2double(cells(2:4:end));
        hole_depth = str2double(cells(3:4:end));
        hole_radius = str2double(cells(4:4:end));
        make_holes_and_run_write_data(x_array,y_array,hole_depth,hole_radius,length(x_array));
        if i==1
            break
        end
        
    end

    % Close the file
    fclose(fid);
end
