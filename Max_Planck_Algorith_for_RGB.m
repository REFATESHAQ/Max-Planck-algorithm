%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Algorithm Name: Max Planck algorithm
% Written By: Refat Mohammed Abdullah Eshaq, on 01/07/2023.
% Copyright (c) 2023, Refat Mohammed Abdullah Eshaq, All rights reserved.
% This code is licensed under a GNU Affero General Public License Version 3 (GNU AGPLv3), for more information, see <https://www.gnu.org/licenses/agpl-3.0.en.html>.
% This program is free software: you can redistribute it and/or modify it under the terms of the GNU Affero General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.
% This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU Affero General Public License for more details. You should have received a copy of the GNU Affero General Public License along with this program.  If not, see <https://www.gnu.org/licenses/>. 
% The code and data are connected to the article, entitled “Max Planck Theory for Digital Image Processing: A New Algorithm for Mammogram Image Segmentation to Identify Masses in Regions of the Breast”, see  <https://doi.org/10.36227/techrxiv.23994702.v1>. Note that, the article is undergoing review. 
% Publish date:02/09/2023
% Author's Email: refateshaq1993@gmail.com; refateshaq@hotmail.com; 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
%#####################################################################################################################################################################################################################################%
 %% Important Notices: 
 % If you want to download the data , please go to this website,<https://doi.org/10.7937/tcia.eqde-4b16>. 
 

 %% Code starts from here.
clc
clear 
close all 

X = imread('IR000032.bmp');

rgbImage = double(X);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

c0=2.997*10.^8;% m/s speed of light in vaccum
h=6.625*10.^-34;% J.s Planck constant 
k=1.38*10.^-23;%  T/K Boltzmann constant
n=1;%refravtive index of the medium .
T=1000000000000;%  Temperature initiatlisation

G1 = rgbImage(:,:,1);
G2 = rgbImage(:,:,2);
G3 = rgbImage(:,:,3);

MP1=(2*pi.*h.*(c0.^2))./((n.^2).*(G1.^5).*(exp((h.*c0)./(n.*k.*T.*G1))-1));
MP2=(2*pi.*h.*(c0.^2))./((n.^2).*(G2.^5).*(exp((h.*c0)./(n.*k.*T.*G2))-1));
MP3=(2*pi.*h.*(c0.^2))./((n.^2).*(G3.^5).*(exp((h.*c0)./(n.*k.*T.*G3))-1));

MP4=(2*pi.*h.*(c0.^2))./((n.^2).*(MP1.^5).*(exp((h.*c0)./(n.*k.*T.*MP1))-1));
MP5=(2*pi.*h.*(c0.^2))./((n.^2).*(MP2.^5).*(exp((h.*c0)./(n.*k.*T.*MP2))-1));
MP6=(2*pi.*h.*(c0.^2))./((n.^2).*(MP3.^5).*(exp((h.*c0)./(n.*k.*T.*MP3))-1));

MP1(isnan(MP1))=0;
MP2(isnan(MP2))=0;
MP3(isnan(MP3))=0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

D1 = gradient(MP1);
D2 = gradient(MP2);
D3 = gradient(MP3);

A1=del2(MP1);
A2=del2(MP2);
A3=del2(MP3);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

NewImage1 = cat(3, MP1, MP2, MP3);
NewImage2 = cat(3, MP4, MP5, MP6);
NewImage3 = cat(3, D1, D2, D3);
NewImage4 = cat(3, A1, A2, A3);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure(1);
imshow(X);
title("Original RGB Image");

figure(2);
imshow(rgbImage)
title("Original RGB Image (Double)");

figure(3);
montage({NewImage1,NewImage2, NewImage3,NewImage4});
title("Image Segmentation (Results)");
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                        %%% The End of Algorithm %%%
                                    %%% Refat Mohammed Abdullah Eshaq %%%
                               %%% <https://orcid.org/0000-0002-6448-4054> %%%





