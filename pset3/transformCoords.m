load('CIE2RGB.mat'); % T is name of transformation matrix
load('CIEMatch.mat'); % CIEMatch is name of matrix

C = CIEMatch;
C_RGB = T*C;
s = size(C);
N = s(2); % should be 75
wavelength = [360 : 5 : 730];

% want to solve for t such that C t = xi, with xi being the basis vectors (1,0,0), (0,1,0), (0,0,1).
% In addition we need t \geq 0 since this is supposed to be a spectrum.

p_r_RGB = lsqlin(ones(1,N), 0, [],[],C_RGB,[1;0;0],zeros(N,1),[]);
p_g_RGB = lsqlin(ones(1,N), 0, [],[],C_RGB,[0;1;0],zeros(N,1),[]);
p_b_RGB = lsqlin(ones(1,N), 0, [],[],C_RGB,[0;0;1],zeros(N,1),[]);



% plot the power spectra as a function of wavelength
fig = figure(1);
clf(fig);
hold on;
plot(wavelength, p_r_RGB, 'r');
plot(wavelength, p_g_RGB, 'g');
plot(wavelength, p_b_RGB, 'b');
title('spectra of primary colors for RGB color system')
xlabel('wavelength');
ylabel('power');
hold off;


% primary colors for CIE color system
p_r_CIE = lsqlin(ones(1,N), 0, [],[],C,[1;0;0],[],[]);
p_g_CIE = lsqlin(ones(1,N), 0, [],[],C,[0;1;0],[],[]);
p_b_CIE = lsqlin(ones(1,N), 0, [],[],C,[0;0;1],[],[]);


% plot the power spectra as a function of wavelength
fig = figure(2);
clf(fig);
hold on;
plot(wavelength, p_r_CIE, 'r');
plot(wavelength, p_g_CIE, 'g');
plot(wavelength, p_b_CIE, 'b');
title('spectra of primary colors for CIE color system')
xlabel('wavelength');
ylabel('power');
hold off;


% Plot color matching functions for RGB system
fig = figure(3);
clf(fig);
hold on;
plot(wavelength, C(1,:), 'r')
plot(wavelength, C(2,:), 'g')
plot(wavelength, C(3,:), 'b')
title('color matching function for RGB')
xlabel('wavelength')
hold off;


% load the eye's spectral response curves
load('LMSResponse.mat')
goodIdx = 7:75;
lmsShort = LMSResponse(:,goodIdx);
N_short = length(goodIdx);

p_L_eye = lsqlin(ones(1,N_short), 0, [],[],lmsShort,[1;0;0],[],[]);
p_M_eye = lsqlin(ones(1,N_short), 0, [],[],lmsShort,[0;1;0],[],[]);
p_S_eye = lsqlin(ones(1,N_short), 0, [],[],lmsShort,[0;0;1],[],[]);


p_L_eye = pinv(lmsShort)*[1;0;0];
p_M_eye = pinv(lmsShort)*[0;1;0];
p_S_eye = pinv(lmsShort)*[0;0;1];

wavelengthShort = wavelength(goodIdx);


%% Plot color matching functions for RGB system
fig = figure(4);
clf(fig);
hold on;
plot(wavelengthShort, p_L_eye, 'r', 'DisplayName', 'L')
plot(wavelengthShort, p_M_eye, 'g', 'DisplayName', 'M')
plot(wavelengthShort, p_S_eye, 'b', 'DisplayName', 'S')
title('Primary color spectra for eye spectral sensitivity curves')
xlabel('wavelength')
legend('show')
hold off;

