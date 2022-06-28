pico-8 cartridge // http://www.pico-8.com
version 29
__lua__
function _init()
 
 --player
	
	p={x=75,y=75,speed=1, life=3, timer=0}
	first_sprt = fget(1,0)
	
	--shake
	scr = {}
	scr.x = 0
	scr.y = 0
	scr.intensity = 0
 scr.shake= 5
	
	--nuage
 clouds={}
 
 --flaques
 flaques={}
 
 --balles
	bullets={}
	
	--pigeon
	pigeons={}
	
	--vagues
	waves={}
	
	--voiture
	cars={}
	cars2={}
	
	--explosions
	explosions={}
	explosions2={}
	explosions3={}

	--sang
	blood={}
	
	trail_width = 1.5
 trail_colors = {12,13,1}
 trail_amount = 2


 explode_size = 5
 explode_colors = {8,9,6,5}
 explode_amount = 5


	--score
	
	score=0

--fientes
	
	fientes={}
	text_timer=0
	
	--game state
	
	state="intro"

	--camera
	
	cam_x=p.x-60
	
	--sprites 
	
	mehmet_sprite=1
	d= 4
	mama_sprite=192
	mama={x=0,y=20,speed=1, life=10, timer=0}
	d2= 36
	
	--sfx
	
	sfx(1)
	music(0)
	
end

function _update60()

 if (state=="intro") then update_intro()
 elseif (state=="game") then update_game()
 else function update_gameover()
  text_timer+=1
  if (⬇️) _init()
 end
 
	end
end

function _draw()
	
	
	--game state
	if (state=="intro") then draw_intro()
	elseif (state=="game") then draw_game()
	else  draw_gameover()
 end
end



-->8
--bullets

function shoot()
	new_bullet={
		x=p.x,
		y=p.y,
		speed=4
	}
	add(bullets, new_bullet)
	sfx(0)
end

function update_bullets()
	for b in all(bullets) do
		b.y-=b.speed
		if (b.y<-8) del(bullets,b)
	end
end
-->8
--camera

function camera_follow()
	cam_x=p.x-60
	cam_x=mid(0,cam_x,896)
	camera(cam_x)
end

-->8
--pigeons

function spawn_pigeons(amount)
 gap=(128-8*amount)/(amount+1)
 for i=1, amount do
	add(pigeons,{
		x=rnd(p.x+168),
		y=ceil(rnd(20)),
		life=1
	})
 end 
end

function update_pigeons()
	for pigeon in all(pigeons) do
		pigeon.x-= 0.5

		if pigeon.x <  (p.x+1)
		and pigeon.x > (p.x-1) then
			new_fientes = {
        	x=pigeon.x,
        	y=pigeon.y,
        	speed=rnd(2)
    		}
    		add(fientes, new_fientes)
    		
    		flaque = {
    		x=p.x,
    		y=p.y+8
    		}
    		add(flaques, flaque)
    		if flaque.x < p.x-68
  or flaque.x > p.x+68 then
  	del(flaques,flaque)
  end
		end
	
    
		if pigeon.x < p.x-68 then
			del(pigeons,pigeon)
		end

	
	
		--collision
		for b in all(bullets) do
			if collision(pigeon,b) then
		 	create_explosions(pigeon.x,
		 	pigeon.y)

--		 	explode(pigeon.x,pigeon.y)
				pigeon.life-=1 
				if pigeon.life==0 then
			 	del(pigeons,pigeon)
			  score+=100
			  	end
		 	end
	  	end

end
end


-->8
--collision
					
function collision(cible,missiles)
	if cible.y > missiles.y-4 
	and cible.y < missiles.y + 4 then 
		if cible.x > missiles.x-4
		and cible.x < missiles.x+4 then 
			return true
		else
			return false
 	end
 else 
  return false
 end
end




-->8
--explosions
function create_explosions(_x,_y)
	add(explosions,{x=_x, y=_y , timer=0})
end

function update_explosions()
	for e in all(explosions) do
		e.timer +=1
		if e.timer == 13 then
			del(explosions,e)
		end
	end
end

function draw_explosions()

	circ(pigeons.x,pigeons.y,2,8)

	for e in all(explosions) do
		circ(e.x,e.y,e.timer/3,8+e.timer%3)
	end
end


--explosion 2

--explosions2
function create_explosions2(_x,_y)
	add(explosions2,{x=_x, y=_y , timer=0})
end

function update_explosions2()
	for e2 in all(explosions2) do
		e2.timer +=1
		if e2.timer == 13 then
			del(explosions2,e2)
		end
	end
end

function draw_explosions2()



	for e2 in all(explosions2) do
		circ(e2.x,e2.y,e2.timer/3,8+e2.timer%3)
	end
end

--explosion 3

--explosions3
function create_explosions3(_x,_y)
	add(explosions3,{x=_x, y=_y , timer=0})
end

function update_explosions3()
	for e3 in all(explosions3) do
		e3.timer +=1
		if e3.timer == 13 then
			del(explosions3,e3)
		end
	end
end

function draw_explosions3()

	for e3 in all(explosions3) do
		circ(e3.x,e3.y,12,e3.timer/3,8+e3.timer%3)
	end
end
	


	


	
-->8
--shake 

function screenshake(nb)

 scr.shake= nb

end




	


-->8
--draw
function draw_intro()
 cls()
 print("ca vole pas haut",30,43)
 print("press ⬆️ to start",30,63)
end

