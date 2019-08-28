function [y,water]=MSM(x,win,Info)
Parametros=Info.Node.ModelParameters;

X=[zeros(1,5);0.4 1 zeros(1,3);0.2 0 1 0 0;0.1 0 0 1 0;0.1 0 0 0 1];
v=3.8;
m=length(X(:,1));
n=length(X(1,:));
f=[0.1 0.2 0.15 0.1 0.1]';
T=length(f);

if mod(v,1) ~=  0
    v_=round(v);
    if v_-v >0
        v_1=v_-1;
        v_2=v_;
    elseif v-v_ > 0
        v_1=v_;
        v_2=v_+1;
    end
    f1=f;
    f2=f;
    X1=X;
    for i=1:v_1
        if i == m
            break
        end
        if i > 1
            X1(m,:)=zeros(1,m);
            X1(:,n)=zeros(n,1);
            for y=m-1:-1:1
                for j=n-1:-1:1
                    X1(y+1,j+1)=X1(y,j);
                end
            end
            X1(:,i-1)=zeros(1,m);
        end
        p1=X1*f1;
        f1=p1;

    end
    f1(T+1)=1-sum(f1);
    p1(T+1)=1-sum(p1);


    X2=X;
    for i=1:v_2
        if i == m
            break
        end
        if i > 1
            X2(m,:)=zeros(1,m);
            X2(:,n)=zeros(n,1);
            for y=m-1:-1:1
                for j=n-1:-1:1
                    X2(y+1,j+1)=X2(y,j);
                end
            end
            X2(:,i-1)=zeros(1,m);
        end
        p2=X2*f2;
        f2=p2;

    end
    f2(T+1)=1-sum(f2);
    p2(T+1)=1-sum(p2);

    s=[21997 15554 10984 7978 5641 3989];
        pdef=zeros(1,length(p1));
        for i=1:length(p1)
            pdef(i)=interp1([v_1 v_2],[p1(i) p2(i)],v);
        end


    P1=Pasante(p1);
    P2=Pasante(p2);
    Pdef=Pasante(pdef);
    semilogx(s,P1,'b',s,P2,'r',s,Pdef,'k');
    legend(sprintf('%d',v_1),sprintf('%d',v_2),sprintf('%f',v))
    grid on
elseif mod(v,1) == 0
    
    f1=f;
    X1=X;
    for i=1:v
        if i == m
            break
        end
        if i > 1
            X1(m,:)=zeros(1,m);
            X1(:,n)=zeros(n,1);
            for y=m-1:-1:1
                for j=n-1:-1:1
                    X1(y+1,j+1)=X1(y,j);
                end
            end
            X1(:,i-1)=zeros(1,m);
        end
        p1=X1*f1;
        f1=p1;

    end
    f1(T+1)=1-sum(f1);
    p1(T+1)=1-sum(p1);
    P1=Pasante(p1);
    
    s=[21997 15554 10984 7978 5641 3989];
    semilogx(s,P1,'b');
    legend(sprintf('%d',v))
    grid on
end
end
