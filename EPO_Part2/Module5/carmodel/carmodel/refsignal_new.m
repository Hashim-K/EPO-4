%refsignal_new
% Newer version of refsignal, which implements arbitrary frequencies rather
% than table lookup.  Also, Ncodebits = 32 (fixed)
%
% Input: Freq0 = carrier frequency 
%        Freq1 = bit frequency (determines bandwidth)
%        Count3 = repetition counter; repetition freq = bit freq/Count3
%        code: 32 bit, specified as a hex string (0x....)
%        Fs: sample rate at which to generate the template (e.g., 40e3)
%
% The default parameters of the audio beacon are obtained using
%     x = refsignal_new(15000,5000,2500,'aa55aa55',Fs);
% (these are probably not the best settings)
%
% Output:
%     x: the transmitted signal (including silence period)
%     last: the last sample before the silence period
