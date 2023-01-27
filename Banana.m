function Banana(mode,D)

% Written by Dongchen Qi @ NUS,
% Initialized on Jan 27th, 2023
% Email: e1010580@u.nus.edu

%% parameters
% we input the parameters of the differential-drive car
r=0.033;  % radius
L=0.2;    % wheel base
T = 1;    % total time
DT=D*T;   % diffusion constant
Sample=10000;  % total experiments
N = 1000;
dt = T/N;   % time step
a=1;    % arc radius
alphadot=pi/2;  % rate
v=1/T;

% wheel speed
if mode == 1
    omega1=v/r; % straight
    omega2=v/r;
else
    omega1=alphadot*(a+L/2)/r; % arc
    omega2=alphadot*(a-L/2)/r;
end

% Euler-Maruyama method, citation [12] section 4
% 10000 experiments, each experiment record P times.
q=10;
Dt=q*dt;
P=N/q;

% Brownian increments
dW1=sqrt(dt)*randn(Sample,N);
dW2=sqrt(dt)*randn(Sample,N);

% initialize
X = zeros(Sample,P);
Y = zeros(Sample,P);
theta=zeros(Sample,P);
Winc1 = zeros(Sample,P);
Winc2 = zeros(Sample,P);
randn('state',400)

%% Draw banana
figure
for j=1:Sample
    for i = 2:P
        Winc1 = sum(dW1(j,q*(i-1)+1:q*i));
        Winc2 = sum(dW2(j,q*(i-1)+1:q*i));
        % equation (2)
        X(j,i) = X(j,i-1) + 0.5*r*(omega1+omega2)*cos(theta(j,i-1))*Dt + 0.5*r*sqrt(D)*cos(theta(j,i-1))*(Winc1+Winc2);
        Y(j,i) = Y(j,i-1) + 0.5*r*(omega1+omega2)*sin(theta(j,i-1))*Dt + 0.5*r*sqrt(D)*sin(theta(j,i-1))*(Winc1+Winc2);
        theta(j,i) = theta(j,i-1) + Dt*r*(omega1-omega2)/L + sqrt(D)*r*(Winc1-Winc2)/L;
    end
    % show the final position of the car
    plot(X(j,P),Y(j,P),'b.')
    hold on
end

% Ideal path
if mode == 1
    X_ideal = linspace(0,1,N);
    Y_ideal = zeros(1,N);
    plot(1,0,'k*')
    axis([-0.5 1.5 -1 1])
    title(['Straight, DT=',num2str(DT)])
else
    alpha_ideal=linspace(0,pi/2,N);
    X_ideal=a*sin(alpha_ideal);
    Y_ideal=a-a*cos(alpha_ideal);
    plot(a,a,'k*')
    axis([-0.5 2 -0.5 2])
    title(['Arc DT=',num2str(DT)])
end

plot(X_ideal,Y_ideal,'--k','linewidth',2)
xlabel('X Position')
ylabel('Y Position')
grid on

%% XY coordinate
% calculate the mean and covariance

% Cartisian Mean
mean_cart=[0 0 0]; %X,Y,theta
% equation (24)
mean_cart(1)=sum(X(:,end))/Sample;
mean_cart(2)=sum(Y(:,end))/Sample;
mean_cart(3)=sum(theta(:,end))/Sample;