function draw_game()
	cls()
	map(0,0,0,0)
	
	--mehmet
	
	palt(7,true)
	palt(0,false)
	spr(mehmet_sprite,p.x,p.y)
	palt(0,true)
	palt(7,false)
	
	--pigeons
	
	for e in all(pigeons) do
		spr(23,e.x,e.y)
	end
	
	--maman pigeon
		
		palt(7,true)
 	palt(0,false)
	 spr(mama_sprite,mama.x,mama.y,4,4)
  palt(0,true)
 	palt(7,false)
	
	--nuage
	
	for n in all(clouds) do
	 spr(36,n.x,n.y)
	end
	
	--waves
	
	for v in all(waves) do
	 spr(65,v.x,v.y,2,1)
	end
	
	--voiture
	palt(6,true)
	palt(0,false)
	
	for car in all(cars) do 
	 spr(39,car.x,car.y,4,2)
	end
	
	for car2 in all(cars2) do 
	spr(138,car2.x,car2.y,4,2)
	end
	
	 palt(0,true)
 	palt(6,false)
	
	
	--explosions
	
	draw_explosions() 
	draw_explosions2()
	draw_explosions3()
	
	--shoot
	
	for b in all(bullets) do
		spr(18,b.x,b.y)
	end
	for f in all(fientes) do
		draw_fientes()
	end

--blood

--draw_blood()
	
	--shake 
	
	 function camera_pos()
  if(scr.shake > 0) then 
   scr.x=(rnd(2)-1)*scr.intensity
   scr.y=(rnd(2)-1)*scr.intensity
   scr.shake -=1
  
  else
   scr.x=0
   scr.y=0
  end
 camera(scr.x,scr.y)
  end

	
	--score
	
	print("score "..score,cam_x+7,2,7)

 	--flaque
	if first_sprt==true then
	 draw_flaques()
	end

		--vie
	if p.life == 3 then
	 	spr(34,cam_x+95,1)
 		spr(34,cam_x+105,1)
 		spr(34,cam_x+115,1)
	elseif p.life == 2 then
		spr(35,cam_x+95,1)
 		spr(34,cam_x+105,1)
 		spr(34,cam_x+115,1)
	elseif p.life == 1 then
		spr(35,cam_x+95,1)
 		spr(35,cam_x+105,1)
 		spr(34,cam_x+115,1)
	end
	
	--gameover 
	
	function draw_gameover()
  cls(6)
  local col=9
  if text_timer%8>4 then
 	 col=10
  end
  print("gameover",32,46)
  print("score:"..score,36,56,col)
  print("⬇️ pour reessayer",38,66,10)
 end
end


-->8
--update

function update_intro()
 if (btnp(⬆️)) then
 state="game"
 end
end

function update_game()

--player

 if btn(➡️)	then 
 	p.x+=p.speed
 	walking()
 	flaque.x-=p.speed
 end
	if btn(⬅️) then
	 p.x-=p.speed
	 walking()
	 flaque.x+=p.speed
	end
	if (btnp(❎)) shoot()
	--if (btnp(🅾️)) then scene="intro"
 	if p.x < 0 then
 		p.x = 0
 	end
 	if p.x > 1000 then
 		p.x = 1000
 	end
 	
 	--temps
 	
 	--shake
camera_pos()

screenshake(nb)

	
	--balles
	
	update_bullets()
	
	--pigeon
	
	if #pigeons==0 then
		spawn_pigeons (rnd(20))
	end
	update_pigeons()

	
	--mama
	
		flying()
		update_mama()
	
	--explosions
	update_explosions()
	update_explosions2()
	update_explosions3()
	
	--nuage
	
	if #clouds==0 then
	 spawn_clouds(rnd(7))
	end
	update_clouds()
	
	--voitures
		if #cars==0 then
	 spawn_cars(rnd(7))
	end
	update_cars()
	
	if #cars2==0 then
	 spawn_cars2(rnd(7))
	end
	update_cars2()
	
	--vagues
	
	if #waves==0 then
	 spawn_waves(rnd(7))
	end
	update_waves()

	--fientes
	update_fientes()
	
	--sang/blood
	
	--update_blood()
	
	--camera
	
	camera_follow()
	
	
	
end

-->8
--nuage 
function spawn_clouds(amount)
 gap=(128-8*amount)/(amount+5)
 for i=1, amount do
	add(clouds,{
		x=rnd(p.x+168),
		y=ceil(rnd(20)),
		speed=0.1
	})
 end 
end

function update_clouds()
	for c in all(clouds) do
		c.x-= c.speed
		if c.x < p.x-68 then
			del(clouds,c)
		end
	end
end
-->8
--vagues
function spawn_waves(amount)
 gap=(128-8*amount)/(amount+1)
 for i=1, amount do
	add(waves,{
		x=rnd(p.x+168),
		y=rnd(p.y+50)+85,
		speed=0.05
	})
 end 
end

function update_waves()
	for w in all(waves) do
		w.x-= w.speed
		if w.x < p.x-68 then
			del(waves,w)
		end
	end
end
-->8
--walking
function walking()
 d-=1
 if d<0 then
 mehmet_sprite+=1
  if mehmet_sprite > 4 then
  mehmet_sprite=1
  end
  d=8
 end
end

function flying()
 d2-=1
 if d2<0 then
 mama_sprite+=4
  if mama_sprite > 204 then
  mama_sprite=192
  end
  d2=12
 end
end



-->8
--fientes

