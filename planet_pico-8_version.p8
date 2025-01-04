pico-8 cartridge // http://www.pico-8.com
version 38
__lua__
--planet (pico-8 cover)
--by meivu


function _init()
	cls()
	particles={}
	front_particles={}
	stars={}
	for i=0,90 do
		do_update()
	end
	for i=0,32 do
		add(stars,{
			x=rnd(216)-56,
			y=rnd(96),
			r=flr(rnd(3)),
			draw=function(sf)
				star(sf.x,sf.y,sf.r)
			end
			}
		)
	end
	music(0)
end

function _update()
	do_update()
end

function do_update()
	for i=0,5 do
		local w = rnd(3)
		local vw= 0.6
		local aw= -0.010-(0.03*rnd())
		add(particles,make_particle(24,48,w,w,rnd()*-1.5,(rnd())*1.5,vw,vw,true,0.05,-0.002,aw,aw,0,{7,10,10,10,10,9,8}))
	end
	for i=0,1 do
		local w = rnd(3)
		local vw= 0.7
		local aw= -0.04-(0.03*rnd())
		add(particles,make_particle(24,48,w,w,(rnd()-0.5)*1.5,(rnd()-0.5)*1.5,vw,vw,true,0,0,aw,aw,0,{7,10,10,10,10,9,8}))
	end
	if flr(time()*10)%20==0 then
		local w = 2+rnd(2)
		local vw= -0.001--0.7
		local aw= 0--0.04-(0.03*rnd())
		add(front_particles,make_particle(-48,136,w,w,rnd()*0.8,rnd()*-0.5,vw,vw,true,0,0,aw,aw,1,{7,10,10,10,10,9,8}))
	end
	for i in all(particles) do
		i.update(i)
	end
	for i in all(front_particles) do
		i.update(i)
	end
end

function _draw()
	cls()
	camera()
	camera(min(sin(time()/16),0.99)*36,0)
	for i in all(stars) do
		i.draw(i)
	end
	camera(min(sin(time()/16),0.99)*34,0)
	far_hill(16,120,32)
	camera(min(sin(time()/16),0.99)*32,0)
	far_hill(56,96,10)
	camera(min(sin(time()/16),0.99)*30,0)
	far_hill(96,98,16)
	camera(min(sin(time()/16),0.99)*28,0)
	far_hill(128,108,24)
	camera(min(sin(time()/16),0.99)*20,0)
	far_hill(104,104,24)
	camera(min(sin(time()/16),0.99)*28,0)
	far_hill(72,104,16)
	camera(min(sin(time()/16),0.99)*24,0)
	far_hill(52,112,20)
	camera(min(sin(time()/16),0.99)*22,0)
	hill(28,104,12)
	camera(min(sin(time()/16),0.99)*20,0)
	hill(0,112,32)
	camera(min(sin(time()/16),0.99)*18,0)
	hill(96,128,40)
	camera(min(sin(time()/16),0.99)*14,0)
	hill(32,112,16)
	camera(min(sin(time()/16),0.99)*12,0)
	hill(72,136,40)
	camera(min(sin(time()/16),0.99)*8,0)
	hill(8,152,56)
	camera(min(sin(time()/16),0.99)*6,0)
	hill(56,160,48)
	camera(min(sin(time()/16),0.99)*4,0)
	hill(152,160,80)
	camera(min(sin(time()/16),0.99)*24,0)
	for i in all(particles) do
		i.draw(i)
	end
	camera()
	pal(12,0)
	spr(0,0,0,64,64)
	pal()
	camera(-min(sin(time()/16),0.99)*36,0)
	for i in all(front_particles) do
		i.draw(i)
	end
