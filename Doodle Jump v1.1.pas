program Doodle_Jump_v1_0;

uses graphABC;

type
  point = record
    x, y: integer;
  end;

var
  doodler, background, platform: picture;
  left, right, x, y, h, i, err,pl,vym,z,u: integer;
  score,sc: longint;
  vx, vy,vp: real;
  platforms: array[1..20] of point;
  game, active, guide, settings,gameover,readname,readsound,readfps: boolean;
  f: text;
  DB: array[1..5] of string;
procedure keydown(key: integer);
begin
  if (key = VK_left) or (key = VK_A) then left := 1;
  if (key = VK_right) or (key = VK_D) then right := 1;
  if (key = VK_Escape) then game := false;
  if (key = VK_Escape) then guide := false;
  if (key = VK_Escape) then settings := false;
  if (key = VK_Escape) then gameover := false;
end;
\
procedure keyup(key: integer);
begin
  case key of
    VK_left, VK_A: left := 0;
    VK_right, VK_D: right := 0;
  end;
end;

procedure MouseUp(x, y, mb: integer);
begin
  if (mb = 1) and (X > 150) and (X < 382) and (Y > 150) and (Y < 220) then game := true;
  if (mb = 1) and (X > 150) and (X < 382) and (Y > 250) and (Y < 320) then guide := true;
  if (mb = 1) and (X > 150) and (X < 382) and (Y > 350) and (Y < 420) then settings := true;
  if (mb = 1) and (X > 150) and (X < 382) and (Y > 450) and (Y < 520) then active := false;
  if (mb = 1) and (X > 150) and (X < 382) and (Y > 150) and (Y < 220) and (gameover = true) then Begin game := true;gameover:= false end;
end;
procedure MouseUpSettings(x, y, mb: integer);
begin
  if (mb = 1) and (X > 35) and (X < 55) and (Y > 45) and (Y < 65) then readname := true;
  if (mb = 1) and (X > 35) and (X < 55) and (Y > 115) and (Y < 125) then readsound := true;
  if (mb = 1) and (X > 35) and (X < 55) and (Y > 150) and (Y < 165) then readfps := true;
