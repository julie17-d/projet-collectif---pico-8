pico-8 cartridge // http://www.pico-8.com
version 29
__lua__
function _init()

--cest ou on intialise les variables du jeu 
 
 --player
	p={x=60,y=75,speed=1, life=3, timer=0}
	first_sprt = fget(1,0)
	
	--shake
	scr = {x =0,y =0 ,intensity = 5,shake = 0}
	
	
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
	
	--score
	
	score=0

--fientes

	mfientes={}
	fientes={}
	text_timer=0
	
	--cherche 
	
	--game state
	
	state="intro"

	--camera
	
	cam_x=p.x-60
	
	--sprites 
	
	mehmet_sprite=1
	d= 4
	mama_sprite=192
	mama={x=0,y=20,speed=1,life=50, timer=0}
	d2= 36
	skull_sprite=64
	d3=8
	
	--sfx
	
	sfx(1)
	music(0)
	
end

function _update60()

 if (state=="intro") then update_intro()
 elseif (state=="game") then update_game()
 else 
  text_timer+=1 
  laughing()
  if (btnp(⬇️)) then state = "intro"
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

function shoot()--tire 
	new_bullet={--creer nouvelle balle
		x=p.x,
		y=p.y,
		speed=4--
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
	cam_x=mid(0,cam_x,896)--bloquer julie????
	camera(cam_x)
end

function camera_pos()
  if scr.shake > 0 then 
   scr.x=(rnd(2)-1)*scr.intensity
   scr.y=(rnd(2)-1)*scr.intensity
   scr.shake -=1
  else
   scr.x=0
   scr.y=0
  end
 camera(scr.x,scr.y)
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
    		y=p.y+5
    		}
    		add(flaques, flaque)
    		if flaque.x < p.x-55
  or flaque.x > p.x+55 then
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

 scr.shake= 10

end




	


-->8
--draw
function draw_intro()
 cls(3)
 palt(0,false)
 map(005,024,0,0,26,9)
 print("ca vole pas haut",30,63,0)
 print("press ⬆️ to start",30,83)
 palt(0,true)
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
	 spr(51,v.x,v.y,2,1)
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
	
	--fientes
	
	for f in all(fientes) do
		draw_fientes()
	end
	
		for mf in all(mfientes) do
		draw_mfientes()
	end

--blood

drawblood()
	
	--shake 
	camera_pos()
	
	--score
	
	print("score "..score,scr.x+7,2,7)

 	--flaque
	if first_sprt==true then
	 draw_flaques()
	end

		--vie
	if p.life == 3 then
	 	spr(34,scr.x+95,1)
 		spr(34,scr.x+105,1)
 		spr(34,scr.x+115,1)
	elseif p.life == 2 then
		spr(35,scr.x+95,1)
 		spr(34,scr.x+105,1)
 		spr(34,scr.x+115,1)
	elseif p.life == 1 then
		spr(35,scr.x+95,1)
 		spr(35,scr.x+105,1)
 		spr(34,scr.x+115,1)
	end
end
	--gameover 
	
function draw_gameover()
  cls(2)
  local col=9
  if text_timer%8>4 then
 	 col=10
  end
  
  
		palt(15,true)
 	palt(0,false)
	 spr(skull_sprite,p.x-5,p.y-50,2,2)
  palt(0,true)
 	palt(15,false)
  
  print("gameover",p.x-13,p.y-30)
  print("score:"..score,p.x-10,p.y-20,col)
  print("⬇️ pour reessayer",p.x-29,p.y-10,10)

end


-->8
--update

function update_intro()
 if (btnp(⬆️)) then
 state="game"
 end
end


function update_gamewon()
	makeblood(10,60,60)
	if (btn(⬇️)) then
		state = "intro"
		_init()
	end
end

function update_dialogue()
 update_lignes()
 for s in all(stars) do 
  s.y+=s.speed
  if s.y > 128 then
   s.y=0
   s.x=rnd(128)
   if (btnp(➡️)) then 
    state="intro"
   end
  end
 end

end

function update_game()

--player

 if btn(➡️)	then 
 	p.x+=p.speed
 	walking()
  flaque.x-=p.speed+1
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
		update_mfientes()
	
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
--animations
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