end
-->8
function make_particle(x,y,w,h,vx,vy,vw,vh,fill,ax,ay,aw,ah,vc,cl)
	return {
		x=x,
		y=y,
		w=w,
		h=h,
		c=1,
		vx=vx,
		vy=vy,
		vw=vw,
		vh=vh,
		ax=ax,
		ay=ay,
		aw=aw,
		ah=ah,
		vc=vc,
		cl=cl,
		fill=fill,
		update=function(sf)
			if sf.x-(sf.w/2)>200 or sf.y+(sf.w/2)<0 then
			 del(particles,sf)
			 del(front_particles,sf)
			end
			sf.x+=sf.vx
			sf.y+=sf.vy
			sf.w+=sf.vw
			sf.h+=sf.vh
--			sf.vx+=sf.ax
--			sf.vy+=sf.ay
			
			sf.vw+=sf.aw
			sf.vh+=sf.ah
			if sf.vw>0 and sf.w<8 then
				sf.c=1
			elseif sf.vw<=0 and sf.w<8 then
				sf.c=7
			else
				if sf.w<20 and sf.vw<0 then
					sf.c=6
				else
					sf.c=2
				end
			end
			if sf.vc==1 then
				sf.c=2
				sf.vy+=(-0.35-sf.vy+(sin((time()*3)+sf.w*10)*4))/12
				sf.vx+=((0.5+(sf.w-2)/2)-sf.vx)/12
				sf.h=sf.w*sin(time()+((sf.w-2)*5))
			end
			if sf.ax!=0 and sf.vc!=1 then
				if sf.c==9 then
					sf.vy-=(-0.35-sf.vy)
					sf.vx-=(0.7-sf.vx)
				elseif sf.c==8 then
					sf.vy-=(-0.35-sf.vy)/2
					sf.vx-=(0.7-sf.vx)/2
				else
					sf.vy+=(-0.35-sf.vy)/12
					sf.vx+=(0.7-sf.vx)/12
				end
			end
--			if flr(sf.c)<count(sf.cl) then
--				del(particles,sf)
--						sf.c+=sf.vc
--			end
			if sf.w<=0 or sf.h<=0 then
				del(particles,sf)
			end
		end,
		draw=function(sf)
			if sf.fill then
				ovalfill(sf.x-(sf.w/2),sf.y-(sf.h/2),sf.x+(sf.w/2),sf.y+(sf.h/2),sf.cl[flr(sf.c)])
			else
				oval(sf.x,sf.y,sf.x+sf.w,sf.y+sf.h,sf.cl[flr(sf.c)])
			end
		end
	}
end

--function hill(x,y,r)
--	circfill(x,y,r,2)
--	circfill(x,y,r*0.95,1)
--	circfill(x,y,r*0.8,0)
--end

function hill(x,y,r)
	local point=atan2(24-x,48-y)
	local c=cos(point)*r/(10-sin(time()*3))
	local s=sin(point)*r/(10-sin(time()*3))
	circfill(x,y,r,2)
	circfill(x-c,y-s,r,1)
	circfill(x-(c*3),y-(3*s),r,0)
end

function far_hill(x,y,r)
	local point=atan2(24-x,48-y)
	local c=cos(point)*2*r/(10-sin(time()*3))
	local s=sin(point)*2*r/(10-sin(time()*3))
	circfill(x,y,r,1)
	circfill(x-c,y-s,r,0)
end

function star(x,y,r)
	local c=flr(6+rnd(2))
	circfill(x,y,r,c)
