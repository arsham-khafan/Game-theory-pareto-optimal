clc; clear;
prompt = {'Enter number of matrix rows:','Enter number of matrix columns:'};
dlgtitle = 'Input size';
dims = [1 50];
definput = {'2','2'};
answer = inputdlg(prompt,dlgtitle,dims,definput);
rows = str2double(answer{1,1});
cols = str2double(answer{2,1});

U1 = zeros(rows,cols);
U2 = zeros(rows,cols);

for i = 1:rows
    for j = 1:cols
        prompt = {['Enter first players utility index ' num2str(i) num2str(j)],...
            ['Enter second players utility index ' num2str(i) num2str(j)]};
        dlgtitle = 'utility';
        definput = {'0','0'};
        dims = [1 50];
        answer = inputdlg(prompt,dlgtitle,dims,definput);
        U1(i,j) = str2double(answer{1,1});
        U2(i,j) = str2double(answer{2,1});
    end
end

%----------------------------------------------
X = reshape(U1,rows*cols,1);
Y = reshape(U2,rows*cols,1);
try
    [k,av] = convhull(X,Y);
catch
    clc;
    disp("game is zero sum all the points are in convex hull and pareto optimal")
    clear;
    return;
end
plot(X(:,1),Y(:,1),'x',Color=[0 0 0],LineWidth=1)
hold on
plot(X(k,1),Y(k,1),"LineWidth",1.5,Color=[1 1 1])
%,'FaceAlpha',0.3
fill(X(k,1),Y(k,1),[1 0 0],"FaceAlpha",0.6)
hold on
line(xlim(), [0,0], 'LineWidth', 1, 'Color', [0 0 0],'LineStyle','--');
grid on;
line([0,0], ylim(), 'LineWidth', 1, 'Color', [0 0 0],'LineStyle','--');
grid on;
%-------------------------------------------------Pareto optimals:
P = [X Y];
Q = P(k(2:end),:);
for i = 1:size(Q,1)
    for j = 1:size(Q,1)
        if j == i
            continue;
        end
        if (Q(i,1) <= Q(j , 1)) && (Q(i,2) <= Q(j , 2))
            Q(i,1) = NaN;
            Q(i,2) = NaN;
            break;
        end
    end
end
Q_ = [];
for i = 1:size(Q,1)
    if~(isnan(Q(i,1)) || isnan(Q(i,2)))
        Q_ = [Q_ ; [Q(i,1) Q(i,2)]];
    end
end
Q = Q_;
hold on
plot(Q(:,1),Q(:,2),Color=[0 0.5 0],LineWidth=3,Marker='*',MarkerSize=8)
set(gcf, 'Position', [150 150 690 550]);
clc;clear;