end;
begin
  window.caption := 'Doodle Jump v1.1';
  setwindowsize(532, 850);
  SetWindowisFixedSize(true);
  setWindowPos(494, 0);
  lockdrawing();
  OnKeyDown := keydown;
  OnKeyUp := KeyUp;
  OnMouseUp := MouseUp;
  doodler := picture.Create('Bin/Textures/Doodler.png');
  background := picture.Create('Bin/Textures/Background.png');
  platform := picture.Create('Bin/Textures/Platform.png');
  active := true;
  game := false;
  gameover:= false;
  while active do
  begin
    Assign(f,'bin/data');
    Reset(f);
    for i:= 1 to 5 do ReadLn(f,DB[i]);
    close(f);
    readname:= false;
    readsound:= false;
    readfps:= false;
    If DB[1] = 'YBRXTHTLYBR' then
    begin
      ClearWindow();
      x := 266;Y := 400;H := 425;
      for i := 1 to 20 do
      begin
        platforms[i].x := random(532);
        platforms[i].y := random(850);
      end;
      pl:=20;
      //==============MENU START==============\\
      SetPenColor(clBlack);
      SetFontColor(clBlue);
      SetBrushColor(clTransparent);
      SetFontSize(20);
      SetFontName('Century Gothic');
      background.draw(0, 0);
      TextOut(150, 10, 'Doodle Jump v1.1');
      Line(10, 50, 522, 50);
      Rectangle(150, 150, 382, 220);
      TextOut(222, 169, 'Играть');
      Rectangle(150, 250, 382, 320);
      TextOut(200, 270, 'Как Играть');
      Rectangle(150, 350, 382, 420);
      TextOut(192, 367, 'Настройки');
      Rectangle(150, 450, 382, 520);
      TextOut(223, 465, 'Выход');
      Rectangle(100, 550, 432, 660);
      TextOut(175, 560, 'Ваш Рекорд:');
      SetFontSize(40);
      TextOut(200, 590, DB[2]);
      Redraw;
      //==============MENU END================\\

      //===========MENU GUIDE START===========\\
      while guide do
      begin
        ClearWindow();
        background.draw(0, 0);
        TextOut(3, 50, 'Добро пожаловать в игру Doodle Jump v1.1!');
        SetPenColor(clBlack);
        SetFontColor(clBlue);
        SetBrushColor(clTransparent);
        SetFontSize(20);
        SetFontName('Century Gothic');
        TextOut(150, 10, 'Doodle Jump v1.1');
        Line(10, 50, 522, 50);
        SetFontSize(16);
        SetFontSize(12);
        TextOut(50, 90, 'Перед игрой настоятельно рекомендую ознакомиться');
        TextOut(50, 107, 'с правилами.');
        TextOut(70, 140, '1. Цель игры - добраться как можно выше.');
        TextOut(70, 160, '2. Управление персонажем осуществляется с');
        TextOut(70, 180, 'помощь клавиш "A" "D" или стрелочек ПРАВО ЛЕВО.');
        TextOut(70, 200, '3. Не рекомендуется изменять файлы игры и их');
        TextOut(70, 220, 'параметры.');
        TextOut(70, 240, '4. Для выхода в главное меню используйте клавишу ESC');
        SetFontColor(clRed);
        TextOut(50, 260, 'Внимание!');
        SetFontColor(clBlue);
        TextOut(150, 260, 'Для сохранения рекордов и данных игры');
        TextOut(50, 280, 'рекомендуется выходить из игры с помощью кнопки');
        TextOut(50, 300, '"Выход" в главном меню.');
        Setfontsize(20);
      //Rectangle(150, 450, 382, 520);
      //TextOut(223, 465, 'Меню');
        Redraw;
      end;
      //===========MENU GUIDE END=============\\

      //============MENU SETTINGS=============\\
      While settings do
      begin
        clearwindow();
        OnMouseUp := MouseUpSettings;
        background.draw(0, 0);
        SetPenColor(clBlack);
        SetFontColor(clBlue);
        SetBrushColor(clTransparent);
        SetFontSize(20);
        SetFontName('Century Gothic');
        TextOut(150, 10, 'Doodle Jump v1.1');
        Line(10, 50, 522, 50);
        SetFontSize(16);
        SetFontSize(12);
        rectangle(35,55,45,65);SetFontColor(clBlue);TextOut(50, 50, 'Ваше имя: ');SetFontColor(clBlack);TextOut(230, 50, DB[3]);
        SetFontColor(clBlue);TextOut(50, 70, 'Ваш дудлер: ');SetFontColor(clBlack);TextOut(230, 70, 'Обычный');picture.create('bin/textures/doodler.png');doodler.draw(330, 50);
        SetFontColor(clBlue);TextOut(50, 90, 'Размер окна: ');SetFontColor(clBlack);TextOut(230, 90, '532x850');
        rectangle(35,115,45,125);SetFontColor(clBlue);TextOut(50, 110, 'Звук(вкл/выкл): ');SetFontColor(clBlack);TextOut(230, 110, DB[4]);
        SetFontColor(clBlue);TextOut(50, 130, 'Вы находитесь в игре: ');SetFontColor(clBlack);TextOut(230, 130, (Milliseconds / 1000));
        rectangle(35,155,45,165);SetFontColor(clBlue);TextOut(50, 150, 'Вывод FPS(вкл/выкл):');SetFontColor(clBlack);TextOut(230, 150, DB[5]);
        if (DB[4] <> 'вкл') and (DB[4] <> 'выкл') then textout(50,180,'Неправильно введено значение поля "звуки"');
        if (DB[5] <> 'вкл') and (DB[5] <> 'выкл') then textout(50,180,'Неправильно введено значение поля "fps"');
        Redraw();
        if readname then
        begin
          readLn(DB[3]);
          readname:= false;
        end;
        if readsound then
        begin
          readLn(DB[4]);
          readsound:= false;
        end;
        if readfps then
        begin
          readLn(DB[5]);
          readfps:= false;
        end;
      end;
      //==========MENU SETTINGS END===========\\

      //=============GAME START===============\\
      score:= 0;
      vp:= 0.1;
      vym:=-7;
      z:=1;
      while game do
      begin
        u:= u+1;
        ClearWindow();
        background.draw(0, 0);
        SetPenColor(clBlack);
        SetFontColor(clBlue);
        SetBrushColor(clTransparent);
        SetFontSize(20);
        SetFontName('Century Gothic');
        TextOut(10,10,score.ToString);
        for i := 1 to pl do platform.Draw(platforms[i].x, platforms[i].y);
        doodler.Draw(x, y);
        TextOut(10, 10, score.ToString);
        val(DB[2], sc, err);
        SetPenColor(clRed);
        if score > sc then TextOut(10, 35, 'Вы поставили новый рекорд!');
        if left = 1 then x := x - 3;
        if right = 1 then x := x + 3;
        vy := vy + vp;
        y := y + round(vy);
        //if y > 800 then vy:=-7; //Мега-Чит ٩(╬ʘ益ʘ╬)۶
        for i := 1 to pl do
          if
          (x + 36 > platforms[i].x) and
          (x + 5 < platforms[i].x + 56) and
          (y + 53 > platforms[i].y) and
          (y + 53 < platforms[i].y + 14) and
          (vy > 0) then
            vy := vym;
        if y < h then
        begin
          for i := 1 to pl do
          begin
            y := h;
            platforms[i].y := platforms[i].y - round(vy);
            if platforms[i].y > 850 then
            begin
              platforms[i].y := 0;
              platforms[i].x := random(532);
            end;
          end;
          score:= score + 1;

        end;
        If y>850 then
        begin
          game:= false;
          gameover:= true;
          break;
        end;
        while ((z*1000) <= score) do
        begin
          pl:=pl-z;
          vp:=vp+0.05;
          vym:=vym-z;
          z:=z+1;
        end;
        if u mod 1 = 0 then
        begin
        Textout(500,10, (1*(round(1 / (millisecondsdelta / 1000)))));
        end;
      Redraw();
      end;
      //=============GAME END=================\\

      //==========GAME OVER START=============\\
      while gameover do
      begin
        ClearWindow();
        background.draw(0, 0);
        SetPenColor(clBlack);
        SetFontColor(clBlue);
        SetBrushColor(clTransparent);
        SetFontSize(20);
        SetFontName('Century Gothic');
        TextOut(150, 10, 'Doodle Jump v1.1');
        Line(10, 50, 522, 50);
        SetFontSize(30);
        TextOut(150,80,'GAME OVER');
        Rectangle(150, 150, 382, 220);
        SetFontSize(20);
        TextOut(215, 169, 'Заново');
        Rectangle(100, 250, 432, 400);
        TextOut(180,250,'Ваши Очки:');
        SetFontSize(50);
        TextOut(215,290, score);
        SetFontSize(20);
        vy:= 0;
        val(DB[2], sc, err);
        SetBrushColor(clTransparent);
        SetPenColor(clRed);
        if score > sc then
        begin
          TextOut(80, 430, 'Вы поставили новый рекорд!');

        end;
        Redraw;
      end;
      //===========GAME OVER END==============\\
      end
      else
      begin
        ClearWindow();
        background.Draw(0,0);
        SetPenColor(clBlack);
        SetFontColor(clBlue);
        SetBrushColor(clTransparent);
        SetFontSize(20);
        SetFontName('Century Gothic');
        TextOut(150, 10, 'Doodle Jump v1.1');
        Line(10, 50, 522, 50);
        SetFontSize(14);
        TextOut(20, 50, 'Пожалуйста используте оригинальную версию игры!');
        Redraw();
      end;
      if score > sc then DB[2] := score.ToString;
        assign(f,'bin\data');
        rewrite(f);
        for i := 1 to 5 do writeln(f, DB[i]);close(f);
    end;
  Halt;
end.