function laughing()
d3-=1
 if d3<0 then
 skull_sprite+=3
  if skull_sprite > 67 then
  skull_sprite=64
  end
 d3=4
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


--fientes

function update_mfientes()
    for mfiente in all(mfientes) do 
        mfiente.y += new_mfientes.speed
        if mfiente.y > p.y+60 then 
            del(mfientes,mfiente)
        end
		if collision(p, mfiente)
		and first_sprt == false then
			del(mfientes, mfiente)
			create_explosions2(p.x,
		 	p.y)
			p.life -= 1
			first_sprt = true
		elseif collision(p, mfiente)
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

function draw_mfientes()

    spr(50,new_mfientes.x,new_mfientes.y)

end

function create_mfientes(x,y)
add(mfientes,{
    x = x,
    y = y,
    timer = 0
})
end


-->8
--mama

function update_mama()
	
	if mama.x<900 then
		mama.x+=rnd(mama.speed)
	 elseif mama.x== 900 then
	 mama.x=900
	end
	
--		collision/fientesm

if mama.x <  (p.x+1)
		and mama.x > (p.x-1) then
			new_mfientes = {
        	x=mama.x,
        	y=mama.y,
        	speed=rnd(4)
    		}
    		add(mfientes, new_mfientes)
	
		for b in all(bullets) do
	   	if collision(mama,b) then 
	   	screenshake(10)
	    end
		if collision(mama,b) then 
	    makeblood(10)
	    mama.life -=1
	    end
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



function makeblood(nb)
 while (nb > 0) do 
  bl = {}
  bl.x =mama.x+16
  bl.y =mama.y+16
  bl.col =flr(rnd(16))
  bl.dx =rnd(2)-1
  bl.dy =rnd(2)-1
  add(blood,bl)
  nb -= 1  
 end
end


function drawblood()
 for bl in all(blood) do
 pset(bl.x,bl.y,8)
 bl.x += bl.dx
 bl.y += bl.dy
 end
  
