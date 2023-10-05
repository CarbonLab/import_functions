
% load PK adn PO data first
pkdens = sw_dens(PSAL(7,:), TC(7,:), PRES(7,:));
podens = sw_dens(ones(size(PO.do_TC(3,:))).*33.65, PO.do_TC(3,:), 14);

figure
hold on; box on;
plot(pkdens, DOXY(7,:), 'bo', 'markersize', 1);
plot(podens, PO.DO(3,:), 'ro', 'markersize', 1);
plot(bog.dens, bog.doxy, 'ko', 'markersize', 1);
legend('PK', 'PO', 'BOG');
xlabel('Density');
ylabel('O2 umolkg');