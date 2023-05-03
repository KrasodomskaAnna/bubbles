clear all;
close all;

a = 10;
r_max = a/2;
n_max = 400;

x = 1:n_max;
y = 1:n_max;
r = 1:n_max;
surface = 1:n_max;
ltr_nb = 1:n_max;                   % lottery number
ltr = 1;                            % lottery counter

n = 1;
while n <= n_max
    % losowanie
    R = rand(1) * r_max;
    X = rand(1) * (a - 2*R) + R;
    Y = rand(1) * (a - 2*R) + R;

    % czy się przecina?
    % | O1 O2 | >= r1 + r2
    cover = false;
    for i = 1:n
        if sqrt((X - x(i))^2 + (Y - y(i))^2) < R + r(i)
            cover = true;
            break;
        end
    end
    if cover
        ltr = ltr + 1;
        continue;
    end

    % rysuj
    plot_circle(X, Y, R);
    hold on;
    axis equal;
    axis([0 a 0 a]);

    % zapamiętaj wartości
    x(n) = X;
    y(n) = Y;
    r(n) = R;
    surface(n) = pi*R.^2;
    ltr_nb(n) = ltr;
    ltr = 1;

    pause(0.01);
    n = n + 1;
end

% zadanie A
figure;
plot(1:n_max, cumsum(surface));
xlabel("Liczba narysowanych okręgów");
ylabel("Powierzchnia");
title("Powierzchnia całkowita kół");
print -dpng zadanie1a;

% zadanie B
figure;
plot(1:n_max, cumsum(ltr_nb)./(1:n_max));
xlabel("Liczba narysowanych okręgów");
ylabel("Liczba losowań");
title("Średnia liczba losowań");
print -dpng zadanie1b;