end
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
000000007700007777000077770000777700007777000077eeeeeeee666666666666666699999999999911111999999999911199eeeeeeee9933b99966666666
000000007704457777044577770445777704457777044577eee66eee666666666666666699999111119911111999999999111199eeeeeeee93bbbb996663b666
007007007740447777404477774044777740447777404477ee6777eedddddddd6666666699999111119911111999999999111119eeeeeeee3bbbbbb9663bbb66
000770007740007777400077774000777740007777400077e677777edddddddd6666666691199111119911111999999911111119eeeeeeeebbbbbbb963bbbbb6
00077000773357777733577777335777773357777733677766677777dddddddd6666666611111111111111111911199111111111eeeeeeeebbbbbbb933bbbbbb
007007007734577777345777773457777734577777346777eeeeeeee999ddd996666666611111111111111111911199111111111eeeeeeee99bbb9993bbbbbbb
000000007714177777411777771147777711477777141777eeeeeeeeaaadddaa6666666611111111111111111111111111111111eeeeeeee3994939366644666
000000007717177777177177717717777717177771771777eeeeeeeedddddddd6666666611111111111111111111111111111111eeeeeeeeb3343b3366644666
000000006666666600000000000b0000eeeeeeee999999994a444111000ddd001111111111111111111111117788887744a49444eeeeeeee4444eeee44a44a4e
0000000088888886000a000000000000ee99aeee999999991114411100086d0011111111111111111111111177888877444494a4eeeeeeee4444eeee4444444e
000000008888888000000000000b0000e99aaaee999999991114a11100966d0011111111111111111b31111177888877a4441111e9e9e9e9a444eeee44442222
0000000082288880000a0000000000009aaaaaae9999999911144111000666d01111b1bb11b31111b33b3b1177888877114411119e9e9e9e444494444a422222
000000008288888800000000000b00009aaaaaae9999999911111111000dddd0111bbbb3b333b311333333b17788877711141111999999994444944a44427227
0000000022888880000a0000000b00009aaaaaae9999999911111111000a00001bbbbbb33b33333b3b3b333b7788877711111111999999994a44944444222222
00000000060000000000000000000000e99aaaee999999991111111100000000bbbbbb3b33333b3333333333778887771111111199999999444494a4a4272272
0000000000000000000a0000000b0000ee999eee999999991111111100000000bbbbbb3b3333333333b333b37787787711111111999999994444944444222222
999999999999999908800880088008800000000099999999dddddddd666666666666666666666666666666667788887711111122eeeeeeee22224a4900000000
999999999999999987888888800880080000000099999999dddddddd666666666666666666666666666666667788887711111112eee4444e2272111100000000
999993999999999987888888800000080006600099999999dddddddd666666666666666666666666666666667788887711111112229444492222111100000000
99933b393b99999988888888800000080067770099999999dddddddd6666666666660000000066666666666677888877111111122224444e2112111100000000
933b3bb3b3b9999908888880080000800677777099999999666666666666666666660bbbbbbb066666666666778887771111111272224a491111111100000000
3bbbbbbb3333b39900888800008008006667777799999999666666666666666666600bbbbbbb3066666666667788877711111112227244491111111100000000
bbb3bb3b3b33333b0008800000088000000000009898989866666666666666666600bb00b00bb306666666667788877711111111722244491111111100000000
b3bbbbbb33333b33000000000000000000000000898989896666666666666666600bb000b000bb300666666677878777111111112222a4491111111100000000
b000000066666666000330000000000000000000eeeeee6777eeeeee6666666600bb0000b0000bbb30006666000000000000000000000000cccccccc00000000
0000000b666666660003b0000000000000000000eeeee667777eeeee666600000bbbbbbbbbbbbbbbbb770666000000000000000000000000cccccccc00000000
00bbb00066bbb6660003b0000077700077700777eeee66777777eeee66660bbbbbb3b33b3bb33b3bbbb70666000000000000000000000000cccccccc00000000
0b77bbb06b77bbb600000000077c00077c0077c0ee666677777777ee6666033bbbb3bbbb3bbbbb3bbbbb0666000000000000000000000000cccccccc00000000
0b777b006b777b660000000007cc707ccc707cc7e66666777777777e666603bbbb00bbbb3bbbb00bbb000666000000000000000000000000cccccccc00000000
00b7bb0066b7bb66000330007c00c7cc0cc7cccc66666677777777776666000000d0033333330d0000066666000000000000000000000000cccccccc00000000
b000000066bbb6660003b0000000000000000000eeeeeeeeeeeeeeee66666666600d0666666600d066666666000000000000000000000000cccccccc00000000
00000000666666660003b0000000000000000000eeeeeeeeeeeeeeee66666666660066666666600666666666000000000000000000000000cccccccc00000000
ffffffffffffffffffffffffffffffffffffffffffffffffffffffff3333333333333333333333333333333300033333333333331111111111eeeeeeeeeeeeee
fffff5555ffffffffffff5555ffffffffffff5555fffffff5fffffff33333333333333333333333333333000ddd00033333333331111111111222222222eeeee
fff55666655ffffffff55666655ffffffff55666655fffff655fffff33333333333333333333333333300ddddddddd00333333331111111111222222222eeeee
ff5667777665ffffff5667777665ffffff5667777665ffff7665ffff333333333333333333333333330ddddddddddddd033333331111111111222222222eeeee
f567777777765ffff567777777765ffff567777777765fff77765fff33333333333333333333333330ddddddddddddddd033333311111111112222222229e9e9
f5677666777765fff5677666777765fff5677666777765ff777765ff3333333333333333333333330ddddddddddddddddd0333331111111111222222222e9e9e
f5676700677005fff5676000670005fff5676000670005ff670005ff3333333333300033333333330dddddddddddddddddd00000111111111122222aa2244449
f56707706777065ff56700706707065ff56700006700065f6707065f333333333303330333333330ddddddddddd00ddddddd0ddd111111111122222aa2244449
f56660006060065ff56660006060065ff56660006060065f6060065f333333333303030333333333dddddddddd0e0dddddddd00d111111111122222aa2244a49
ff5677770007765fff5677770007765fff5677770007765f0007765f333333333330330333000033dddddddddd040ddddddddddd111111111122222222244449
ff5600666666665fff5600666666665fff5600666666665f6666665f333333333333303333000003dddd6dddd0e4011dd1dd11dd11111111112222222224a449
fff55067070765fffff55066666665fffff55066666665ff666665ff3333333333300000000000030dd66666d1001111111ddddd111111111122222222244449
fffff560000065fffffff560000065fffffff560000065ff000065ff3333333333000000000000030dd6666661111111111111dd111111111122222222111111
fffff560707065fffffff560707065fffffff566666665ff707065ff3333333330000000000000033066666666111111111111dd111111111122222222111111
ffffff5666665fffffffff5666665fffffffff5666665fff66665fff3333333300000000000000033066666666611111111111dd111111111122222222111111
fffffff55555fffffffffff55555fffffffffff55555ffff5555ffff333333330000000000000003330060a0090011111111111d111111111122222222111111
6666666600bb0000b0000bbb30006666eeeeeeeeeeeeee111111144133333330000000000000003333090aa99091111111111113111111111122a21111111111
666600000bbbbbbbbbbbbbbbbb77066644444eeeeeeee2111111144133333300000000000444423333099aa90901111111111133111111111122a21111111111
66660bbbbbb3b33b3bb33b3bbbb7066644444eeeeeeee211111114413333330000000004444542333309aaa90901111111113333111111111122a21111111111
6666033bbbb3bbbb3bbbbb3bbbbb066644444e9e9e9e921111111441333333000ff00444444442333309aa909011111111113333111111111122221111111111
666603bbbb00bbbb3bbbb00bbb00066644a449e922222211111114a133333300f44f4055554552233309aa909011111111113333111111111122221111111111
6666000000d00333333300d0000666664444444422222211111114413333333040424250005450233309aa909011111113333333111111111111111111111111
66666666600d066666660d00666666661144444422222211111114413333333440052257000440233309a9090111111333333333111111111111111111111111
66666666660066666666600666666666111144a422222211111114413333333344252245554f2233333099090111111333333333111111111111111111111111
44420055655533353333777700000000111114442222a2111111111133333333044552244445f423333099003333333333333333111111111111111111111111
44f22002555665563337777700000000111111411122a21111111111333333332005552244557223333099003333333333333333111111111111111111111111
444f240577777767337777770000000011111111112222111111111133333333205555555445ff23333099033333333333333333111111111111111111111111
24474250f77777777777777700000000111111111122221111111111333333332055555444422233333090333333333333333333111111111111111111111111
4f2472550f7777777777777700000000111111111112221111111111333333334225554455220233333300333333333333333333111111111111111111111111
2422ff55707777777777777700000000111111111112221111111111333333344405554552442233333333333333333333333333111111111111111111111111
77777777777777777777777700000000111111111112221111111111333333544420555555202333333333333333333333333333111111111111111111111111
77777777777777777777777700000000111111111112221111111111333335554420555555f22333333333333333333333333333111111111199999999111111
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee99999999eeeeeeeeeeeaffafffffaffaeeeeeeee6666666666666666666666666666666699993b9999111111
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee99333399eeeeeeeaaaaaaaaaaaaaaaaaaaaaeeee66666666666666666666666666666666393bbbbb99111111
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee93333339eeeeeeafffffffffffffffffffffaeee66666666666666666666666666666666bbbbbbb399111111
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee333b3333eeeeeeaffaaaaaaaaaaaaaaaaaffaeee66666666666666666666666666666666bbbb3bbb99111111
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee33bbbb33eeeeeeeadddddddddddddddddddaeeee66666666666600000000666666666666bbbbbbbb99111111
eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee3bbbbbb3eeeeeeeeafafa6d6d6d66dafafaeeeee666666666600222288806666666666663bbbbbbb99111111
eeeeeefafafafafafafafafafafafafadddddeeebbbbbbbbeeeeeeeeafafad6d6666d6dfafaeeeee66666666600288888888066666666666bbbbbbbb99111111
eeeeeaaaaaaaaaaaaaaaaaaaaaaaaaaaaddddeeebbbbbbbbeeeeeeeafafaad6dddddd6dafafaeeee66666660002880080088000666666666bbbbbbbb11111111
eeeeeaaaaaaaaaaaaaaaaaaaaaaaaaaaadd66eee99999999eeeeeeeafafaad6d6666d6dafafaeeee666600002288000800088800000666661111111111111111
eeeeeedddddddddddddddddddddddddddddddeee39999999eeeeeeaaaaaad6dddddddd6daaaaaeee66607728888000080000888888066666eeeeeeeafafaeeee
9e9e7777777777777777777777777777777777e9b3939999e9e9e9afafa6d6d9e9e9ed6dafafa9e966607288882888828888288822066666eeeeeeeaaaaaeeee
e9e9affaaaaaaaaaaaaffaaaaaaaaaaaaddddd9ebbbbb9999e9e9afaffa6d6de9e9e9d6daffafa9e66602888882822828228288882066666eeeeeeeafafaeeee
9999aaaaaaaaffaaaaaaaaaaaffaaaaaaddddd99bbbbbb9999999afaffad6d99999999d6affafa9966602888002888828888008888066666eeeeeeeaaaaaeeee
99999dddddddddddddddddddddddddddddddd999b3bb3bbb9999aaaaaa6d6d99999999d6daaaaaa966600000d00222222220d00000066666eeeeeeeafafaeeee
99999aaaaaaaaaaaaaaaaaaaaaaaaaaaddddd999bbbbbbb39999afaffa6d6d99999999d6daffafa9666666600d06666666600d0666666666eeeeeeeaaaaaeeee
999999dddddddddddddddddddddddddddd66d999bbbb3bbb999affaffad6d9999999999d6dffaffa66666666006666666666006666666666eeeeeeeafafaeeee
999999ddddddddddddddddddddddddddddddd99999999999aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa99999eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeafafaeeee
999999aaaaaaaaaaaaaaaaaaaaaaaaaaddddd9999999999afffffffffffffffffffffffffffffffffffa9999eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeaaaaaeeee
999999aaaaaffaddaaddddaaddaaaaaaddddd9999999999afffaaaaaaaaaaaaaaaaaaaaaaaaaaaaafffa9999eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeaffaffaeee
999999aaaaaaaadaaddd999aadaaaffad66dd9999999999aaadddddddddddddddddddddddddddddddaaa99992222222eeeeeeeeeeeeeeeeeeeeeeeaffaffaeee
999999affaaaaaaaddd99999aaaaaaaaddddd999999999999affafaaaaaaaaaaaaaaaaaaaaaaafaffa9999992222222eeeeeeeeeeeeeeeeeeeeeeeaaaaaaaeee
999997777777777777999997777777777777779999999999affaffaaaffafafafafafafaffaaaffaffa999992222224444444444eeeeeeeeeeeeeeaffaffaeee
999999dddddddddddd999999ddddddddddddd99999999999affafaaffaaaaaaaaaaaaaaaaaffaafaffa999992222224444444444eeeeeeeeeeeeeeaffaffaeee
999999aaaaaaaadddd999999aaaaaaaaddddd9999999999afffffaaffaaadddddddddddaaaffaafffffa999922aa22444444aa44eeeeeeeeeeeeeaffafaffaee
999999aaaaaaffdddd999999aaaaaaaaddddd9999999999aaaaaaaaaaadd6d6666666d6ddaaaaaaaaaaa939322aa22444444aa44eeeeeeeeeeeeeaaaafaaaaee
999999aaaaaaaadddd999999aaaaaffaddddd999bb399999afffaaaadd6666ddddddd6666ddaaaafffaa339322aa22444444aa44eeeeeeeeeeeeeaffafaffaee
999999aaaaaaaad66d999999aaaaaaaaddddd999bbb33933affaaadd6666dd9999999dd6666ddaaaffaa3b9b2222224444444444eeeeeeeeeeeeeaffafaffaee
999999affaaaaadddd999999aaaaaaaaddddd999bbbbb33333faa66d66dd99999999999dd66d66aaffaa3bbb2222224444444444eeeeeeeeeeeeafffafafffae
399999aaaaaaaadddd999999affaaaaaddddd999b3bbbbb333fa66d66d999999999999999d66d66a3b3b33b322222244aa444444eeeeeeeeeeeeaaaafffaaaae
3b3993aaaaaffadddd999999aaaaaaaaddd66999bbbbb3bbb33336d6d99999999999999999d6d663bbbbb3bb22222244aa444444eeeeeeeeeeeeaffafffaffae
33333baaaaaaaa66dd999999aaaaaffaddddd999bb3bbbbbbb333663b99999999999999999ddbb3bbb3bbb3322222244aa444444eeeeeeeeeeeafffafffafffa
b33b33aaaaaaaadddd999999aaaaaaaaddddd999bbbbbb3bbbb3333bb3999999999999999933bb3bb3bbb3b32222224444444444eeeeeeeeeeeaffafffffaffa
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
7e4d4e4f1d4e1d6466644d4e4fabac1e0d0d0d0d0d0d0d0d35360d0d0d0d0d0d818283840d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d868788890d0d0d0d0d0d0d0d0d0d0d0d0d0d0d35360d0d0d0d060d0d0d0d0d0d0d0d0d35360d0d0d0d0d0d0d0d0d0d0d0d0d0d
7e5d5e5f092c4d4d76745d5e5fbbbc1c0d0d35360d1d1d1d1d1d1d1d1d1d1d90919293941d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d969798991d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d
7e6d6e6f7f7f7f7f7f7f6d6e6f6e667f1e1f2d2d2d15151515151515151515a0a1a2a3a4151515151515151515090a0c151515151515151515151515151515151515151f2d15151515151515a5a6a7a8a9aa1515151515150a0b1515151515151515151515151515151515151515151515151515151515151515151515151515
18191a18191a18191a18191a18191a18192c2e1c2e090b200e202120210e20b0b1b2b3b40e0e090a0b0c0b0c0c18191a1820210e0e20210e15151515150e15151515092c2e2c0c0a8e8e8e8eb5b6b7b8b9ba8e8e8e8e9520191a20210e20210c0a0c090b20210e20210e200e1515151515151515151515151515151515151515
0707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707
2626262626262626262626262626262626262626262626262626262626262626262626262626262626262626262626262626262626262626262626262626262626262626262626262626262626262626262626262626262626262626262626262626262626262626262626262626262626262626262626262626262626262626
0f0808080f080f08080808080808080f0808080f08080808080f0808080808080f080808080808080f08080808080808080f0808080808080808080f08080808080808080808080f0808080f08080808080808080808080808080808080808080808080808080808080808080808310808083108080808080808310808080808
0808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808083108080808080831080808080831080808080808080808
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
3e3e3e3e3e474747474747474747474747474747473e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e
3e3e3e3e3e474748474747474747474747474747473e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e
3e3e3e3e3e475758597c7c7c7c7c474747474747473e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e
3e3e3e3e3e476768694747474747477c47474747473e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e
3e3e3e3e3e4777787947474747474747474a4b4c473e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e
3e3e3e3e3e477270714747474747477c475a5b5c473e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e
3e3e3e3e3e474747474747474747477c476a6b6c473e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e
3e3e3e3e3e47474747474747477c7c7c477a7b7c473e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e00000000000000000000000000000000000000000000
__sfx__
010c03032105321053210532105321053210532105321053210002100021000210000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0118000021150211501c1501d1501f1501f1501d1501c1501a1501a1501a1501d15021150211501f1501d1501c1501c1501c1501d1501f1501f15021150211501d1501d1501a150000001a150000000000000000
011800000c0531d10034655000000c053000003465500000100530000034655000000c0530c0003b655170000c0530000034655000000c053000003b655000000c05300000346553465500000000000000000000
010f01010000018253000000000018253000000000018253000000000000000000000000000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0118000015255152551025511255132551325511255102550e2550e2550e2551125515255152551325511255102551025510255112551325513255152551525511255112550e255000000e255000000000000000
010200002966128661286512765127651266412564125641246411c6412264121631206311e6311c6311b6311762114621106210c621086210661103611026110060000200006000020000000000000000000000
011000000e7450e7450e7451374013740137401374013740137401a7401a7401a7401a7401a7401a7401874010740157401f7401f7401f7401f7401f7401f7401a7401a7401a740187401c740217401f7401f740
011000000000000000000000712007120071250612006120061250412004120041250212002120021250012000120001250712007120071250612006120061250412004120041250212002120021250712007120
011000001f7401f7401f7401f7401a7401a7401a7401874010740187401574015740157400e7400e7400e7400e7400e7400e74000000000000000000000000000000000000000000000000000000000000000000
011000000712506120061200612504120041200412506120061200612502120021200212002120021200212002120021200212000000000000000000000000000000000000000000000000000000000000000000
__music__
00 41024444
00 01020444
00 06074344
04 08094344