--	line(x-(r*1.5),y,x+(r*1.5)+0.5,y,c)
--	line(x,y-(r*1.5),x,y+(r*1.5)+0.5,c)
end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000ccccccc000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000cc9999994cc0000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000c99999999994c000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000c9999999999994c00000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000c99999999999994c00000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000c9999999999999944c0000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000c99999999999999944c0000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000c999999999999999944c0000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000c9999999999999999944c0000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000c99999999999999999444c0000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000c999999999999999999444c0000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000c9999999999999999999444c0000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000c99999999999994449994444c0000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000c9999999999444444999444c00000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000c9999944444444444c999444c00000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000c444444444444444cc994444c00000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000cccc4444444cccc0c99444c000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000ccccccc0000c999444c000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000c99444c0000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000c9944c00000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000c9444c00000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000c944c000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000c44cccccc00000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000c44777777cc000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000c777777777c000000cc000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000c76666667777c0000caac00000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000c7666666666777c00caa9c00000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000c66666666666677c00ca9cccc000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000c666666666666aa9c0ca9caaac00000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000c666eeeeee666aaa9caaaaa99c00000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000c44eeeeeeee666aaaaaa9999aac0000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000c499e1eff1eee66aaaaa9999999c0000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000c49991ef1777fee66aaaa99999cc00000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000c949991fff999fffe6aaa99999999c0000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000c994499efff449fffe6aaa99999999c0000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000c99944999fffffffdfeeaa999994444c0000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000c999994499fffffff1feaaa9999499444cccc000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000c99999944991f999ffffeaaa99949999444777c00000000000000000000000000000000
0000000000000000000000000000000000000000000000000cccc000c9999aa444aaa1449effeaaaa9944999ee667777c0000000000000000000000000000000
00000000000000000000000000000000000000000000000ccffffccc99999aaa49aaac9aa9ee4aaa9994499ee66666677c000000000000000000000000000000
0000000000000000000000000000000000000000000000cffffffff999994aaa9aaa9caffe944aaa999449ee666666667c000000000000000000000000000000
000000000000000000000000000000000000000000000cfff7777fff99944aaa9aa99cfeee44aaa9999449ee6666666667c00000000000000000000000000000
000000000000000000000000000000000000000000000cff777777ff9944aaaaaa99cceeee44aaa9999449e66666666667c00000000000000000000000000000
00000000000000000000000000000000000000000000cff77777777ff444aaaaa9ffccefe444faa999944e666ee6666666c00000000000000000000000000000
00000000000000000000000000000000000000000000cff77777777ff44aaaaaaa9ffffff444fffe99444e666eee666666c00000000000000000000000000000
00000000000000000000000000000000000000000000cff77777777ff4a66aaaa91fffff44f4ffeee6664c6666ee664446c00000000000000000000000000000
00000000000000000000000000000000000000000000cff77777777ff66769aaa19fb3ff4fefffee66666c66666664444c000000000000000000000000000000
000000000000000000000000000000000000000000000cff777777ff477769aaa1ff777fffefffee66666cc6666644444c000000000000000000000000000000
000000000000000000000000000000000000000000000cfff7777fff4a769aaaaaf1f1ffffeffeee66666c0c66664444c0000000000000000000000000000000
0000000000000000000000000000000000000000000000cffffffff44aa9aaaaa9fffffffeeffee666666c00c4444444c0000000000000000000000000000000
00000000000000000000000000000000000000000000000ccffff9449aaaaaaaa9effffffeeffee66666c00c44444444c0000000000000000000000000000000
0000000000000000000000000000000000000000000000000c9994449aaaaaaaa99effffeeefeec66666c00c44444444c0000000000000000000000000000000
0000000000000000000000000000000000000000000000000c9994419aaaaaaa999fffffeeffeec66666c0c994494444c0000000000000000000000000000000
0000000000000000000000000000000000000000000000000c9994319aaaaaaa999efffeeeffec666666c0c944494444c0000000000000000000000000000000
0000000000000000000000000000000000000000000000000c9944339aaaaaaa99ffffeeeffeec666666cc9944c94444c0000000000000000000000000000000
0000000000000000000000000000000000000000000000000c9943339aaaaaa99efffeeefffec6666666c99444c9444c00000000000000000000000000000000
000000000000000000000000000000000000000000000000c999433aaaaa9aa99eeffee1ffeea6666666c9944cc9444c00000000000000000000000000000000
000000000000000000000000000000000000000000000000c99443aaaaa9aa9999eeee11ffeaa6666d66a9444c99444c00000000000000000000000000000000
000000000000000000000000000000000000000000000000c9944aaaaa9999999a9ee911feeaa66d6c66a944cc94444c00000000000000000000000000000000
000000000000000000000000000000000000000000000000c9944aaaa99999999aa9991ffeecaa66c0caa444cc94444c00000000000000000000000000000000
000000000000000000000000000000000000000000000000c944c9a999199999aaaa991ffeecaaacccaaa44c0c94444c00000000000000000000000000000000
000000000000000000000000000000000000000000000000c44c0c99919999999aa9991feeeccaaaaaa9444cc994444c00000000000000000000000000000000
00000000000000000000000000000000000000000000cccc4cc00c333399aa99999999feeeeccaaaaa99444cc994444c00000000000000000000000000000000
0000000000000000000000000000000000000000000c3333c0000c33339aaa99999999feeeaaaaaaaa9444c0c94444c000000000000000000000000000000000
000000000000000000000000000000000000000000c333333c000c3333aaa99999999feeaaaaaaaaa99444c0c94444c000000000000000000000000000000000
00000000000000000000000000000000000000000c3333333c000c33339aa99919991feaaa99999aa94444c0c94444c000000000000000000000000000000000
00000000000000000000000000000000000000000c3333333c000c33339999911111feeaa99999999a444c00c94444c000000000000000000000000000000000
00000000000000000000000000000000000c00000c33333333c0c333339999111111feaa9999999999444c0c994444c000000000000000000000000000000000
0000000000000000000000000000000000c3c000c3333333333c333333399311111feeaa99aa99999944c00c994444c000000000000000000000000000000000
0000000000000000000000000000000000c3c000c3333333333333333333311111ffeeaa9aaaa9999944000c94444c0000000000000000000000000000000000
0000000000000000000000000000000000c3c000c3331133333333333333311111feecaa9aaaaa99994c00c994444c0000000000000000000000000000000000
0000000000000000000000000000000000c33ccc33311113333333333333111113eeecaa9aaaaa99997c00c994444c0000000000000000000000000000000000
00000000000000000000000000000000000c333333ccc111333333333333111113eeccaa9aaaaa99996c0c9944444c0000000000000000000000000000000000
00000000000000000000000000000000000c33333c000c113333333333311111311ecccaa9aaaa99966c0c994444c00000000000000000000000000000000000
00000000000000000000000000000000000c33331c0000c11333333333111113311cc77aaa99a99966c0c9994444c00000000000000000000000000000000000
000000000000000000000000000000000000c311c00000c11133333331111113111c7777aaaa9996cc0cc494444c000000000000000000000000000000000000
0000000000000000000000000000000000000ccc0000000c111133331111113311c777777aa9a666c0c77444444c000000000000000000000000000000000000
000000000000000000000000000000000000000000000000c11111111111133311c677776aa9666c0c7777444466c00000000000000000000000000000000000
000000000000000000000000000000000000000000000000c1111111111133311cc666666a99666cc77777776666c00000000000000000000000000000000000
0000000000000000000000000000000000000000000000000c111111111c33311cc666666a9666c0c77777766666c00000000000000000000000000000000000
0000000000000000000000000000000000000000000000000c11111111cc33311cc666666a966c000c677766666c000000000000000000000000000000000000
000000000000000000000000000000000000000000000000c33111111cc33311c00c66666a66c000c776666666c0000000000000000000000000000000000000
0000000000000000000000000000000000000000000000cc33333111c0c33311c000cc6669cc000c7777666666c0000000000000000000000000000000000000
00000000000000000000000000000000000000000000cc333333111c0c333311c00000cccc0000c7777776666c00000000000000000000000000000000000000
000000000000000000000000000000000000000000ccaa33333111c00c33311c0000000000000c77777776666c00000000000000000000000000000000000000
00000000000000000000000000000000000000000caaaaa333111c00c333311c0000000000000c77777766666c00000000000000000000000000000000000000
000000000000000000000000000000000000000ccaaaaaa91111c00c3333311c000000000000c777777666666c00000000000000000000000000000000000000
00000000000000000000000000000000000000caaaaaaa99911c000c333311c0000000000000c67776666666c000000000000000000000000000000000000000
000000000000000000000000000000000000ccaaaaaaa99991c000c3333311c0000000000000c66666666666c000000000000000000000000000000000000000
00000000000000000000000000000000ccccaaaaaaa999999c000c33333311c00000000000000c666666666c0000000000000000000000000000000000000000
0000000000000000000000000000000caaaaaaaaaa99999cc0000c3333311c000000000000000c66666666c00000000000000000000000000000000000000000
000000000000000000000000000000c9aaaaaaaaa99999c00000c33333311c0000000000000000cc6666cc000000000000000000000000000000000000000000
00000000000000000000000000000c999a9aaaa999999c000000caaaa3111c000000000000000000cccc00000000000000000000000000000000000000000000
00000000000000000000000000000c9999a9aa999999c000000caaaaa911c0000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000c99999a99999999c0000000caaaaa991c0000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000c99999a9999999c0000000caaaaa9999c0000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000c99999a999999c00000000caaaaa999c00000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000c99999a99999c00000000caaaaa9999c00000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000c99999a9999c000000000caaaaa9999c00000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000c99999a9999c00000000caaaaaa999c000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000c99999a999c000000000caaaaa9999c000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000c99999a999c00000000caaaaaa9999c000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000c999a999c00000000caaaaaaa999c0000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000c999a999c0000000caaaa9aa9999c0000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000c9a999c00000000ca9aaa999999c0000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000c999c000000000c9999aa9999c00000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000ccc000000000c999999aa999c00000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000c9999999a999c00000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000c9999999a999c00000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000c99999999a99c00000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000c99999999a99c00000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000c99999999a99c00000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000c99999999a99c00000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000c99999999a99c00000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000c99999999a9c000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000c9999999a9c000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000c9999999a9c000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000c9999999c0000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000c9999a9c0000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000c99a9c00000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000cccc000000000000000000000000000000000000000000000000000000000000000000000000000
__label__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000006660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000066666000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000066666000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000066666000000000000000000000000000000000000000000000009999994000000000000000000000000000000000000000000000000000000000
00000000000006660000000000000000000000000000000000000000000000999999999940000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000009999999999994000000000000000000000000000000000aaa000000000000000000
00000000000000000000000000000000000000000000000000000000000099999999999994000000000000000000000000000000000aaa000000000000000000
00000000000000000000000000000000000000000000000000000000000999999999999994400000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000009999999999999994400000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000007000000000099999999999999994400000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000077700000000999999999999999994400000000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000070000000099999999999999999444000000000000000000000000000aaa00000000000000000000000
000000000000000000000000000000000000000000000000000000999999999999999999444000000000000000000000000000aaa00000000000000000000000
00000000000000000000000000000000000000000000000000000999999999999999999944400008880000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000009999999999999444999444400888888800000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000009999999999444444999444088888888800000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000099999444444444440999444088888888880000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000044444444444444400994444088888888880000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000004444444000090994440888888888880000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000990000000999909994440888888888800000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000999999999999909944408888888888800000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000009999999999999909944099990008888800000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000099999999999999909444088999000888880000000000000000000000000000000000000000000
00000000000070000000000000000000000000000000009999999999999999999909440888889888000800000000000000000000000000000000000000000000
00000000000000000000000000000000000000000999999999999999999999999904400000088888800000000000000000000000000000000000000000000000
00000000000000000000000000000000000000099999999999999999999999999904477777700888880000000000000000000000000000000066600000000000
00000000000000000000000000000000000009999999999999999999999999999990777777777088880000000000000000000000000000000666660000000000
000000000000000000000000000000000000999999999999999999999999999999076666667777088800aa000000000000000000000000000666660000000000
000000000000000000000000000000009aaaaaa99999999999999999999999999076666666667770800aa9000000000000000000000000000666660070000000
0000000000000000000000000000009aa999aaaaaa99999999999999999999990666666666666770000a90000000000000000000000000000066600000000000
00000000000000000000000000000aa988aaaaaaaaaaaaaa99999999999999990666666666666aa9000a90aaa000000000000000000000000000000000000000
00000000888800000000000008888998888aaaaaaaaaaaaaaa999999999999990666eeeeee666aaa90aaaaa99000000000000000000000000000000000000000
0000000888888000000888888888889988aaaaaaaaaaaaaaaaa9989999999999044eeeeeeee666aaaaaa9999aa00000000000070000000000000000000000000
0000000888888007777888888888889aaaaaaaaaaaaaaaaaaaaa998999999990499e1eff1eee66aaaaa999999900000000000777000000000000000000000000
000000088888807777778888888888aaaaaaaaaaaaaaaaaaaaaa9998999999049991ef1777fee66aaaa999990000000000000070000000000000000000000000
000000088888877777777888888888aa8aaaaaaaaaaaaaaaaaaaa999999990949991fff999fffe6aaa9999999900000000000000000000000000000000000000
00000000888807777777788888888aaa89888aaaaaaaaaaaaaaaa99999990994499efff449fffe6aaa999999990000000000000000a000000000000000000000
0000000000000777777778888aaaaaa99888889aaaaaaaaaaaaaa999999099944999fffffffdfeeaa999994444000000000000000aaa00000000000000000000
0000000000000777777778777aa999888888889aa8888aaaaaaaa999990999994499fffffff1feaaa9999499444000000000000000a000000000000000000000
000000000000a77777777777777aaaa888888899888888aaaaaaa9999099999944991f999ffffeaaa99949999444777000000000000000000000000000000000
00000000000aa777777777777777777aa88889988888888aa0000a9909999aa444aaa1449effeaaaa9944999ee66777700000000000000000000000000000000
0000000000aaa7777777777777777777a88aaa98888888800ffff00099999aaa49aaa09aa9ee4aaa9994499ee666aa6770000000006660000000000000000000
000000000aaaa77777777777777777777a8aaaa88888880ffffffff999994aaa9aaa90affe944aaa999449ee6666666670000000066666000000000000000000
000000000aaaaaa777777777777788877aaaaaa8888880fff7777fff99944aaa9aa990feee44aaa9999449ee6666666667000000066666000000000000000000
000000000aaaaa7777777777777888887aaaaaaa888880ff777777ff9944aaaaaa9900eeee44aaa9999449e66666666667000000066666000000006660000000
600000000aaaaaa777777777777888888aaaaaaaa8880ff77777777ff444aaaaa9ff00efe444faa999944e666ee6666666000000006660000000066666000000
660000000aaaa77777777777777888888aaaaaaaaaaa0ff77777777ff44aaaaaaa9ffffff444fffe99444e666eee666666000000000000000000066666000000
600000000aaa777777777777777888888aaaaaaaaaaa0ff77777777ff4a66aaaa91fffff44f4ffeee666406666ee664446000000000000000000066666000000
0000000000a7777777777777777888888a8888aaaaaa0ff77777777ff66769aaa19fb3ff4fefffee666660666666644440000000000000000000006660000000
000000000aa7777777777777777888888888888aaaaaa0ff777777ff477769aaa1ff777fffefffee666660066666444440000000000000000000000000000000
000000000aa7777777777777777a88888888888aaaaaa0fff7777fff4a769aaaaaf1f1ffffeffeee666660006666444400000000000000000000000000000000
000000000a77777777777777777a77788888888aaaaaaa0ffffffff44aa9aaaaa9fffffffeeffee6666660000444444400000000000000000000000000000000
000000000a77777777777777777a77888788888aaaaaaaa00ffff9449aaaaaaaa9effffffeeffee6666600004444444400000000000000000000000000000000
000000000aa7777777777777777a7888a78888aaaaaaaaaaa09994449aaaaaaaa99effffeeefee06666600004444444400000000000000000000000000000000
000000000aaa777777777777777aa88aaaaaaaa99aaaaaaaa09994419aaaaaaa999fffffeeffee06666600099449444400000000000000000000000000000000
0000000000a777777aa77777777aa888aa9999999aaaaaaaa09994319aaaaaaa999efffeeeffe066666600094449444400000000000000000000000000000000
000000000007777aaa77777777aaa888a99999999aaaaaaaa09944339aaaaaaa99ffffeeeffee066666600994409444400000000000000000000000000000000
0000000000077777777777777aaaa888a9999999aaaaaaaaa09943339aaaaaa99efffeeefffe0666666609944409444000000000000000000000000000000000
00000000000777777777aaaaaaaaa888a9999999aaaaaaaa0999433aaaaa9aa99eeffee1ffeea666666609944009444000000060000000000000000000000000
0000000000077777777aaaaaaaaa888a999999aaaaaaaaaa099443aaaaa9aa9999eeee11ffeaa6666d66a9444099444000000000000000000000000000000000
0000000000007777777aaaaaaaa888a9999999aaaaaaaa0009944aaaaa9999999a9ee911feeaa66d6066a9440094444000000000000000000000000000000000
700000000000a7777aaaaaaaaaaaaa99999999aaa000000009944aaaa99999999aa9991ffee0aa66000aa4440094444000000000000000000000000000000000
70000000000000aaaaaaaaaaaaaa8999999999aa00000000094409a999199999aaaa991ffee0aaa000aaa4400094444000000000000000000000000000000000
70000000000000000aaaaaaaa888889999999a000000000004400099919999999aa9991feee00aaaaaa944400994444000000000000000000000000000000000
000000000000000000aaaaaa888888999999900000000000400000333399aa99999999feeee00aaaaa9944400994444000000000000000000000000000000000
00000000000000000000008888880000999000000000333300000033339aaa99999999feeeaaaaaaaa9444000944440000000000000000000000000000000000
0000000000000000000000088880000000000000000333333000003333aaa99999999feeaaaaaaaaa99444000944440000000000000000000000000000000000
00000000000000000000000000000000000000000033333330000033339aa99919991feaaa99999aa94444070944440000000000000000000000000000000000
00000000000000000000000000000000000000000033333330000033339999911111feeaa99999999a4440770944440000000000000000000000000000000000
00000000000000000000000000000000000000000033333333000333339999111111feaa99999999994440009944440000000000000000000000000000000000
0000000000000000000000000000000000030000033333333330333333399311111feeaa99aa9999994400009944440000000000000000000000000000000000
000000000000000000000000000000000003000003333333333333333333311111ffeeaa9aaaa999994400009444400000000000000000000000000000000000
000000000000000000000000000000000003000003331133333333333333311111fee0aa9aaaaa99994000099444400000000000000000000000000000000000
000000000000000000000000000000000003300033311113333333333333111113eee0aa9aaaaa99997000099444400000000000000000000000000000000000
000000000000000000000000000000000000333333000111333333333333111113ee00aa9aaaaa99996000994444400000000000000000000000000000000000
0000000000000000000000000000000000003333300000113333333333311111311e000aa9aaaa99966000994444000000000000000000000000000000000000
00000000000000000000000000000000000033331000000113333333331111133110077aaa99a999660009994444000000000000000000000600000000000000
000000000000000000000000000000000000031100000001113333333111111311107777aaaa9996000004944440000000000000000000000000000000000000
0000000000000000000000000000000000000000000000001111333311111133110777777aa9a666000774444440000000000000000000000000000000000000
2222200000000000000000000000000000000000000000000111111111111333110677776aa96660007777444466000000011111111100000000000000000000
2222222220000000000000000000000000000000000000000111111111113331100666666a996660077777776666000111111111111111110000000000000000
2222222222220000000000000000000000000000000000006011111111103331100666666a966600077777766666011111111110000000001100000000000000
1112222222222200000000000000000000000000000000000011111111003331100666666a966000006777666660111111aaaa00000000000000000000000000
1111111222222222000000000000000000000000000000000331111110033311000066666a660000077666666601111110aaaa00000000000000000000111122
11111111112222222000000000000000000000000000000033333111000333110000006669000000777766666601111000000000000000000000000011122222
11111111111122222220000000000000000000000000003333331110103333110000000000000007777776666011110000000000000000000000000002222222
11111111111111222222000000000000000000000000aa33333111000033311000aaaa0000000077777776666011000000000000000000000000000222222222
111111111111111222222000000000000000000000aaaaa3331110000333311000aaaa1111000077777766666022222222222200000000000000022222222222
01111111111111111222221100000000000000000aaaaaa911110000333331101111111111110777777666666022222222222222220000000002222222222222
000001111111111111222221111000000000000aaaaaaa9991100000333311011a11100000000677766666660222222222222222222220000222222222222222
00000000111111111112222211111000000000aaaaaaa9999100000333331101aaa0000000000666666666660221111111111111222222222222222222222221
000000000011111111112222222222200000aaaaaaa9999990111033333311010a00000000000066666666601111111111111111111122222222222222222111
00000000000011111111122222111110aaaaaaaaaa99999001111033333110100000000000022066666666011111111111111111111122222222222222211111
00000000000001111111112222111109aaaaaaaaa999990111110333333110000000000000222200666600111111111111111111111222222222222221111111
000000000000000111111112222000999a9aaaa99999901100000aaaa31110100000000022222221000011111111111111111111122222222222222111111111
0222222222222222111111112222aaaa99a9aa99999900000000aaaaa91101110022222222222221111111111111111111111111222222222222211111111111
2222222222222222222221112222aaaa99a99999999000000000aaaaa99100222222222222222222222111111111111110000002222222222222111111111111
2222222222222222222222222111099999a9999999000000000aaaaa999902222222222222222222222222111111100000000222222222222211111111111111
2222222222222222222222222222099999a9999990000000000aaaaa999022222222111111111111122222222100000000002222222222222111111111111111
2222222222222222222222222222099999a999990220000000aaaaa99990222211111111111111111111122222200000aaa22222222222211111111111111111
1111111111111112222222222222099999a999901112000000aaaaa9999021111111111111111111111111112222200000222222222222111111111111111111
1111111111111111111122222222099999a99990111100000aaaaaa9990111111111111111111111111111111112220002222222222221111111111111111111
1111111111111111111111112222099999a99900111120000aaaaa99990111111111111111111111111111111111122222222222222111111111111111111111
1111111111111111111111111112099999a9990001111200aaaaaa99990111111111111111111111111111111111111222222222221111111111111111111111
111111111111111111111111111110999a9aaa220001110aaaaaaa99901111111111111111111111111111111111112222222222211111111111111111111111
111111111111111111111111111110999aaaaaa2200010aaaa9aa999901111111111111111111111111111111111122222222222111111111111111111111111
11111111111111111111111111111109a99aaa22220020a9aaa99999901111111111111100000000000001111111222222222221111111111111111111111111
11111111111111111111111111111110999022222222209999aa9999011111111111000000000000000000000112222222222211111111111111111111111111
111111111111111111111111111111110001122222220999999aa999011111111000000000000000000000000022222222222111111111111111111111111110
1111111111111111111111111111111111111112222209999999a999011111000000000000000000000000000022222222221111111111111111111111111100
1111111111111111111111111111111111111111222209999999a999011100000000000000000000000000000222222222211111111111111111111111110000
11111111111111111111111111111111111111111222099999999a99022222200000000000000000000000002222222222111111111111111111111111100000
00000000000001111111111111111111111111111112099999999a99022222222222000000000000000000022222222221111111111111111111111111000000
00000000000000000011111111111111111111111222099999999a99022222222222222200000000000000022222222211111111111111111111111100000000
00000000000000000000001111111111111111122222099999999a99022222222222222222000000000000222222222211111111111111111111111000000000
00000000000000000000000001111111111122222222099999999a99011111112222222222222000000002222222222111111111111111111111110000000000
0000000000aa00000000000000011111112222222222099999999a90111111111111122222222220000002222222221111111111111111111111100000000000
000000000aaaa0000000000000000011222222222211109999999a90111111111111111112222222200022222222211111111111111111111111000000000000
000000000aaaa0000000000000000002222222221111109999999a90111111111111111111122222220222222222211111111111111111111110000000000000
0000000000aa0000000000000aaaaa22222221111111110999999901111111111111111111111122222222222222111111111111111111111100000000000000
0000000000000000000000000aaaaaaaaa211111111111109999a901111111111111111111111111222222222221111111111111111111111000000000000000
000000000000000000000000000222222111111111111111099a9011111111111111111111111111112222222221111111111111111111110000000000000000
00000000000000000000000002222222111111111111111110000111111111111111111111111111122222222211111111111111111111100000000000000000
00000000000000000000000022222211111111111111111111111111111111111111111111111111122222222111111111111111111111000000000000000000
00000000000000000000000222222111111111111111111111111111111111111111111111111111222222222111111111111111111110000000000000000000
00000000000000000000002222221111111111111111111111111100000000000001111111111111222222221111111111111111111110000000000000000000
00000000000000000000022222111111111111111111111110000000000000000000000011111112222222221111111111111111111100000000000000000000

