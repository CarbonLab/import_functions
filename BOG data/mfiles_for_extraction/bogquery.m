function v = bogquery(sql)

% Brian Schlining
% 2014-10-08


set(0, 'DefaultFigureUnit', 'pixels', ...
    'DefaultFigurePosition', [680 678 560 420]);

configureJDBCDataSource(); 

c = database('jdbc:jtds:sqlserver://perseus.shore.mbari.org:1433/BOG', 'everyone', 'guest');
v = jdbcquery(c, sql);
c.close();



set(0, 'DefaultAxesFontSize', 20, ...
    'DefaultAxesLineWidth', 2, ...
    'DefaultLineLineWidth', 2, ...
    'DefaultTextFontName', 'Times', ...
    'DefaultAxesFontWeight', 'bold', ...
    'DefaultLineMarkerSize', 10, ...
    'DefaultFigureUnit', 'centimeter', ...
    'DefaultFigurePosition', [6 1 25 20]);


















