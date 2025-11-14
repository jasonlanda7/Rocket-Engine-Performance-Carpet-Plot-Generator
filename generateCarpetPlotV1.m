%% CARPET PLOT GENERATOR 
% ==============================================================
%  PURPOSE:
%     Generates a Carpet Plot of Specific Impulse (Isp) versus
%     Chamber Temperature (Tc) for varying Oxidizer-to-Fuel (O/F)
%     ratios and chamber pressures (Pc).
%
%  DESCRIPTION:
%     This program reads combustion performance data (Isp, Tc)
%     from a user-selected Excel or CSV file and constructs a
%     two-dimensional Carpet Plot that visualizes how specific
%     impulse and chamber temperature vary with O/F ratio and Pc.
%
%     Each curve on the plot corresponds to a constant chamber
%     pressure, while dashed lines connect data points of constant
%     O/F ratio, forming the characteristic "carpet" pattern.
%
%  INPUTS:
%     • User-defined ranges for:
%          - O/F ratio (min, max, step)
%          - Chamber pressure Pc (psi) (min, max, step)
%
%     • Excel/CSV file containing:
%          Column 1: O/F ratios
%          Columns labeled with "ISP" and "Tc" followed by pressure values
%              e.g. ISP_100psi, ISP_200psi, Tc_100psi, Tc_200psi
%
%  OUTPUTS:
%     • Carpet Plot of Isp vs Tc for specified ranges of Pc and O/F.
%     • Optional exportable MATLAB figure for reporting or comparison.
%
%  NOTES:
%     - Column headers must include identifiable pressure values.
%     - Automatically detects data orientation (rows ↔ columns).
%     - Intermediate O/F connectors are annotated on the plot.
%
%  EXAMPLE:
%     >> generateCarpetPlot
%     (Follow prompts to enter O/F and Pc ranges and select data file.)
%
%  AUTHOR:
%     Jason Da Silva
%     Propulsion Analysis Toolkit
%     Rev 1.0 — November 2025
%
% ==============================================================


function GenerateCarpetPlot()
    clc; clear; close all;

    fprintf("=== Combustion Chamber Carpet Plot Generator ===\n");

    % ----- Get O/F ratio range -----
    of_min = input('Enter minimum O/F ratio: ');
    of_max = input('Enter maximum O/F ratio: ');
    of_step = input('Enter O/F increment: ');
    OF = of_min:of_step:of_max;

    % ----- Get chamber pressure range -----
    pc_min = input('Enter minimum chamber pressure (psi): ');
    pc_max = input('Enter maximum chamber pressure (psi): ');
    pc_step = input('Enter Pc increment (psi): ');
    Pc_input = pc_min:pc_step:pc_max;

    fprintf('\nO/F range: %.2f – %.2f (step %.2f)\n', of_min, of_max, of_step);
    fprintf('Pc range: %.2f – %.2f psi (step %.2f)\n\n', pc_min, pc_max, pc_step);

    % ----- Select Excel file -----
    fprintf('Please select the Excel file containing your Isp and Tc data.\n');
    [file, path] = uigetfile({'*.xlsx;*.csv'}, 'Select Excel Data File');
    if isequal(file, 0)
        error('No file selected. Exiting...');
    end
    filepath = fullfile(path, file);

    % ----- Read Excel file -----
    dataTable = readtable(filepath);

    % Extract O/F ratios from the first column
    fileOF = dataTable{:, 1};
    fprintf('Detected %d O/F ratio entries from file.\n', numel(fileOF));

    % Identify ISP and Tc columns automatically
    ispCols = contains(dataTable.Properties.VariableNames, 'ISP', 'IgnoreCase', true);
    tcCols  = contains(dataTable.Properties.VariableNames, 'Tc', 'IgnoreCase', true);

    if ~any(ispCols) || ~any(tcCols)
        error('No ISP or Tc columns found. Make sure headers include "ISP" and "Tc".');
    end

    Isp = table2array(dataTable(:, ispCols));
    Tc  = table2array(dataTable(:, tcCols));

    % Extract pressure values numerically from column headers
    ispHeaders = dataTable.Properties.VariableNames(ispCols);
    tcHeaders  = dataTable.Properties.VariableNames(tcCols);

    Pc_isp = extractPressure(ispHeaders);
    Pc_tc  = extractPressure(tcHeaders);

    % Sanity check
    if ~isequal(Pc_isp, Pc_tc)
        warning('Pressure headers differ slightly — using intersection of both sets.');
        Pc = intersect(Pc_isp, Pc_tc);
        Isp = Isp(:, ismember(Pc_isp, Pc));
        Tc  = Tc(:,  ismember(Pc_tc, Pc));
    else
        Pc = Pc_isp;
    end

    % Match data dimensions
    if numel(fileOF) ~= numel(OF)
        fprintf('⚠️ File O/F values differ from input range. Using values from Excel file.\n');
        OF = fileOF';
    end

    % Ensure data orientation: rows = O/F, columns = Pc
    if size(Isp, 1) ~= numel(OF)
        Isp = Isp';
    end
    if size(Tc, 1) ~= numel(OF)
        Tc = Tc';
    end

    fprintf('\n✅ Successfully loaded data for %d O/F ratios and %d chamber pressures.\n', numel(OF), numel(Pc));

    % -------------------------------------------
    % Plot Carpet Plot: Isp vs Tc
    % -------------------------------------------
    figure;
    hold on; grid on;
    colors = lines(length(Pc));

    % Plot lines for constant pressure
    for i = 1:length(Pc)
        plot(Tc(:, i), Isp(:, i), '-o', 'LineWidth', 2, 'Color', colors(i,:), ...
            'DisplayName', sprintf('Pc = %d psi', Pc(i)));
    end

    xlabel('Chamber Temperature T_c [K]');
    ylabel('Specific Impulse I_{sp} [s]');
    title('I_{sp} vs T_c for Various Chamber Pressures');
    legend('Location', 'southeast');

    % Connect points for constant O/F
    for j = 1:length(OF)
        Tc_row = Tc(j, :);
        Isp_row = Isp(j, :);
        plot(Tc_row, Isp_row, '--', 'Color', [0.7 0.7 0.7], 'HandleVisibility', 'off');
        mid_idx = ceil(length(Pc)/2);
        text(Tc_row(mid_idx), Isp_row(mid_idx), sprintf('O/F=%.1f', OF(j)), ...
             'FontSize', 8, 'HorizontalAlignment', 'left');
    end

    hold off;

    fprintf('\n✅ Carpet plot generated successfully!\n');
end

% ===================================================
% Helper Function: Extract numeric pressure from headers
% ===================================================
function Pc_values = extractPressure(headers)
    Pc_values = zeros(1, numel(headers));
    for k = 1:numel(headers)
        str = headers{k};
        nums = regexp(str, '[0-9.]+', 'match');  % find numeric part
        if ~isempty(nums)
            Pc_values(k) = str2double(nums{1});
        else
            error('Could not extract pressure from header: %s', str);
        end
    end
end