__sfx__
3e2418002646026431264112641126411264112641126411244602443124411244112346023431234112341123411234112341123411214602143121411214111f4001f4001f4001f4001f4001f4001f4001f400
b624000005175091050c1750c105131750000515175000051817500005000050000505175091050c1750c10513175000051517500005181750000500005000050b100000000e1000000010100141001310018100
3e2418001f4601f4311f4111f4111f4111f4111f4111f4111e4601e4311e4111e4111c4601c4311c4111c4111c4111c4111c4111c4111a4601a4311a4111a4110040000400004000040000400004000040000400
b724000004175000050b17500005131751410517175181051a17500005000050000504175000050b17500005131751410517175181051a1750000500005000050000500005000050000500005000050000500005
3e2418001f4601f4311f4111f4111f4111f4111f4111f4111e4601e4311e4111e4111c4601c4311c4111c4111c4111c4111a4601a4311c4601c4311c4111c4110040000400004000040000400004000040000400
3e2400001d4601d4311d4111d41128460284312841128411264602643126411264112446024431244112441124411244112441124411264602643126411264111f4601f4311f4111f41126460264312641126411
b6240000051750000509175000050e17514105111751810515175000050000500005051750000509175000050e1751410511175181051517500005000050000507175000050b1750000510175141051317518105
3f2400002446024431244112441123460234312341123411234112341123411234111f4601f4311f4111f41121460214312141121411284602843128411284112646026431264112641124460244312441124411
b72400001717500005000050000507175000050b17500005101751410513175181051717500005000050000505175000050c17500005111751410515175181051817500005000050000505175000050c17500000
3e2400002441024411244112441126460264312641126411234602343123411234112341123411234112341123411234112341123411234112341123411234112341123411234112341123411234112341123415
b6240000111751410515175181051817500005000050000504175000050b175000050e17514105131751810517175000051a175000051c175000050b105000051f17514105171051810523175000050000500005
__music__
01 00014344
00 02034344
00 00014344
00 04034344
00 05064344
00 07084344
02 090a4344
