pico-8 cartridge // http://www.pico-8.com
version 29
__lua__
function _init()
	p={x=60,y=60,speed=1,life=3}
	bullets={}
	pigeons={}
	explosions={}
	score=0
	sfx(1)
end

function _update60()
	if (btn(➡️))	p.x+=p.speed
	if (btn(⬅️)) p.x-=p.speed
	if (btnp(❎)) shoot()
 	if p.x < 0 then
 		p.x = 0
 	end
 	if p.x > 1000 then
 		p.x = 1000
 	end
	
	update_bullets()
	if #pigeons==0 then
		spawn_pigeons(rnd(7))
	end
	update_pigeons()
	update_explosions()
	
	camera_follow()
end

function _draw()
	cls(13)
	map(0,0,0,0)
	
	--player
	spr(1,p.x,p.y)
	
	--pigeons
	for e in all(pigeons) do
		spr(23,e.x,e.y)
		spr(2,e.x+15,e.y-10)
	end
	
	--explosions
	draw_explosions() 
	--shoot
	for b in all(bullets) do
		spr(18,b.x,b.y)
	end
	--score
	print("score "..score,cam_x+7,2,7)
	--vie
	spr(34,cam_x+95,1)
 spr(34,cam_x+105,1)
 spr(34,cam_x+115,1)
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
		x=p.x+68,
		y=10,
		life=2
	})
 end 
end

function update_pigeons()
	for pigeon in all(pigeons) do
		pigeon.x-= 0.5
		if pigeon.x < p.x-68 then
			del(pigeons,pigeon)
		end
	end
end
	
		
		--collision
		for b in all(bullets) do
			if collision(pigeon,b) then
		 	create_explosions(pigeon.x,pigeon.y)
				del(bullets,b)
				pigeons.life-=1 
				if pigeon.life==0 then
			 	del(pigeons,pigeon)
			  score+=100
		 	end
	 	end
	end

-->8
--collision
					
function collision(a,b)
	if a.y+4 < b.y then
		if a.x > b.x+4
		or a.x+4 < b.x then
			return false
		else
			return true
		end
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

	circ(pigeons.x,pigeons.y,2,12)

	for e in all(explosions) do
		circ(e.x,e.y,e.timer/3,8+e.timer%3)
	end
end
	

-->8
--menu intial