function update_fientes()
    for fiente in all(fientes) do 
        fiente.y += new_fientes.speed
        if fiente.y > p.y+60 then 
            del(fientes,fiente)
        end
		if collision(p, fiente)
		and first_sprt == false then
			del(fientes, fiente)
			create_explosions2(p.x,
		 	p.y)
		 	screenshake(10)
			p.life -= 1
			first_sprt = true
		elseif collision(p, fiente)
		and first_sprt == true then
			p.timer += 1
		end
		if p.timer == 50 then
			first_sprt = false
			p.timer = 0
		end
		if p.life ==0 then
			state= "game over"
		
		end
    end
end

function draw_fientes()

    spr(19,new_fientes.x,new_fientes.y)

end

function create_fientes(x,y)
add(fientes,{
    x = x,
    y = y,
    timer = 0
})
end

function draw_flaques()
	spr(48,flaque.x,flaque.y)
end
-->8
--mama

function update_mama()
	
	if mama.x<900 then
		mama.x+=rnd(mama.speed)
	 elseif mama.x== 900 then
	 mama.x=900
	end
	
--		collision
	
		for b in all(bullets) do
		
	 	if collision(mama,b) then
		   	create_explosions3(mama.x,
		   	mama.y)
			 	mama.life-=1
			 	if mama.life ==0 then 
			   	del(mama)
			   	score+=10000
			   	state = "gameover"
		  	end
		 end
	end
end
			
	



-->8
--blood

--add a particule
--function addblood(x,y,age)
-- local bl={
       -- bl.x=x,
       -- bl.y=y,
       -- bl.age=0
-- }
-- add (blood,bl)
-- end
--end

--spawn a trail

function trail(x,y,w)
 for i=0, num do
 add_fx(
 x+rnd(w)-w/2, 
 y+rnd(w)-w/2,
 40+rnd(30)
 )  
 end
end 

--explode

