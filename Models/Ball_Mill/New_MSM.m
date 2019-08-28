function out=New_MSM(X,Container)
global ros rol v Info
 v_ = v/1000;


  Dsim = Container.D_sim;
  Dfit = Container.D_ori;
        
  Lsim = Container.L_sim;
  Lfit = Container.L_ori;
        
  Cssim = Container.CS_sim;
  Csfit = Container.CS_ori;
        
  LFsim = Container.FL_sim;
  LFfit = Container.FL_ori;
        
  WIsim = Container.WI_sim;
  WIfit = Container.WI_ori;
        
  Kn1 = Container.Kn1;
  Kn2 = Container.Kn2;
  Kn3 = Container.Kn3;      
  Kn4 = Container.Kn4;
  
  KnotsSize=[Kn1 Kn2 Kn3 Kn4];
 
  Kn1v = Container.Kn1v;
  Kn2v = Container.Kn2v;
  Kn3v = Container.Kn3v;      
  Kn4v = Container.Kn4v;
   
  KnotsValue=[Kn1v Kn2v Kn3v Kn4v];
  
  Dbsim=Container.Db_sim;
  Dbfit=Container.Db_ori;
  
  K=Container.Breakage_factor;

%%%%%%%%%%%%5 BATERIA MOLINOS, RECORDAR, recordar   2lmjiahnsjifdnbasjdnsajdnaskd
%%%%%%%%%%%%askjdnaijskd
x=X(1:end-1);
win=X(end);
P=sum(x);
for i=1:length(v_)-1
    v5(i)=(v_(i+1)+v_(i))/2;
end
s=v_;
s=[v5 v_(end)]';
K=0.00044;

rol=1;
ros=2.7;
rop=(P+win)/(win/rol+P/ros);
ta=40;


xm=K*Dbsim^2;
for i=1:length(KnotsSize)
    if KnotsSize(i) <= xm
        KnotsSize(i)=KnotsSize(i)*Dbsim/Dbfit;
    else
        KnotsSize(i)=KnotsSize(i)*(Dbsim/Dbfit)^2;
    end
end

R_D=RD(s,KnotsSize,KnotsValue);
R_DSim=R_D*(Dsim/Dfit)^0.5*((1-LFsim)/(1-LFfit))*(LFsim/LFfit)*(Cssim/Csfit)*(WIsim/WIfit)^0.8;

Q=P/ros+win/rol;
tau=(Dsim^2*Lsim)/(4*Q);
A=BallStdInterTa(s,ta);


p=zeros(length(v_),1);

p(1)=(x(1)+A(1,1)*R_DSim(1)*tau)/(1+R_DSim(1)*tau);

if x(1) == 0
    p(1) = 0;
end

for i=2:length(s)
    sumai=0;
    for j=1:i-1
          sumai=sumai+tau*R_DSim(j)*p(j)*A(i,j);              
    end
          p(i)=(x(i)+sumai)/(1+(1-A(i,i))*R_DSim(i)*tau);
end





Jt=0.336; %%% Acuerdate
S=(P/ros)/(P/ros+win/rol);
e=0.4;
U=1;
rm=Dsim/2;
RPM=60/(2*pi())*sqrt(2*9.81/Dsim); 
Nm=RPM/60;
phi=Cssim;
temp=0.35*(3.364-Jt);
if phi > temp
    phic=phi;
elseif phi <= temp
    phic=temp;
end

Jb=0.14;
rob=7.5;
z=(1-Jt)^0.4532;
coneangle=15;
Dt=1.6;
rt=Dt/2;
Lcone=(Dsim-Dt)/2*tan(pi()*coneangle/180);
h=0.67*(2*Q/(pi()*rt*sqrt(9.81)))^(2/3);

thetato=asin((rt-h)/rm)+pi();
thetato=3;
thetat=2.5307*(1.2796-Jt)*(1-exp(-19.42*(phic-phi)))+pi()/2;
thetas=pi()/2-(thetat-pi()/2)*((0.3386+0.1041*phi)+(1.54-2.5673*phi)*Jt);
roc=(Jt*ros*(1-e+e*U*S/100)+Jb*(rob-ros)*(1-e)+Jt*e*U*(1-S/100))/Jt;
r_=rm/2*(1+(1-2*pi()*Jt/(2*pi()+thetas-thetat))^0.5);
N_=Nm/2;
tc=(2*pi()-thetat+thetas)/(2*pi()*N_);
tf=((2*r_*(sin(thetas)-sin(thetat)))/9.81)^0.5;
B=tc/(tc+tf);
ri=rm*(1-(2*pi()*B*Jt)/(2*pi()+thetas-thetat))^0.5;

Pnet=pi()*Lsim*Nm*rm*9.81/(3*(rm-z*ri))*(2*rm^3-3*z*rm^2*ri+ri^3*(3*z-2))*(roc*(sin(thetas)-sin(thetat)))...
+Lsim*roc*(Nm*rm*pi()/(rm-z*ri))^3*((rm-z*ri)^4-ri^4*(z-1)^4);

Pc=pi()*Lcone*9.81*Nm/(3*(rm-rt))*(rm^4-4*rm*ri^3+3*ri^4)*(roc*(sin(thetas)-sin(thetat)))...
    +2*pi()^3*Nm*Lcone*roc/(5*(rm-rt))*(rm^5-5*rm*ri^4+4*ri^5);
knon=2.13;
Pnon=knon*(Dsim^2.5*phi*(0.667*Lcone+Lsim))^0.82;
P=Pnon+1.26*(Pc+Pnet);
I = get_index_info(Container.Index);
Info(I).Container.Potencia = P;
out =[p;win];
end
    