__gfx__
000000000055500000000000000000000055500000ddd000eeeeeeee666666666666666699999999999911111999999999911199eeeeeeee9993999966666666
00000000005f700000ddd00005550000005f700000dd8000eee66eee666666666666666699999111119911111999999999111199eeeeeeee993bb9996663b666
0070070000fff000008d800005f7000000fff00000d66900ee6777eedddddddd6666666699999111119911111999999999111119eeeeeeee93bbbb99663bbb66
0007700000ccfff000d9d0000fff000000ccc0000d666000e677777edddddddd6666666691199111119911111999999911111119eeeeeeee3bbbbbb963bbbbb6
0007700000cc6000666666600ccc000000cfc0000ddda00066677777dddddddd6666666611111111111111111911199111111111eeeeeeee9bbbbb9933bbbbbb
0070070000111000dd666dd00cfc0000011f10000000a000eeeeeeeeaaaddaaa6666666611111111111111111911199111111111eeeeeeee99bbb9993bbbbbbb
000000000010100000d6d00001f111000000100000000000eeeeeeeedddddddd6666666611111111111111111111111111111111eeeeeeee9994999966644666
000000000010100000a0a000010000000000100000000000eeeeeeeedddddddd6666666611111111111111111111111111111111eeeeeeee9994999966644666
eeeeeeeeeeeeeeee00000000000b0000eeeeeeee999999994a444111000ddd00eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee44a49444eeeeeeee4444eeee44a44a4e
eeeeeeeeeeeeeeee0000000000000000ee99aeee999999991114411100086d00eeeeeeeeeeeeeddddddeeeeeeeeeeeee444494a4eeeeeeee4444eeee4444444e
eeeeeeeeeeeeeeee00000000000b0000e99aaaee999999991114a11100966d00eeeeeeeeeeeeddddddddeeeeeeeeeeeea4441111e9e9e9e9a444eeee44442222
eeeeeeeeeeeeeeee000a0000000000009aaaaaae9999999911144111000666d0eeeeeeeeeeeddddddddddeeeeeeeeeee114411119e9e9e9e444494444a422222
eeeeeeeeeeeeeeee00000000000b00009aaaaaae9999999911111111000dddd0eeeeeeeeeedd888dd888ddeeeeeeeeee11141111999999994444944a44427227
eeeeeeee5eeeeeee00000000000b00009aaaaaae9999999911111111000a0000eeeeeeeeeedd80866808ddeeeeeeeeee11111111999999994a44944444222222
eeeeeeee5eeeeeee0000000000000000e99aaaee999999991111111100000000eeeeeeeeeedd80866808ddeeeeeeeeee1111111199999999444494a4a4272272
eeeeeee5a5eeeeee00000000000b0000ee999eee999999991111111100000000eeeeeeeeeeddd699996dddeeeeeeeeee11111111999999994444944444222222
eeeeee5aaa5eeeee088008800880088000000000000000000000000000000000eeeeeeeeeeddd699996dddeeeeeeeeee11111122eeeeeeee22224a4900000000
eeeeee5aaa5eeeee878888888008800800000000000000000000000000000000eeeeeeeeeeedd699996ddeeeeeeeeeee11111112eee4444e2272111100000000
eeeeeee5a5eeeeee878888888000000800000000000000000000000000000000eeeeeeeeeeeedd7000ddeeeeeeeeeeee11111112229444492222111100000000
eeeeeee5a5eeeeee888888888000000800000000000000000000000000000000eddddddddddddd7999ddddddddddddee111111122224444e2112111100000000
eeeeeee5a5eeeeee088888800800008000000000000000000000000000000000eed666666666d666666d66666666deee1111111272224a491111111100000000
eeeeeee5a5eeeeee008888000080080000000000000000000000000000000000eeeddd666666d666666d6666666deeee11111112227244491111111100000000
eeeeeee5a5eeeeee000880000008800000000000000000000000000000000000eeeeed66ddddd666666ddddd66deeeee11111111722244491111111100000000
eeeeeee5a5eeeeee000000000000000000000000000000000000000000000000eeeeeedd6666d666666d6666ddeeeeee111111112222a4491111111100000000
eeeeeee5a5eeeeee000000000000000000000000eeeeee6777eeeeee00000000eeeeeeeedd66d666666d66ddeeeeeeee0000000000000000cccccccc00000000
eeeeeee5a5eeeeee000070000000000000000000eeeee667777eeeee00000000eeeeeeeeeeddd666666dddeeeeeeeeee0000000000000000cccccccc00000000
e9e9e9e5a5e9e9e90b0070b00000000000000000eeee66777777eeee00000000eeeeeeeeeeeeddddddddeeeeeeeeeeee0000000000000000cccccccc00000000
9e9e9e5aaa599e9e000000000000000000000000ee666777777777ee00000000eeeeeeeeeeeedddeedddeeeeeeeeeeee0000000000000000cccccccc00000000
9999995aaa599999000b00000000000000000000e66777777777777e00000000eeeeeeeeeeeedddeedddeeeeeeeeeeee0000000000000000cccccccc00000000
999995aaaaa59999000000b00000000000000000666667777777777700000000eeeeeeeeeeeeaaaeeaaaeeeeeeeeeeee0000000000000000cccccccc00000000
99995aaaaaaa59990b0070000000000000000000eeeeeeeeeeeeeeee00000000eeeeeeeeeeeeaaaeeaaaeeeeeeeeeeee0000000000000000cccccccc00000000
99995aa555aa5999000070000000000000000000eeeeeeeeeeeeeeee00000000eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee0000000000000000cccccccc00000000
99995aa555aa599999999999eeeeeeee00000000eeeeeeeeeeeeeeee00000000eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee00000000000000000000000000000000
9995aaa555aaa59999999999eeeeeeee00000000eeeeeeeeeeeeeeee00000000eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee00000000000000000000000000000000
9995aaaaaaaaa59999999999eeeeeeee00000000eeeeeeeeeeeeeeee00000000eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee00000000000000000000000000000000
995aaaaaaaaaaa5999999999eeeeeeee00000000eeeeeeeeeeeeeeee00000000eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee00000000000000000000000000000000
95aaaa55555aaaa599999999eeeeeeee00000000eeeeeeeeeeeeeeee00000000eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee00000000000000000000000000000000
5aaaa5599955aaaa59999999eeeeeeee00000000eeeeeeeeeeeeeeee00000000eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee00000000000000000000000000000000
5aaa599999995aaa59999999eeeeeeee00000000eeeeeeeeeeeeeeee00000000eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee00000000000000000000000000000000
555559999999555559999999eeeeeeee00000000eeeeeeeeeeeeeeee00000000eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee00000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000ee000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3
e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e300000000000000000000000000000000000000000000
e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3000000000000
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
0d0d0d0d0d0d0d0d0d0d35360d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d060d
0d0d0d0d0d0d0d060d0d45460d0d0d0d0d0d0d0d0d0d0d35360d0d0d0d0d060d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d060d0d0d0d0d0d0d0d060d0d0d0d0d0d0d0d0d0d35360d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d191a0d0d0d
0d35360d0d0d0d0d0d0d0d0d0d0d0d060d0d0d0d140d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d060d0d0d0d0d0d28292a2b0d0d
0d45460d0d0d0d35360d0d0d0d0d0d0d0d0d0d0d0d10110d35360d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d35360d0d0d0d0d0d0d0d0d0d0d0d0d35360d0d0d0d060d0d0d0d0d0d0d0d0d35360d0d0d0d0d0d0d0d0d393a0d0d0d
0d0d0d0d060d0d0d0d0d0d0d060d0d0d0d0d35360d20210d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d060d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d0d060d
1d1d1e1f2d1d1d1f1d1d1d1d1e1d1d1d1e1f2d1d1d30311d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1f2d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d1d
090a1c2c2e0a0b2c090b090a1c0c0b0a1c2c2e0e154041420e151515150e1515150e15151515090a0b0c0b0c0c151515151515150e15150e15151515150e15151515092c2e2c0c0a15151515150e15150e15151515150e15151515150e15150c0a0c090b15150e15150e150e1515151515151515151515151515151515151515
0707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707
08080f08080808080f08080f0808080808080808080808080f08080f08080808080808080f0808080808080f080808080808080808080f080808080808080808080f0808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808
0f0808080f080f08080808080808080f0808080f08080808080f0808080808080f080808080808080f08080808080808080f0808080808080808080f08080808080808080808080f0808080f0808080f080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808080808
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
3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e
3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e3e00000000000000000000000000000000000000000000
__sfx__
010c03032d0532d0532d0532d0532d0532d0532d0532d053000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0111000021150211501c1501d1501f1501f1501d1501c1501a1501a1501a1501d15021150211501f1501d1501c1501c1501c1501d1501f1501f15021150211501d1501d1501a150000001a150000000000000000
011000000c0531d10034655000000c152000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
010f01010000018233000000000018233000000000018233000000000000000000000000000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__music__
00 01424344

