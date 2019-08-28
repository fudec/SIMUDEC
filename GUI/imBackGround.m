function out=imBackGround(Im,Color)

    MM1=Im(:,:,1);
    MM2=Im(:,:,2);
    MM3=Im(:,:,3);


    MM1(MM1(:,:)==0)=Color(1)*255;
    MM2(MM2(:,:)==0)=Color(2)*255;
    MM3(MM3(:,:)==0)=Color(3)*255;

  
    out(:,:,1)=MM1;
    out(:,:,2)=MM2;
    out(:,:,3)=MM3;
    
end
