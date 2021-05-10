  function a = calcA(f, alpha)
        Fr=150;
        m=13;
        a(1)= (f-Fr)*cos(alpha)/m;
        a(2)= (f-Fr)*sin(alpha)/m;
  end