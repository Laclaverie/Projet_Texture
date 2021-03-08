function [wf]=tse_gabor_dwt2(f,scale,nb_octave,nb_div_angle,w0)
% tse_gabor_dwt2 computes the 2d discrete wavelet transform of image f using a 
% gabor wavelet.
% 
% [wf]=tse_gabor_dwt2(f,scale,nb_octave,nb_div_angle,w0) returns an image array wf
% containing wavelet coefficients. Each image of the array corresponds to the wt 
% for one scale and one angle.

if nargin<2, scale=2;end
if nargin<3, nb_octave=3;end
if nargin<4, nb_div_angle=1;end
if nargin<5, w0=2*pi;end

nb_angle=nb_div_angle;
delta_angle=-pi/nb_div_angle;
a0=2;

[m,n]=size(f);
x=[0:n-1 -n:-1];
y=[0:m-1 -m:-1];
[xx yy]=meshgrid(x,y);

F=fft2(double(f),2*m,2*n);
wf=zeros(m,n,nb_octave*nb_angle);

% c_psi computation (for wavelet centering)
a=n/8;
x_a=xx/a;
y_a=yy/a;
c_psi=sum(sum(exp(-(x_a.^2+y_a.^2)/2+1j*w0*x_a)))/(2*pi*a^2);

a=scale;
p=1;
for k=1:nb_octave
  teta=0;
  for l=1:nb_angle
    coef=1/(sqrt(pi)*a);
    x_a=xx/a;
    y_a=yy/a;
    Psi=coef*exp(-(x_a.^2+y_a.^2)/2).*( exp(1j*w0*(cos(teta)*x_a+sin(teta)*y_a)) - c_psi);
    temp=ifft2(F.*fft2(Psi));
    wf(:,:,p)=temp(1:m,1:n);
    teta=teta+delta_angle;
    p=p+1;
  end
  a=a0*a;
end











