
p = {
	title = "sitebuilder (wip)",
	g = create_gui({x=0,y=0,
		width=300,height=200-28+15,
		fgcol = 0x090d}),
	elements = {},
	bgclr = 0,
	custom_code = {
		init = "",
		update = "",
		draw = ""
	},
	toolbar = {
		gui = create_gui({x=0,y=0,
			width=300,height=15,
			fgcol = 0x090d}),
		edit = {
			features,
			functions
		},
		code = {
			init,
			update,
			draw
		},
		file = {
			items = {
				save,
				load,
				export
			}
		},
		new = {
			button,
			pulldown,
			items = {
				button,
				gif,
				custom_gui,
				rectangle,
				circle,
				image,
				text
			}
		}
	},
	selection_gui = create_gui({x=0,y=28 + 15,-- update but don't draw
		width=300,height=200-28-15,
		fgcol = 0x090d}),
	page_mockup = create_gui({x=0,y=0,-- draw but don't update
		width=300,height=200-28-15,
		fgcol = 0x090d}),
	selected_gui,
	init = function(self,explorer)
		self:create_element({gui=self.page_mockup, x=0, y=0, w=self.page_mockup.width, h=self.page_mockup.height, name="untitled page", clr=0})

		self:create_toolbar_menu(explorer)
		
		self.selected_element = 1
	end,
	
	--create_element({gui,x,y,w,h,draw,name,type,clr})
	create_element = function(self, tbl)
		local num = count(self.elements) + 1
		local page = self
		local e = {
			type = tbl.type or "unknown",
			x = tbl.x or 0,
			y = tbl.y or 0,
			w = tbl.w or 0,
			h = tbl.h or 0,
			clr = tbl.clr or 7,
			image = tbl.image,
			image_str = tbl.image_str,
			gui = tbl.gui or create_gui(),
			function_text = "",
			action_text = "",
			speed=tbl.speed,
			draw = tbl.draw or function()end,
			name = tbl.name or "untitled"..num,
			num = num,
			frames = tbl.frames or 1,
			delete = function(self, page)
				if self.num != 1 then
					self.gui.detach()
					page.elements[self.num] = nil
				end
			end,
			update = function(self)
				if self.num!=1 then
					self.x = min(max(self.x,0),page.selection_gui.width-self.w)
					self.y = min(max(self.y,0),page.selection_gui.height-self.h)
				end
				self.gui.x = self.x
				if self.num == 1 then
					self.gui.y = self.y
				else
					self.gui.y = self.y + 15
				end
				
				self.selection_btn.x = self.x + page.g.x
				self.selection_btn.y = self.y + page.g.y
				self.gui.width = self.w
				self.gui.height = self.h
				self.selection_btn.width = self.w
				self.selection_btn.height = self.h
			end
		}
		e.selection_btn = self.selection_gui:attach({x=e.x,y=e.y,width=e.w,height=e.h,label="",
			event = function(self, msg)
				if msg.event == "drag" and page.selected_element == num and num != 1 then
					--assert(false)
					local mx, my = mouse()
					mx = max(min(mx, explorer.current_width),0) - page.g.x
					my = max(min(my - (15 + 13 + 15), explorer.current_height),0) - page.g.y
					--assert(false)
					page.elements[page.selected_element].x = mx - (self.width/2)
					page.elements[page.selected_element].y = my - (self.height/2)
				end
				if msg.event == "release" and not self.editing then
					page.selected_element = num
				end
				if msg.event == "hover" then
					if num > 1 and page.selected_element == num then
						window{cursor = "grab"}
					else
						window{cursor = "point"}
					end
				end
			end
		})
		
		add(self.elements, e)
		return e
	end,
	get_gui = function(self,explorer)
		return self.g
	end,
	draw = function(self, explorer)
		cls(self.elements[1].clr)
				
		camera(0,-15)
		for i in all(self.elements) do
			i:draw()
		end
		camera()
		self.page_mockup:draw_all()
		camera(0,-15)
		self:draw_selection_indicator()
		camera()
		rectfill(0, 0, explorer.current_width, 15, 6)
		print("selected:", explorer.current_width-70, 0, 0)
		print(self.elements[self.selected_element].name, explorer.current_width-70, 8, 0)
		--camera(0,-15)
		
		--camera()
	end,
	draw_selection_indicator = function(self)
		local clr = 28
		if self.bgclr == 28 then
			clr = 8
		end
		local e = self.elements[self.selected_element]
		rect(e.x-1, e.y-1, e.x+e.w, e.y+e.h, 7)
		rect(e.x-2, e.y-2, e.x+e.w+1, e.y+e.h+1, clr)
		
	end,
	update = function(self, explorer)
		self.g.width = self.elements[1].w
		self.selection_gui.width = self.elements[1].w
		self.g.height = self.elements[1].h + 30
		self.selection_gui.height = self.elements[1].h
		if explorer.current_height-28 > self.g.height then
			self.g.x = 0
		end
		self.selection_gui:update_all()
		for i in all(self.elements) do
			i:update()
		end
		
		if key"ctrl" then
			if keyp"v" then
				self:element_from_data(self:parse_clipboard())
			elseif keyp"c" and self.selected_element!=1 then
				self:add_to_clipboard(self.elements[self.selected_element])
			end
		end
	end,
	element_from_data = function(self,data)
		if data.type == "string" then
			self:new_text((self.g.width/2)-25,(self.g.height/2)-6,50,25,data.data)
		elseif data.type=="button" then 
			local e = self:new_button(data.x or (self.g.width/2)-(data.w/2), data.y or (self.g.height/2)-(data.h/2),data.w,data.h,data.label,data.action)
		elseif data.type=="text" then 
			local e = self:new_text(data.x or (self.g.width/2)-(data.w/2),data.y or (self.g.height/2)-(data.h/2),data.w,data.h,data.label, data.clr)
		elseif data.type=="rect" then 
			local e = self:new_rect(data.x or (self.g.width/2)-(data.w/2),data.y or (self.g.height/2)-(data.h/2),data.w,data.h, data.clr, data.imgdata)
		elseif data.type=="circle" then 
			local e = self:new_circ(data.x or (self.g.width/2)-(data.w/2),data.y or (self.g.height/2)-(data.h/2),data.w,data.h, data.clr, data.imgdata)
		elseif data.type=="image" then
			local img = unpod(data.imgdata)
			local w = data.w or img:width()
			local h = data.h or img:height()
			local e = self:new_image(data.x or (self.g.width/2)-(w/2),data.y or (self.g.height/2)-(h/2),w,h, data.imgdata, data.clr or 0)
		elseif data.type=="gif" then
			local img = data.imgdata
			local w = data.w
			local h = data.h
			local e = self:new_gif(data.x or (self.g.width/2)-(w/2),data.y or (self.g.height/2)-(h/2),w,h, data.frames, img, data.speed, data.clr)
		end
	end,
	data_from_element = function(self,element)
		return {w = element.w, h = element.h, label = element.gui.label, clr=element.clr, type = element.type, func = self.as_exportable_string(element.function_text), action = self.as_exportable_string(element.action_text), imgdata = element.image_str, frames=element.frames, speed=element.speed}
	end,
	parse_clipboard = function(self)
		local c = get_clipboard()
		local s = split(c,"(")
		if (#c > 4 and sub(s[1],#s-7)== "unpod") or (sub(c,1,1)=="{" and sub(c,#c,#c)=="}") then
			local p = unpod(split(c,"\"")[4])
			if sub(c,1,1)=="{" and sub(c,#c,#c)=="}" then
				p=unpod(c)
			end
			
			if type(p) == "userdata" then
				return {type="image", imgdata=pod(p)}
			elseif type(p) == "table" and p.type then
				return p
			end
		else
			return {type="string", data=c}
		end
		return {type="unknown",data=c}
	end,
	add_to_clipboard = function(self,element)
		local data = self:data_from_element(element)
		set_clipboard(pod(data))
		notify(data.type.." added to clipboard.")
	end,
	create_toolbar_menu = function(self,explorer)
		local t = self.toolbar
		t.gui = create_gui({x=0, y=0, width=explorer.current_width, height = 15, fgcol = 0x90d})
		self.g:attach(t.gui)
		
		self:attach_file_menu(explorer,t)
		self:attach_new_menu(explorer,t)
		
	end,
	attach_file_menu = function(self,explorer,t)
		local f = t.file
		f.button = t.gui:attach_button({x=1,y=2,z=50,label="file",
			click=function()
				f.pulldown = self.g:attach_pulldown({x = -1, y = -2, width = 80})
				f.pulldown:attach_pulldown_item({label = "file",action = function()end})
--				f.items.save = f.pulldown:attach_pulldown_item({
--					label = "save .pod",
--					action = function()
--						
--					end
--				})
--				f.items.load = f.pulldown:attach_pulldown_item({
--					label = "load .pod",
--					action = function()
--						
--					end
--				})
				f.items.export = f.pulldown:attach_pulldown_item({
					label = "export .lua",
					action = function()
						local site = self:convert_to_code()
						store("/downloads/savedsite.lua",site)
					end
				})
			end
		})
	end,
	attach_new_menu = function(self,explorer,t)
		local n = t.new
		n.button = t.gui:attach_button({x=32,y=2,z=50,label="new",
			click=function()
				n.pulldown = self.g:attach_pulldown({x = 30, y = -2, width = 80})
				n.pulldown:attach_pulldown_item({label = "new",action = function()end})
				n.items.button = n.pulldown:attach_pulldown_item({
					label = "button",
					action = function()
						self:new_button((self.g.width/2)-25,(self.g.height/2)-7,50,13,"button")
					end
				})
				n.items.button = n.pulldown:attach_pulldown_item({
					label = "text",
					action = function()
						self:new_text((self.g.width/2) - 40,(self.g.height/2)-25,80,50,"select \"text\"\nunder \"edit\"")
					end
				})
				n.items.rectangle = n.pulldown:attach_pulldown_item({
					label = "rectangle",
					action = function()
						self:new_rect((self.g.width/2) - 20,(self.g.height/2)-20,40,40,8,true)
					end
				})
				n.items.circle = n.pulldown:attach_pulldown_item({
					label = "circle",
					action = function()
						self:new_circ((self.g.width/2) - 20,(self.g.height/2)-20,40,40,8,true)
					end
				})
--[[pod,pod_type="image"]]unpod("b64:bHo0AHUAAACIAAAA8B1weHUAQyAYGAT3VZ8gDccOhx23Dgd2DQcNpw4HJhMmDRcNlw4HFgMLAwEWPgoAsSMBNgcOlw4HJhFGCABBVi8QAQkAcwYINgwPDAwNAGIPDggmHBEMAEIaCBYxCgAiKgg1ACIGMQgAsJYHDpcOtw6X3vdV")
				n.items.image = n.pulldown:attach_pulldown_item({
					label = "image",
					action = function()
						self:new_image((self.g.width/2) - 12,(self.g.height/2)-12,24,24,"b64:bHo0AHUAAACIAAAA8B1weHUAQyAYGAT3VZ8gDccOhx23Dgd2DQcNpw4HJhMmDRcNlw4HFgMLAwEWPgoAsSMBNgcOlw4HJhFGCABBVi8QAQkAcwYINgwPDAwNAGIPDggmHBEMAEIaCBYxCgAiKgg1ACIGMQgAsJYHDpcOtw6X3vdV",0)
					end
				})
				n.items.image = n.pulldown:attach_pulldown_item({
					label = "gif",
					action = function()
						self:new_gif((self.g.width/2) - 8,(self.g.height/2)-8,16,16,12,"b64:bHo0ALcBAAAQAwAA-AJweHUAQyDAEATwtD8WsE7ALgIA-wCgTpAOLw8ekA4tLqAOHR4EAA3-BYAOLS5wLi0OkB4tHpAeLQ4NgC4dBQAOACgA-wVwHi0ecH6AfoBugA4fIA4cDoAOHAYAD7ducH5gBR4cDhyAHhYADwYAHBFwPACAcAUOHA0MDYAHAAUgAD8uDC4EAAYVDjYAAAcAgS4MDqAuDB6QHgAfCQQACAE_AP8EHpAFLgmgBR4JDrAeCQ4FoB4JCgUADzEOBZAyAP8EFQ0ACQqQFQ0JCrAFDQrABQ0ZsAQAByAKsCkA8gTgDxkZCqALDQkNoA0ZsA0OGgmgBQBGCgkPFAwAFAgLAHAOGgmwDRnQMQDxBtANCQ0JGoAdGRpgDQ4JKpANChgJoAUAWwoJKAmQCgACBQDyEw4JKsAdGRqgDg0JCgQJgA4ZCgQJYA0OCggECZANCQgECaAGAG4KGAQLCZAMAAMGAAExABHAPgCCoA4LCgQLCoAHALBgDQAJBAsKkA0psAMAWQkICwmgCQAiKbAiABLAMAD1BqANACmQDQApcA0AKaAN4A3gDQAZsAYAwOANACnQDQApsA3wpQ==",1,0)
					end
				})
			end
		})
	end,
	new_text = function(self,x,y,w,h,text,clr)
		self:create_element({
			type="text",
			gui=self.page_mockup:attach({
				type = "text", x = x, y = y, width = w, height = h, label = text
			}),
			x=x, y=y, w=w, h=h,
			draw=function(self)
				print(self.gui.label, self.x+2, self.y+3, self.clr)
			end
		})
	end,
	new_button = function(self,x,y,w,h,label,action_text)
		self:create_element({
			type="button",
			gui=self.page_mockup:attach_button({
				type = "button", x = x, y = y, width = w, height = h, label = label, click = function()end
			}),
			x=x, y=y, w=w, h=h, action_text = action_text or ""
		})
	end,
	new_rect = function(self,x,y,w,h,clr,filled)
		self:create_element({
			type="rect",
			gui=create_gui({x,y,w,h}),
			x=x, y=y, w=w, h=h, clr=clr, image_str=filled,
			draw=function(self)
				if self.image_str then
					rectfill(self.x, self.y, self.x+self.w, self.y+self.h, self.clr)
				else
					rect(self.x, self.y, self.x+self.w, self.y+self.h, self.clr)
				end
			end
		})
	end,
	new_circ = function(self,x,y,w,h,clr,filled)
		self:create_element({
			type="circle",
			gui=create_gui({x,y,w,h}),
			x=x, y=y, w=w, h=h, clr=clr, image_str=filled,
			draw=function(self)
				if self.image_str then
					ovalfill(self.x, self.y, self.x+self.w, self.y+self.h, self.clr)
				else
					oval(self.x, self.y, self.x+self.w, self.y+self.h, self.clr)
				end
			end
		})
	end,
	new_image = function(self,x,y,w,h,image,alpha)
		self:create_element({
			type="image",
			gui=create_gui({x,y,w,h}),
			x=x, y=y, w=w, h=h, clr=alpha, image_str=image, image=unpod(image),
			draw=function(self)
				palt(0,false)
				palt(self.alpha, true)
				sspr(self.image,0,0,self.image:width(),self.image:height(),self.x,self.y,self.w,self.h)
				palt()
			end
		})
	end,
	new_gif = function(self,x,y,w,h,frames,image,speed,alpha)
		self:create_element({
			type="gif",
			gui=create_gui({x,y,w,h}),
			x=x, y=y, w=w, h=h, frames=frames, speed=speed, clr=alpha, image_str=image, image=new_gif(image, frames),
			draw=function(self)
				self.image:draw(self.x,self.y,self.w,self.h,self.speed,self.clr)
			end
		})
	end,
	convert_to_code = function(self)
		local images = {}
		local as_exportable_string = self.as_exportable_string
		local string =
			"--[["..
			"	Thanks for using PicoNet Sitebuilder! I look forward\n"..
			"	to seeing your picosite! In order to make this available\n"..
			"	on PicoNet Explorer, you'll need to upload this lua file\n"..
			"	somewhere on the internet that you can get a link to it.\n"..
			"	Then, you'll want to go to the following thread:\n"..
			"	\n"..
			"		https://www.lexaloffle.com/bbs/?tid=140960\n"..
			"	\n"..
			"	and post your link based on the format provided there.\n"..
			"	it's  very possible that this format could change slightly\n"..
			"	and so I will not be listing that here just yet.\n"..
			"]]\n"..
			"\n"..
			"	p = {\n"..
			"	title=\""..as_exportable_string(self.elements[1].name).." \",\n"..
			"	g=create_gui({\n"..
			"		x=0,y=0,\n"..
			"		width="..self.elements[1].gui.width..",height="..self.elements[1].gui.width..",\n"..
			"		fgcol = 0x090d\n"..
			"	}),\n"..
			"	init = function(self,explorer)\n"..
			"		local page = self\n"
		for i in all(self.elements) do
			if i and i != self.elements[1] then	
				if i.type == "button" then
					string = string..
						"		self."..as_exportable_string(i.name).." = self.g:"..
						"attach_button({\n"..
						"			x="..i.x..", y="..i.y..", width="..i.w..", height="..i.h..",\n"..
						"			label=\""..as_exportable_string(i.gui.label).." \",\n"..
						"			click=function()\n"..
						"				"..i.function_text.."\n"..
						"			end\n"..
						"		})\n"
				--else if i.gui.type == "text" then
					
				elseif i.type == "gif" then
					string = string..
						"		self."..as_exportable_string(i.name).."btn = self.g:attach({\n"..
						"			x="..i.x..", y="..i.y..", width="..i.w..", height="..i.w..",\n"..
						"			event = function(self,msg)\n"..
						"				if(msg.event == \"release\") then\n"..
						"					set_clipboard(pod({type=\"gif\", w="..i.w..", h="..i.h..", frames="..i.frames..", speed="..i.speed..", clr="..i.clr..", imgdata=\""..i.image_str.."\"})\n"..
						"					notify(\"gif added to clipboard\")\n"..
						"				end\n"..
						"			end\n"..
						"		})\n"
				elseif i.type == "image" then
					string = string..
						"		self."..as_exportable_string(i.name).."btn = self.g:attach({\n"..
						"			x="..i.x..", y="..i.y..", width="..i.w..", height="..i.w..",\n"..
						"			event = function(self,msg)\n"..
						"				if(msg.event == \"release\") then\n"..
						"					set_clipboard(\""..i.image_str.."\")\n"..
						"					notify(\"image userdata added to clipboard\")\n"..
						"				end\n"..
						"			end\n"..
						"		})\n"
				end
			end
		end
		string = string..
			"	end,\n"..
			"	get_gui = function(self,explorer)\n"..
			"		return self.g\n"..
			"	end,\n"..
			"	draw = function(self,explorer)\n"..
			"		cls("..self.bgclr..")\n"
		for i in all(self.elements) do
			if i and i != self.elements[1] then
				if i.type == "rect" then
					string = string..
						"		rect"
					if i.image_str then
						string = string.."fill"
					end
					string = string..
						"("..i.x..","..i.y..","..i.x+i.w..","..i.y+i.h..","..i.clr..")\n"
					
				elseif i.type == "circle" then
					string = string..
						"		oval"
					if i.image_str then
						string = string.."fill"
					end
					string = string..
						"("..i.x..","..i.y..","..i.x+i.w..","..i.y+i.h..","..i.clr..")\n"
					
				elseif i.type == "image" then
					local name = i.name
					for j in all(self.elements) do
						if j.image_str==i.image_str then
							name = j.name
							add(images,{type="image",name=name,image=i.image_str})
							break
						end
					end
					local img = unpod(i.image_str)
					string = string..
						"		palt(0)\n"..
						"		palt("..i.clr..", true)\n"..
						"		sspr(self."..name..", 0, 0, "..img:width()..","..img:height()..","..i.x..","..i.y..","..i.w..","..i.h..")\n"..
						"		palt()\n"
				elseif i.type == "gif" then
					local name = i.name
					for j in all(self.elements) do
						if j.image_str==i.image_str then
							name = j.name
							add(images,{type="gif",name=name,image=i.image_str,frames=i.frames})
							break
						end
					end
					local img = unpod(i.image_str)
					string = string..
						"		"..name..":draw("..i.x..","..i.y..","..i.w..","..i.h..","..i.speed..","..i.clr..")\n"
				elseif i.type == "text" then
					string = string..
						"		print(\""..as_exportable_string(i.gui.label).." \","..i.x..","..i.y..","..i.clr..")\n"
				end
				
			end
		end
		string = string..
			"		"..self.custom_code.draw.."\n"..
			--"		self.g:draw_all()\n"..
			"	end,\n"..
			"	update = function(self,explorer)\n"..
			"		"..self.custom_code.update.."\n"..
			"	end"
		
		local did = {}
		for i in all(images) do
			if i.type == "image" and count(did,i.name)==0 then
				string = string..",\n"..
					"	"..as_exportable_string(i.name).." = unpod\""..i.image.."\")"
				add(did,i.name)
					
			elseif i.type == "gif" and count(did,i.name)==0 then
				string = string..",\n"..
					"	"..as_exportable_string(i.name).." = new_gif(\""..i.image.."\","..i.frames..")"
				add(did,i.name)
			end
		end
		string = string.."\n"..
			"}"
			
		return string
	end,
	as_exportable_string = function(string)
		local sr = ""
		for i =1,#string do
			local s = sub(string,i,i)
			if s == "\n" then
				sr = sr.."\\n"
			elseif s == sub(" \"",2) then
				sr = sr.."\\"..s
			else
				sr = sr..s
			end
		end
		
		return sr
	end
}
