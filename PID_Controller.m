tfnum = input("Enter the numerator of the TF function: ");
tfden = input("Enter the denominator of the TF function:");
sys = tf(tfnum, tfden)
s = tf('s');
kp = input("Enter PID controller input p:");
ki = input("Enter PID controller input i:");
kd = input("Enter PID controller input d:");
more = input("Add more PID inputs?\n[1] Yes\n[2] No\n");
if more == 1
   N = input("Enter PID controller input N (Derivative filter divisor):");
   ks = input("Enter PID controller input ks (Sample Time):");
   pidcont = pidstd(kp, kd, ki, N, ks);
   C = tf(pidcont);
   C = feedback(C, 1)
else
   pidcont = pidstd(kp, ki, kd);
   C = tf(pidcont);
   C = feedback(C, 1)
end
fprintf("Select your desired output by inputting the ff.\n1: parabolic ((1/2)*t^2)\n2: step (u(t))\n3: ramp (t)\n4: impulse (ds/dt)\n5: pzmap\n")
user = input("Enter your desired output:");
if user == 1
   t = 0:0.1:20;
   u = 0.5*t.*t;
   [y1, x1] = lsim(sys,u,t);
   [y,x] = lsim(C,u,t);
   plot(t,y,'b',t,y1,'g')
   xlabel('Time(secs)')
   ylabel('Amplitude')
   title('PID Input-green, Transfer Function-blue')
elseif user == 2
   hold on
   step(sys)
   step(C)
   hold off
elseif user == 3
   %t1 = input("input first time frame: ");
   %t2 = input("input second time frame: ");
   %time = [t1 t2];
   %y1 = zeros(1, length(t1));
   %y2 = 2*ones(1, length(t2)).*t2;
   %y = [y1 y2];
   %plot(time, y, '+')
   hold on
   step(sys/s)
   step(C/s)
   hold off
elseif user == 4
   hold on
   impulse(sys)
   impulse(C)
   hold off
elseif user == 5
   hold on
   pzmap(sys)
   pzmap(C)
   hold off
end
