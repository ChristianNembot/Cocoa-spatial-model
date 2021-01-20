clear all
close all
load('resultats_vraisemb12L.mat')
A=100./(100+VLL-min(VLL));
Vname{1}='$\Lambda$';
Vname{2}='$\beta_1$';
Vname{3}='$\beta_2$';
Vname{4}='$\rho$';
Vname{5}='$\delta$';
Vname{6}='$D_1$';
Vname{7}='$D_2$';
Vname{8}='$\sigma$';
Vname{9}='$d_1$';
Vname{10}='$d_2$';
Vname{11}='$\eta_1$';
Vname{12}='$\eta_2$';

bl=[0.5 1e-5 1e-5 0.0005 0.0005 0.01 0.01 0.005 0.005 0.005 -10 -10]; % lower bound
bm=[3 9e-4 9e-4 0.3 0.2 0.1 0.3 2.5 0.5 0.22 10 10]; % upper bound
%k=1:12
for k=12
    
    
    if sum(k==[6 9])>0
        semilogx(XX(:,k),A,'+')
    elseif k==10
        plot(XX(:,k),A,'+')
    else
        plot(XX(:,k),A,'+')
    end
    xlim([bl(k) bm(k)])
    xlabel(Vname{k},'Interpreter','Latex')
    ylabel('$f(\hat \theta_j)$','Interpreter','Latex')
    set(gca,'FontSize',10,'FontName','Times New Roman')
    print('-dpng','-r300',['fig_SI_' num2str(k) '.png'])
end