% Cartisian Covariance
cov_cart=zeros(3);
% equation (25)
for i=1:Sample
    cov_cart=cov_cart+( ([ X(i,end)-mean_cart(1) ; Y(i,end)-mean_cart(2) ; theta(i,end)-mean_cart(3)]) * ...
               ([ X(i,end)-mean_cart(1) ; Y(i,end)-mean_cart(2) ; theta(i,end)-mean_cart(3)])' );
end
cov_cart=cov_cart./Sample;

%% plot ellipse
%
[x,y] = meshgrid(linspace(min(X(:,end)),max(X(:,end)),Sample)',linspace(min(Y(:,end)),max(Y(:,end)),Sample)');
data = [x(:) y(:)];
% gaussian pdf in cartesian coordinate (x and y)
z = mvnpdf(data, mean_cart(1:2), [cov_cart(1:2);cov_cart(4:5)]); 
contour(x,y,reshape(z,Sample,Sample),[0.5,1.5,5],'--r','linewidth',2);
hold on

%% Exponentional coordinate
% initialize
v1=zeros(Sample,1);
v2=zeros(Sample,1);
alpha=zeros(Sample,1);

% equation (5)
for i=1:Sample
    g=[cos(theta(i,end))   -sin(theta(i,end))    X(i,end);
       sin(theta(i,end))    cos(theta(i,end))    Y(i,end);
              0                    0                 1   ;];
    g=logm(g);
    v1(i)=g(1,3);
    v2(i)=g(2,3);
    alpha(i)=g(2,1);
end

% propagation formula
if mode == 1
    % mean, equation (32)
    t=T;
    mean_exp=[1 0 r*omega1*t; 0 1 0; 0 0 1];

    % covariance, equation (33)
    sigma11=0.5*D*t*r^2;
    sigma22=(2*D*(omega1^2)*(r^4)*(t^3))/( 3*(L^2) );
    sigma23=D*omega1*r^3*t^2/L^2;
    sigma32=sigma23;
    sigma33=2*D*r^2*t/(L^2);
    cov_exp=[sigma11 0 0; 0 sigma22 sigma23; 0 sigma32 sigma33];
else
    % mean, equation (34)
    t=T;
    mean_exp=[cos(alphadot*t) -sin(alphadot*t) a*sin(alphadot*t);
        sin(alphadot*t)  cos(alphadot*t) a*(1-cos(alphadot*t));
        0               0                   1          ];

    % covariance, equation (35)
    c=(D*r^2)/(alphadot*L^2);
    sigma11=c*( (4*a^2+L^2)*(2*alphadot*t+sin(2*alphadot*t))+16*a^2*(alphadot*t-2*sin(alphadot*t)) )/8;
    sigma12=-0.5*c*( 4*a^2*(-1+cos(alphadot*t))+L^2 )*(sin(0.5*alphadot*t))^2;
    sigma13=2*c*a*(alphadot*T-sin(alphadot*t));
    sigma21=sigma12;   sigma22=-c*(4*a^2+L^2)*(-2*alphadot*t+sin(2*alphadot*t))/8;
    sigma23=-2*c*a*(-1+cos(alphadot*t));
    sigma31=sigma13;   sigma32=sigma23;   sigma33=2*c*alphadot;
    cov_exp=[sigma11 sigma12 sigma13; sigma21 sigma22 sigma23; sigma31 sigma32 sigma33;];
end

%% plot banana margin

cc=(2*pi)^(3/2)*sqrt(det(cov_exp));
t1= (v2.*(-1+cos(alpha)) + v1.*sin(alpha))./alpha; % equation (6)
t2= (v1.*(1-cos(alpha)) + v2.*sin(alpha))./alpha;  % equation (7)

% calculate pdf
Num=100;
tt1=linspace(min(t1),max(t1),Num);
tt2=linspace(min(t2),max(t2),Num);
z=linspace(min(alpha),max(alpha),Num);

pdf_temp=zeros(1,Num);
pdf_exp=zeros(Num);
% equation (23)
for i=1:Num
    for j=1:Num
        parfor k=1:Num
            g=[cos(z(k)) -sin(z(k)) tt1(i);
               sin(z(k))  cos(z(k)) tt2(j);
                   0          0       1];
            temp=inv(mean_exp)*g;
            temp=logm(temp);
            yy=[temp(1,3);temp(2,3);temp(2,1)];
            pdf_temp(k)=1/cc * exp(-0.5 * yy' * inv(cov_exp) * yy);
        end
        pdf_exp(j,i)=trapz(z,pdf_temp); % pdf for banana distribution
    end
end
contour(tt1,tt2,pdf_exp,[0.5,1.5,5],'c','linewidth',1.5);
hold off

%% plot ellipse in exponential coordinate
% this section to show that the point in exponential coordinate can be regarded as
% Gaussian distribution
ellipse = fitgmdist([v1 v2],1);
figure
gscatter(v1,v2);
[liex, liey] = meshgrid(linspace(min(v1),max(v1),Num), linspace(min(v2),max(v2),Num));
hold on
pdf_lie=reshape(pdf(ellipse, [liex(:) liey(:)]), size(liex,1), size(liey,2));
contour(liex, liey, pdf_lie,[0.5,2,5],'color','r','LineWidth',2);
if mode == 1
    title(['Straight,DT=',num2str(DT)])
else
    title(['Arc,DT=',num2str(DT)])
end
axis('equal')
grid on
hold off

end