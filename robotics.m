%  CLEAN UP THE WORKSPACE
clear
close all
clc

%  DEFINE VECTOR LENGTHS AND ANGULAR ORIENTATIONS
l = 10;
ql = 25*pi/180;
cql = cos(ql);
sql = sin(ql);
lvec = l*[cql;sql]; %  Fill in the vector

s = 5;
qs = -30*pi/180;
cqs = cos(qs);
sqs = sin(qs);
svec = s*[cqs;sqs];  %  Fill in the vector


rho = 15;
phi = 45*pi/180;
cphi = cos(phi);
sphi = sin(phi);
rhovec = rho*[cphi;sphi]  %  Fill in the vector

%  ADD YOUR NEW VECTOR DEFINITION FOR PART 7 HERE
q = 7
gam = -15*pi/180;
cgam = cos(gam);
sgam = sin(gam);
qvec = q*[cgam;sgam];  %  Fill in the vector


origin = [0;0];

%  CREATE ROTATION MATRICIES
T1 = [cql,-1*sql;sql,cql]

T2 = [cqs,-1*sqs;sqs,cqs] %  You need to modify this to go between the first and second links

T3 = [cphi,-1*sphi;sphi,cphi];  %  You need to modify this to go between the second and third links

%  You will need to add your new vector definition for part 7 here
  
%  COMPUTE THE POSITIONS USING VECTORS
lpos_vec = lvec;  %  You need to modify this with your first vector loop equation
spos_vec = lvec + T1*svec;  %  You need to modify this with your second vector loop equation
Rvec =  lvec + T1*svec + T1*T2*rhovec;  %  You need to modify this with your third vector loop equation
Qvec =  lvec + T1*svec + T1*T2*rhovec + T1*T2*T3*qvec;  %  You need to modify this with your fourth vector loop equation from part 7




%---------------DISPLAY THE RESULTS - DO NOT CHANGE THIS-------------------
disp(['l position - vector:'])
disp(lpos_vec)

disp(['s position - vector:'])
disp(spos_vec)

disp(['R position - vector:'])
disp(Rvec)

disp(['Q position - vector:'])
disp(Qvec)

%  PLOT EVERYTHING OUT
points_vector = [origin, lpos_vec, spos_vec, Rvec, Qvec]';

figure(1)
hold on
num_points = length(points_vector(:,1));
color_flags = ['krcb'];
for counter = 1:num_points-1
    plot(points_vector(counter:counter+1,1), points_vector(counter:counter+1,2), 'linewidth', 3, 'Color', color_flags(counter))
end
plot(origin(1), origin(2), 'ko', 'markerfacecolor', 'k', 'markersize', 20)
set(gca, 'Fontsize', 14)
axis equal