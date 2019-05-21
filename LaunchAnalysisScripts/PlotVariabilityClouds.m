CB65 =  [	0.3494	0.3049	0.4424	0.3063	0.2335	0.2193	0.2346	0.2054	0.2643	0.2985	0.2669	0.4257	0.3203	0.4041		];	
SC65 =  [	0.2566	0.3668	0.2514	0.2994	0.2389	0.224	0.3844	0.273	0.2401	0.2913	0.2504	0.2954	0.3039	0.1574	0.3915	0.2599	0.2585];
																	
CB80 =  [	0.4471	0.3635	0.4707	0.2568	0.2166	0.2422	0.2502	0.2087	0.304	0.3506	0.3263	0.4798	0.2315	0.2724		];	
SC80 =  [	0.2872	0.3752	0.3173	0.3543	0.2779	0.2363	0.3058	0.1956	0.2422	0.1806	0.2519	0.26	0.2457	0.2727	0.3314	0.2707	0.2387];
																	
CB99  =  [	0.431	0.4438	0.3899	0.2406	0.2136	0.2371	0.2039	0.1859	0.264	0.219	0.2965	0.4678	0.3538	0.385			];
SC99  =  [	0.3206	0.3101	0.2103	0.254	0.2615	0.286	0.3567	0.2651	0.1856	0.2344	0.2149	0.2486	0.2782	0.1852	0.3896	0.2449	0.1873];

%Makes mean into black lines
CB65m = repmat(mean(CB65),2); SC65m = repmat(mean(SC65),2);
CB80m = repmat(mean(CB80),2); SC80m = repmat(mean(SC80),2);
CB99m = repmat(mean(CB99),2); SC99m = repmat(mean(SC99),2);

CB65x = linspace(.8, .9,14); SC65x = linspace(1.1, 1.2,17);
CB80x = linspace(1.8, 1.9,14); SC80x = linspace(2.1, 2.2,17);
CB99x = linspace(2.8, 2.9,14); SC99x = linspace(3.1, 3.2,17);

h = plot(CB65x,CB65,'o',...
    SC65x,SC65, 'o',...
    CB80x,CB80, 'o',...
    SC80x,SC80, 'o',...
    CB99x,CB99, 'o',...
    SC99x,SC99, 'o',...
    [.75 .95],CB65m, '-k',...
    [1.05 1.25],SC65m, '-k',...
    [1.75 1.95],CB80m, '-k',...
    [2.05 2.25],SC80m, '-k',...
    [2.75 2.95],CB99m, '-k',...
    [3.05 3.25],SC99m, '-k')


set(h(1),'MarkerFaceColor',[92 190 92]./255); set(h(1),'MarkerEdgeColor', (30+[92 190 92])./255); set(h(1),'LineWidth',2);
set(h(2),'MarkerFaceColor',[81 81 202]./255); set(h(2),'MarkerEdgeColor', (30+[81 81 202])./255); set(h(2),'LineWidth',2);

set(h(3),'MarkerFaceColor',[92 190 92]./255); set(h(3),'MarkerEdgeColor', (30+[92 190 92])./255); set(h(3),'LineWidth',2);
set(h(4),'MarkerFaceColor',[81 81 202]./255); set(h(4),'MarkerEdgeColor', (30+[81 81 202])./255); set(h(4),'LineWidth',2);

set(h(5),'MarkerFaceColor',[92 190 92]./255); set(h(5),'MarkerEdgeColor', (30+[92 190 92])./255); set(h(5),'LineWidth',2);
set(h(6),'MarkerFaceColor',[81 81 202]./255); set(h(6),'MarkerEdgeColor', (30+[81 81 202])./255); set(h(6),'LineWidth',2);

set(h(8), 'LineWidth',2);set(h(10), 'LineWidth',2);set(h(12), 'LineWidth',2);
set(h(14), 'LineWidth',2);set(h(16), 'LineWidth',2);set(h(18), 'LineWidth',2);

