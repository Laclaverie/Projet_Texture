function [wf,scales]=tse_gabor_dwt(f,scale,nb_octave,nb_div_per_octave,w0)
% tse_gabor_dwt computes the discrete wavelet transform of signal f using a 
% gabor wavelet.
% 
% [wf]=tse_gabor_dwt(f,scale,nb_octave,nb_div_per_octave,w0) returns an image wf
% containing wavelet coefficients. Each line corresponds to wt coefficients for one
% scale s_k such as:
% s_k=scale*2^(k/nb_div_per_octave), k=0..nb_scale-1
% where nb_scale=nb_div_per_octave*nb_octave.

if nargin<2, scale=2;end
if nargin<3, nb_octave=7;end
if nargin<4, nb_div_per_octave=16;end
if nargin<5, w0=2*pi;end

nb_scale=nb_div_per_octave*nb_octave;
a0=2^(1/nb_div_per_octave);

n=size(f,2);
x=[0:n-1 -n:-1];

F=fft(double(f),2*n);
wf=zeros(nb_scale,n);

% c_psi computation (for wavelet centering)
a=n/8;
x_a=x/a;
c_psi=sum(exp(-x_a.^2/2+1j*w0*x_a))/sqrt(2*pi)/a;

% wavelet transform
a=scale;
for i=1:nb_scale
  coef=1/sqrt(sqrt(pi)*a);
  x_a=x/a;
  Psi=coef*exp(-x_a.^2/2).*( exp(1j*w0*x_a)-c_psi);
  temp=ifft(F.*fft(Psi));
  wf(i,:)=temp(1:n);
  scales(i) = a;
  a=a0*a;
end

