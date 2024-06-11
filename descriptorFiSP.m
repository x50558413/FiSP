function [descriptorVector] = descriptorFiSP(image,featurePoints,totalRadius)

%% Citation
%{
Ramli, R., Idris, M.Y.I., Hasikin, K., Karim, N.K.A., Wahab, A.W.A., 
Ahmedy, I., Ahmedy, F. and Arof, H. (2020), Local descriptor for retinal 
fundus image registration. IET Comput. Vis., 14: 144-153. 
https://doi.org/10.1049/iet-cvi.2019.0623
%}

%% Input
%   image : should be a single channel image with pixel values between 0 to 255
%   featurePoints : [x,y] >> it can be a single point or multiple points
%   totalRadius : the default value is 55

%% Output
%   descriptorVector :
%   columns contain vector values
%   rows represent feature points following the same order as featurePoints

%% The code start here

descriptorVector = [];

for i_points = 1:length(featurePoints(:,1))
    
    x0 = round(featurePoints(i_points,1));
    y0 = round(featurePoints(i_points,2));
    
    for i_circumference = 1:totalRadius
        
        radius = i_circumference + 1;
        [xc, yc] = getmidpointcircle(x0, y0, radius);
        
        linearIndex = sub2ind(size(image), yc, xc);
        valuePixel = image(linearIndex);
        
        descriptorVectorSum(i_points,i_circumference) = sum(valuePixel);
        descriptorVectorMean(i_points,i_circumference) = mean(double(valuePixel));
        descriptorVectorStd(i_points,i_circumference) = std(double(valuePixel));
    end 
end

descriptorVector = [descriptorVectorSum,descriptorVectorMean,descriptorVectorStd];

end