--function explode(x,y,r,num)
-- for i=0, num do
 -- add_fx(
 -- x,        
 -- y,         
 -- 30+rnd(25)
-- end
--end

--function update_blood()
--  for bl in all(blood) do 
 --  bl.age+=1
 --  if bl.age>bl.mage then 
  --  del(blood,blood{i})
 --  end
 -- end
-- end

--function draw_blood()  

--	circ(pigeons.x,pigeons.y,2,8)

 
-->8
--voiture

--cars 
function spawn_cars(amount)
 gap=(128-8*amount)/(amount+1)
 for i=1, amount do
	add(cars,{
		x=rnd(900),
		y=46,
		speed=-0.1
	})
 end 
end

function update_cars()
	for car in all(cars) do
		car.x-= car.speed
		if car.x < p.x-98 then
			del(cars,car)
		end
	end
end

--cars2

function spawn_cars2(amount)
 gap=(128-8*amount)/(amount+5)
 for i=1, amount do
	add(cars2,{
		x=rnd(900),
		y=50,
		speed=0.1
	})
 end 
end

function update_cars2()
	for car2 in all(cars2) do
		car2.x-= car2.speed
		if car2.x < p.x-98 then
			del(cars2,car2)
		end
	end
end

__gfx__
000000007700007777000077770000777700007777000077eeeeeeee666666666666666699999999999911111999999999911199eeeeeeee9993999966666666
000000007704457777044577770445777704457777044577eee66eee666666666666666699999111119911111999999999111199eeeeeeee993bb9996663b666
007007007740447777404477774044777740447777404477ee6777eedddddddd6666666699999111119911111999999999111119eeeeeeee93bbbb99663bbb66
000770007740007777400077774000777740007777400077e677777edddddddd6666666691199111119911111999999911111119eeeeeeee3bbbbbb963bbbbb6
00077000773357777733577777335777773357777733677766677777dddddddd6666666611111111111111111911199111111111eeeeeeee9bbbbb9933bbbbbb
007007007734577777345777773457777734577777346777eeeeeeee999ddd996666666611111111111111111911199111111111eeeeeeee99bbb9993bbbbbbb
000000007714177777411777771147777711477777141777eeeeeeeeaaadddaa6666666611111111111111111111111111111111eeeeeeee9994999966644666
000000007717177777177177717717777717177771771777eeeeeeeedddddddd6666666611111111111111111111111111111111eeeeeeee9994999966644666
000000006666666600000000000b0000eeeeeeee999999994a444111000ddd001111111111111111111111117788887744a49444eeeeeeee4444eeee44a44a4e
0000000088888886000a000000000000ee99aeee999999991114411100086d0011111111111111111111111177888877444494a4eeeeeeee4444eeee4444444e
000000008888888000000000000b0000e99aaaee999999991114a11100966d0011111111111111111b31111177888877a4441111e9e9e9e9a444eeee44442222
0000000082288880000a0000000000009aaaaaae9999999911144111000666d01111b1bb11b31111b33b3b1177888877114411119e9e9e9e444494444a422222
000000008288888800000000000b00009aaaaaae9999999911111111000dddd0111bbbb3b333b311333333b17788877711141111999999994444944a44427227
0000000022888880000a0000000b00009aaaaaae9999999911111111000a00001bbbbbb33b33333b3b3b333b7788877711111111999999994a44944444222222
00000000060000000000000000000000e99aaaee999999991111111100000000bbbbbb3b33333b3333333333778887771111111199999999444494a4a4272272
0000000000000000000a0000000b0000ee999eee999999991111111100000000bbbbbb3b3333333333b333b37787787711111111999999994444944444222222
00000000000000000880088008800880000000009999999900000000666666666666666666666666666666667788887711111122eeeeeeee22224a4900000000
00000000000000008788888880088008000000009999999900000000666666666666666666666666666666667788887711111112eee4444e2272111100000000
00000000000000008788888880000008000660009999999900000000666666666666666666666666666666667788887711111112229444492222111100000000
000000000000000088888888800000080067770099999999000000006666666666660000000066666666666677888877111111122224444e2112111100000000
000000000000000008888880080000800677777099999999000000006666666666660bbbbbbb066666666666778887771111111272224a491111111100000000
000000000000000000888800008008006667777799999999000000006666666666600bbbbbbb3066666666667788877711111112227244491111111100000000
00000000000000000008800000088000000000009898989800000000666666666600bb00b00bb306666666667788877711111111722244491111111100000000
0000000000000000000000000000000000000000898989890000000066666666600bb000b000bb300666666677878777111111112222a4491111111100000000
0000000000000000000000000000000000000000eeeeee6777eeeeee6666666600bb0000b0000bbb30006666000000000000000000000000cccccccc00000000
0000000000000000000070000000000000000000eeeee667777eeeee666600000bbbbbbbbbbbbbbbbb770666000000000000000000000000cccccccc00000000
00003000000000000b0070b00000000000000000eeee66777777eeee66660bbbbbb3b33b3bb33b3bbbb70666000000000000000000000000cccccccc00000000
03bb333000000000000000000000000000000000ee666677777777ee6666033bbbb3bbbb3bbbbb3bbbbb0666000000000000000000000000cccccccc00000000
03bbb30000000000000b00000000000000000000e66666777777777e666603bbbb00bbbb3bbbb00bbb000666000000000000000000000000cccccccc00000000
003b330000000000000000b0000000000000000066666677777777776666000000d0033333330d0000066666000000000000000000000000cccccccc00000000
00000000000000000b0070000000000000000000eeeeeeeeeeeeeeee66666666600d0666666600d066666666000000000000000000000000cccccccc00000000
0000000000000000000070000000000000000000eeeeeeeeeeeeeeee66666666660066666666600666666666000000000000000000000000cccccccc00000000
dddddddd00000000000000000000000000000000eeeeeeeeeeeeeeee00000000000000000880088000000000eeeeeeeeeeeeee111111111111eeeeeeeeeeeeee
dddddddd00000000000000000000000000000000eeeeeeeeeeeeeeee0000000000880000088888800088880044444eeeeeeee2111111111111222222222eeeee
dddddddd00777000777007770000000000000000eeeeeeeeeeeeeeee0088800000888000080880800080000044444eeeeeeee2111111111111222222222eeeee
dddddddd077c00077c0077c00000000000000000222222222eeeeee10880000000808000080080880088800044444e9e9e9e92111111111111222222222eeeee
dddddddd07cc707ccc707cc700000000000000002222222229e9e9e10800088800808800080000080080000044a449e92222221111111111112222222229e9e9
666666667c00c7cc0cc7cccc0000000000000000222222222e9e9e910880088008888800000000000088888044444444222222111111111111222222222e9e9e
66666666000000000000000000000000000000002222222229999991008888800800080000000000000000001144444422222211111111111122222aa2244449
66666666000000000000000000000000000000002222a2222444444100008000000000000000000000000000111144a422222211111111111122222aa2244449
66666666666666666666666666666666000000002222a2222a44444100000000000000000000000000000000111114442222a211111111111122222aa2244a49
666666666666666666666666666666660000000022222222244444a100000000000000000777700077770000111111411122a211111111111122222222244449
6666666666666666666666666666666600000000222222222444444100000000770000700700000070007000111111111122221111111111112222222224a449
66666666666600000000666666666666000000002a222222244a4441007777700700077007000000700770001111111111222211111111111122222222244449
6666666666660bbbbbbb066666666666000000002a22222224444441007000700770070007777000777700001111111111122211111111111122222222111111
6666666666600bbbbbbb30666666666600000000222222222a444441007000700077770007000000700777001111111111122211111111111122222222111111
666666666600bb00b00bb30666666666000000001111111111111441007000700007700007000000700007701111111111122211111111111122222222111111
66666666600bb000b000bb3006666666000000001111111111111a41007777700000000007777700000000001111111111122211111111111122222222111111
6666666600bb0000b0000bbb30006666000000001111111111111441111111111111111122a11111111111111111111111111111111111111122a21111111111
666600000bbbbbbbbbbbbbbbbb770666000000001111111111111441111111111111111122211111111111111111111111111111111111111122a21111111111
66660bbbbbb3b33b3bb33b3bbbb70666000000001111111111111441111111111111111122211111111111111111111111111111111111111122a21111111111
6666033bbbb3bbbb3bbbbb3bbbbb0666000000001111111111111441111111111111111111111111111111111111111111111111111111111122221111111111
666603bbbb00bbbb3bbbb00bbb000666ccc0000011111111111114a1111111111111111111111111111111111111111111111111111111111122221111111111
6666000000d00333333300d000066666ccccc0001111111111111441111111111111111111111111111111111111111111111111111111111111111111111111
66666666600d066666660d0066666666000000001111111111111441111111111111111111111111111111111111111111111111111111111111111111111111
66666666660066666666600666666666000000001111111111111441111111111111111111111111111111111111111111111111111111111111111111111111
00000000000000000000000000000000000000001111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
00000000000000000000000000000000000000001111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
00000000000000000000000000000000000000001111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
00000000000000000000000000000000000000001111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
00000000000000000000000000000000000000001111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
00000000000000000000000000000000000000001111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
00000000000000000000000000000000000000001111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
00000000000000000000000000000000000000001111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee999999999999999999999999999affafffffaffa9999999966666666666666666666666666666666eeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee993333999999999aaaaaaaaaaaaaaaaaaaaa999966666666666666666666666666666666eeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee9e9e9e9e93333339999999afffffffffffffffffffffa99966666666666666666666666666666666eeeeeeeeefeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee9e9e9e9333b3333999999affaaaaaaaaaaaaaaaaaffa99966666666666666666666666666666666eeeeeeeeeaeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee9999999933bbbb339999999addddddddddddddddddda999966666666666600000000666666666666eeeeeeeffaffeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee999999993bbbbbb399999999afafa6d6d6d66dafafa9999966666666660022228880666666666666eeeeeefffafffeee
999999fafafafafafafafafafafafafaddddd999bbbbbbbb99999999afafad6d6666d6dfafa9999966666666600288888888066666666666eeeeeeeffaffeeee
99999aaaaaaaaaaaaaaaaaaaaaaaaaaaadddd999bbbbbbbb9999999afafaad6dddddd6dafafa999966666660002880080088000666666666eeeeeeeefafeeeee
99999aaaaaaaaaaaaaaaaaaaaaaaaaaaadd66999999999999999999afafaad6d6666d6dafafa999966660000228800080008880000066666eeeeeeeaaaaaeeee
999999ddddddddddddddddddddddddddddddd99939993393999999aaaaaad6dddddddd6daaaaa99966607728888000080000888888066666eeeeeeeafafaeeee
9999777777777777777777777777777777777799b393b333999999afafa6d6d999999d6dafafa99966607288882888828888288822066666eeeeeeeaaaaaeeee
9999affaaaaaaaaaaaaffaaaaaaaaaaaaddddd99bbbbbbbb99999afaffa6d6d999999d6daffafa9966602888882822828228288882066666eeeeeeeafafaeeee
9999aaaaaaaaffaaaaaaaaaaaffaaaaaaddddd99bbbbbbbb99999afaffad6d99999999d6affafa9966602888002888828888008888066666eeeeeeeaaaaaeeee
99999dddddddddddddddddddddddddddddddd999bbbbbbbb9999aaaaaa6d6d99999999d6daaaaaa966600000d00222222220d00000066666eeeeeeeafafaeeee
99999aaaaaaaaaaaaaaaaaaaaaaaaaaaddddd999bbbbbbbb9999afaffa6d6d99999999d6daffafa9666666600d06666666600d0666666666eeeeeeeaaaaaeeee
999999dddddddddddddddddddddddddddd66d999bbbbbbbb999affaffad6d9999999999d6dffaffa66666666006666666666006666666666eeeeeeeafafaeeee
999999ddddddddddddddddddddddddddddddd99999999999aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa999990000000000000000eeeeeeeeeeeeeeeafafaeeee
999999aaaaaaaaaaaaaaaaaaaaaaaaaaddddd9999999999afffffffffffffffffffffffffffffffffffa99990000000000000000eeeeeeeeeeeeeeeaaaaaeeee
999999aaaaaffaddaaddddaaddaaaaaaddddd9999999999afffaaaaaaaaaaaaaaaaaaaaaaaaaaaaafffa99990000000000000000eeeeeeeeeeeeeeaffaffaeee
999999aaaaaaaadaaddd999aadaaaffad66dd9999999999aaadddddddddddddddddddddddddddddddaaa99990000000000000000eeeeeeeeeeeeeeaffaffaeee
999999affaaaaaaaddd99999aaaaaaaaddddd999999999999affafaaaaaaaaaaaaaaaaaaaaaaafaffa9999990000000000000000eeeeeeeeeeeeeeaaaaaaaeee
999997777777777777999997777777777777779999999999affaffaaaffafafafafafafaffaaaffaffa999990000000000000000eeeeeeeeeeeeeeaffaffaeee
999999dddddddddddd999999ddddddddddddd99999999999affafaaffaaaaaaaaaaaaaaaaaffaafaffa999990000000000000000eeeeeeeeeeeeeeaffaffaeee
999999aaaaaaaadddd999999aaaaaaaaddddd9999999999afffffaaffaaadddddddddddaaaffaafffffa99900000000000000000eeeeeeeeeeeeeaffafaffaee
999999aaaaaaffdddd999999aaaaaaaaddddd9999999999aaaaaaaaaaadd6d6666666d6ddaaaaaaaaaaa93930000000000000000eeeeeeeeeeeeeaaaafaaaaee
999999aaaaaaaadddd999999aaaaaffaddddd999bb399999afffaaaadd6666ddddddd6666ddaaaafffaa33930000000000000000eeeeeeeeeeeeeaffafaffaee
999999aaaaaaaad66d999999aaaaaaaaddddd999bbb33933affaaadd6666dd9999999dd6666ddaaaffaa3b9b0000000000000000eeeeeeeeeeeeeaffafaffaee
999999affaaaaadddd999999aaaaaaaaddddd999bbbbb33333faa66d66dd99999999999dd66d66aaffaa3bbb0000000000000000eeeeeeeeeeeeafffafafffae
999999aaaaaaaadddd999999affaaaaaddddd999bbbbbbb333fa66d66d999999999999999d66d66a3bbb33bb0000000000000000eeeeeeeeeeeeaaaafffaaaae
999999aaaaaffadddd999999aaaaaaaaddd66999bbbbbbbbb33336d6d99999999999999999d6d663bbbbb3bb0000000000000000eeeeeeeeeeeeaffafffaffae
999999aaaaaaaa66dd999999aaaaaffaddddd999bbbbbbbbbb333663b99999999999999999ddbb3bbbbbbb330000000000000000eeeeeeeeeeeafffafffafffa
999999aaaaaaaadddd999999aaaaaaaaddddd999bbbbbbbbbbb3333bb3999999999999999933bb3bbbbbbbb30000000000000000eeeeeeee999affafffffaffa
7777777777777dddddd77777777777777777777777777dddddd77777777777777777777777777dddddd77777777777777777777777777dddddd7777777777777
777777777777dddddddd777777777777777777777777dddddddd777777777777777777777777dddddddd777777777777777777777777dddddddd777777777777
77777777777dddddddddd7777777777777777777777dddddddddd7777777777777777777777dddddddddd7777777777777777777777dddddddddd77777777777
7777777777dd888dd888dd77777777777777777777dd888dd888dd77777777777777777777dd888dd888dd77777777777777777777dd888dd888dd7777777777
7777777777dd80866808dd77777777777777777777dd08866088dd77777777777777777777dd80866808dd77777777777777777777dd88066880dd7777777777
7777777777dd80866808dd77777777777777777777dd08866088dd77777777777777777777dd80866808dd77777777777777777777dd88066880dd7777777777
7777777777ddd699996ddd77777777777777777777ddd699996ddd77777777777777777777ddd699996ddd77777777777777777777ddd699996ddd7777777777
7777777777ddd699996ddd77777777777777777777ddd699996ddd77777777777777777777ddd699996ddd77777777777777777777ddd699996ddd7777777777
77777777777dd699996dd7777777777777777777777dd699996dd7777777777777777777777dd699996dd7777777777777777777777dd699996dd77777777777
777777777777dda000dd777777777777777777777777dda000dd777777777777777777777777dda000dd777777777777777777777777dda000dd777777777777
777777777ddddda999ddddd7777777777ddddddddddddda999dddddddddddd77777777777ddddda000ddddd7777777777ddddddddddddda999dddddddddddd77
7777777dddddd666666dddddd777777777d666666666d666666d66666666d7777777777dddddd699996dddddd777777777d666666666d666666d66666666d777
77777dddddddd666666ddddddd777777777ddd666666d666666d6666666d777777777dddddddd666666ddddddd777777777ddd666666d666666d6666666d7777
7777ddddddddd666666ddddddddd777777777d66ddddd666666ddddd66d777777777ddddddddd666666ddddddddd777777777d66ddddd666666ddddd66d77777
77ddddddddddd666666ddddddddddd77777777dd6666d666666d6666dd77777777ddddddddddd666666ddddddddddd77777777dd6666d666666d6666dd777777
7dddddddd666d666666d6666ddddddd777777777dd66d666666d66dd777777777dddddddd666d666666d6666ddddddd777777777dd66d666666d66dd77777777
7ddddd666767d666666d767666d6dddd7777777777ddd666666ddd77777777777ddddd666767d666666d767666d6dddd7777777777ddd666666ddd7777777777
ddd666767777dddddddd777767676ddd777777777777dddddddd777777777777ddd666767777dddddddd777767676ddd777777777777dddddddd777777777777
d66767777777ddd77ddd777777777666777777777777ddd77ddd777777777777d66767777777ddd77ddd777777777666777777777777ddd77ddd777777777777
667777777777ddd77ddd777777777777777777777777ddd77ddd777777777777667777777777ddd77ddd777777777777777777777777ddd77ddd777777777777
777777777777aaa77aaa777777777777777777777777aaa77aaa777777777777777777777777aaa77aaa777777777777777777777777aaa77aaa777777777777
777777777777aaa77aaa777777777777777777777777aaa77aaa777777777777777777777777aaa77aaa777777777777777777777777aaa77aaa777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
77777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777777
__label__
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
88888ffffff882222228888888888888888888888888888888888888888888888888888888888888888228228888228822888fff8ff888888822888888228888
88888f8888f882888828888888888888888888888888888888888888888888888888888888888888882288822888222222888fff8ff888882282888888222888
88888ffffff882888828888888888888888888888888888888888888888888888888888888888888882288822888282282888fff888888228882888888288888
88888888888882888828888888888888888888888888888888888888888888888888888888888888882288822888222222888888fff888228882888822288888
88888f8f8f8882888828888888888888888888888888888888888888888888888888888888888888882288822888822228888ff8fff888882282888222288888
888888f8f8f882222228888888888888888888888888888888888888888888888888888888888888888228228888828828888ff8fff888888822888222888888
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
ddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd666dddddddddddddddddddddddddddddddddddddd
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeedddeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee667777eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee8d8eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee66777777eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeed9deeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee666777777777eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee6666666eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee66777777777777eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeedd666ddeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee6666677777777777eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeed6deeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeaeaeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeedddeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeedd8eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeed669eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeed666eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeedddaeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeaeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeee6777eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeee667777eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeee66777777eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeee666777777777eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeee66777777777777eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeee6666677777777777eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeedddeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee8d8eeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeed9deeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee6666666eeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee9eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeedd666ddeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee9eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeed6deeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee777777777777777777eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeaeaeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeedddeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee7eeeeee9aaa9eeeee7eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeedd8eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee7eeeeee1aaa9eeeee7eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeed669eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee7eeeee171a9eeeeee7eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeed666eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee7eeeee17719eeeeee7eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeedddaeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee7eeeee17771eeeeee7eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeaeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee7eeeee177771eeeee7eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee7eeeee17711eeeeee7eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee7eeeeee1171eeeeee7eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee7eeeeeee9a9eeeeee7eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee7eeeeeee9a9eeeeee7eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee7eeeeee9aaa9eeeee7eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee7eeeeee9aaa9eeeee7eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee7eeeeee9aaa9eeeee7eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee7eeeee9aaaaa9eeee7eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee7eeee9aaa9aaa9eee7eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee7eeee9aa9e9aa9eee7eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee
eeeeeeeeeeee11111eeeeeeeeee111eeeeeeeeeeeeee11111eeeeee777777777777777777eeeeeeeeeeeeeeeeeee11111eeeeeeeeee111ee1eeeeeeeeeee1111
eeeee11111ee11111eeeeeeeee1111eeeeeee11111ee11111eeeeeeeee1111ee11ee11111eeeeeeeeeeee11111ee11111eeeeeeeee1111ee1eeeeeee11ee1111
eeeee11111ee11111eeeeeeeee11111eeeeee11111ee11111eeeeeeeee11111e11ee11111eeeeeeeeeeee11111ee11111eeeeeeeee11111e1eeeeeee11ee1111
e11ee11111ee11111eeeeeee1111111ee11ee11111ee11111eeeeeee1111111e11ee11111eeeeeeee11ee11111ee11111eeeeeee1111111e1eeeeeee11ee1111
11111111111111111e111ee11111111111111111111111111e111ee111111111111111111e111ee111111111111111111e111ee1111111111e111ee111111111
11111111111111111e111ee11111111111111111111111111e111ee111111111111111111e111ee111111111111111111e111ee1111111111e111ee111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
66666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666
66666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666666
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
aaaddaaaaaaddaaaaaaddaaaaaaddaaaaaaddaaaaaaddaaaaaaddaaaaaaddaaaaaaddaaaaaaddaaaaaaddaaaaaaddaaaaaaddaaaaaaddaaaaaaddaaaaaaddaaa
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
dddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd
cccccc1ccccccc1ccccccc1ccccccc1ccccccc1ccccccc1ccccccc1ccccccc1ccccccc1ccccccc1ccccccc1ccccccc1ccccccc1ccccccc1ccccccc1ccccccc1c
ccc1c1c1ccc1c1c1ccc1c1c1ccc1c1c1ccc1c1c1ccc1c1c1ccc1c1c1ccc1c1c1ccc1c1c1ccc1c1c1ccc1c1c1ccc1c1c1ccc1c1c1ccc1c1c1ccc1c1c1ccc1c1c1
cccc1ccccccc1ccccccc1ccccccc1ccccccc1ccccccc1ccccccc1ccccccc1ccccccc1ccccccc1ccccccc1ccccccc1ccccccc1ccccccc1ccccccc1ccccccc1ccc
cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
555555555555575555555ddd55555d5d5d5d55555d5d555555555d5555555ddd555555a9eeeeee55555555555555555555555555555555555555555555555555
555555555555777555555ddd55555555555555555d5d5d55555555d55555d555d55555a9eeeeee56666666666666555557777755555555555555555555555555
555555555557777755555ddd55555d55555d55555d5d5d555555555d555d55555d5555aa9eeeee56ddd6d6d6ddd6555577ddd775566666555666665556666655
555555555577777555555ddd55555555555555555ddddd5555ddddddd55d55555d5555aa9eeeee56d6d6d6d6d6d6555577d7d77566dd666566ddd66566ddd665
5555555557577755555ddddddd555d55555d555d5ddddd555d5ddddd555d55555d5555aa9eeeee56d6d6ddd6ddd6555577d7d775666d66656666d665666dd665
5555555557557555555d55555d55555555555555dddddd555d55ddd55555d555d55555aaa9eeee56d6d666d666d6555577ddd775666d666566d666656666d665
5555555557775555555ddddddd555d5d5d5d555555ddd5555d555d5555555ddd5555559aaa9eee56ddd666d666d655557777777566ddd66566ddd66566ddd665
5555555555555555555555555555555555555555555555555555555555555555555555e9aa9eee56666666666666555577777775666666656666666566666665
55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555566666665ddddddd5ddddddd5ddddddd5
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000555000eeeeeeee0000000005550000eedddeee0000000066666666cccccc1ceeeeeeeeeeee11111eeeeeeeeee111eeeeeeeeeeeeeeeeee00000000
00000000005f7000eedddeee0555000005f70000eedd8eee0006600066666666ccc1c1c1eeeee11111ee11111eeeeeeeee1111eeeeeeeeeeeeeeeeee00000000
0070070000fff000ee8d8eee05f700000fff0000eed669ee00677700ddddddddcccc1ccceeeee11111ee11111eeeeeeeee11111eeeeeeeeeeeeeeeee00000000
000770000066fff0eed9deee0fff00000ccc0000ed666eee06777770ddddddddcccccccce11ee11111ee11111eeeeeee1111111eeeeeeeeeeeeeeeee00000000
00077000006660006666666e0ccc00000cfc0000edddaeee66677777dddddddd1ccc1ccc11111111111111111e111ee111111111eeeeeeeeeeeeeeee00000000
0070070000111000dd666dde0cfc000011f10000eeeeaeee00000000aaaddaaac1c1c1cc11111111111111111e111ee111111111eeeeeeeeeeeeeeee00000000
0000000000101000eed6deee01f1110000010000eeeeeeee00000000ddddddddcc1ccccc11111111111111111111111111111111eeeeeeeeeeeeeeee00000000
0000000000101000eeaeaeee0100000000010000eeeeeeee00000000ddddddddcccccccc11111111111111111111111111111111eeeeeeeeeeeeeeee00000000
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee00000000
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee00000000
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee00000000
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee00000000
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee00000000
eeeeeeee9eeeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee00000000
eeeeeeee9eeeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee00000000
eeeeeee9a9eeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee00000000
eeeeee9aaa9eeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee000000000000000000000000
eeeeee9aaa9eeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee000000000000000000000000
eeeeeee9a9eeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee000000000000000000000000
eeeeeee9a9eeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee000000000000000000000000
eeeeeee9a9eeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee000000000000000000000000
eeeeeee9a9eeeeeeeeeeeeeeeeeeeeee0000000000000000000000000000000000000000eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee000000000000000000000000
eeeeee00000000000000000000eeeeee0000000000000000000000000000000000000000eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee000000000000000000000000
eeeeee07777777777777777770eeeeee0000000000000006600000000000000000000000eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee000000000000000000000000
eeeeee07a9eeeeeeeeeeeeee70eeeeee00000000eeeeee6777eeeeee000000000000000000000000000000000000000000000000000000000000000000000000
eeeeee07a9eeeeeeeeeeeeee70eeeeee00000000eeeee667777eeeee000000000000000000000000000000000000000000000000000000000000000000000000
eeeeee07aa9eeeeeeeeeeeee70eeeeee00000000eeee66777777eeee000000000000000000000000000000000000000000000000000000000000000000000000
eeeeee07aa9eeeeeeeeeeeee70eeeeee00000000ee666777777777ee000000000000000000000000000000000000000000000000000000000000000000000000
eeeeee07aa9eeeeeeeeeeeee70eeeeee00000000e66777777777777e000000000000000000000000000000000000000000000000000000000000000000000000
eeeee907aaa9eeeeeeeeeeee70eeeeee000000006666677777777777000000000000000000000000000000000000000000000000000000000000000000000000
eeee9a079aaa9eeeeeeeeeee70eeeeee00000000eeeeeeeeeeeeeeee000000000000000000000000000000000000000000000000000000000000000000000000
eeee9a07e9aa9eeeeeeeeeee70eeeeee00000000eeeeeeeeeeeeeeee000000000000000000000000000000000000000000000000000000000000000000000000
00000007000000000000000070000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888
88282888882228222822288888282888882228222828288888888888888888888888888888888888888888888888888888888888888888888888888888888888
88282882882828282888288888282882882828282828288888888888888888888888888888888888888888888888888888888888888888888888888888888888
88828888882828282888288888222888882828282822288888888888888888888888888888888888888888888888888888888888888888888888888888888888
88282882882828282888288888882882882828282888288888888888888888888888888888888888888888888888888888888888888888888888888888888888
88282888882228222888288888222888882228222888288888888888888888888888888888888888888888888888888888888888888888888888888888888888
88888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888888

__map__
0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d9e9f0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d060d
0d0d0d0d0d0d0d060d0d35360d0d0d0d0d0d0d0d0d0d0d35360d0d0d0d0d060d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0daeaf0d0d0d0d0d060d0d0d0d0d0d0d0d060d0d0d0d0d0d0d0d0d0d35360d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d
0d35360d0d0d0d0d0d0d0d0d0d0d0d060d0d0d0d140d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0dbebf0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d060d0d0d0d0d0d0d0d0d0d0d0d
4c4d4e4f1d1d1d1d4b4c4d4e4f45461e0d0d0d0d0d0d0d0d35360d0d0d0d0d80818283840d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d868788890d0d0d0d0d0d0d0d0d0d0d0d0d0d0d35360d0d0d0d060d0d0d0d0d0d0d0d0d35360d0d0d0d0d0d0d0d0d0d0d0d0d0d
5c5d5e5f092c2d1c5b5c5d5e5f55561c0d0d35360d0d0d1d1d1d1d1d1d1d1d90919293941d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d969798991d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d
6c6d6e6f6768696a6b6c6d6e6f6566671e1f2d2d2d15151515151515151515a0a1a2a3a4151515151515151515151515151515151515151515151515151515151515151f2d15151515151515a5a6a7a8a9aa15151515151515151515151515151515151515151515151515151515151515151515151515151515151515151515
18191a18191a18191a18191a18191a18192c2e1c2e090b150e151515150e15b0b1b2b3b41515090a0b0c0b0c0c151515151515150e15150e15151515150e15151515092c2e2c0c0a95959595b5b6b7b8b9ba959585959515151515150e15150c0a0c090b15150e15150e150e1515151515151515151515151515151515151515
0707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707
4040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040
0f0808080f080f08080808080808080f0808080f08080808080f0808080808080f080808080808080f08080808080808080f0808080808080808080f08080808080808080808080f0808080f08080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808
0808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808
3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e
3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e
3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e
3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e
3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e
3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e
3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e
3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e
3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e
3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e
3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e
3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e
3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e
3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e
3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e
3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e
3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e
3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e
3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e
3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e
3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e00000000000000000000000000000000000000000000
__sfx__
010c03032105321053210532105321053210532105321053210002100021000210000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0118000021150211501c1501d1501f1501f1501d1501c1501a1501a1501a1501d15021150211501f1501d1501c1501c1501c1501d1501f1501f15021150211501d1501d1501a150000001a150000000000000000
011800000c0531d10034655000000c053000003465500000100530000034655000000c0530c0003b655170000c0530000034655000000c053000003b655000000c05300000346553465500000000000000000000
010f01010000018253000000000018253000000000018253000000000000000000000000000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0118000015255152551025511255132551325511255102550e2550e2550e2551125515255152551325511255102551025510255112551325513255152551525511255112550e255000000e255000000000000000
010200002966128661286512765127651266412564125641246411c6412264121631206311e6311c6311b6311762114621106210c621086210661103611026110060000200006000020000000000000000000000
__music__
00 41024444
00 01020444

