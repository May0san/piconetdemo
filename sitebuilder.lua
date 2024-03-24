
p = {
	title = "sitebuilder (wip1)",
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
				text,
				field
			}
		}
	},
	selection_gui = create_gui({x=0,y=28 + 15,-- update but don't draw
		width=300,height=200-28,
		fgcol = 0x090d}),
	page_mockup = create_gui({x=0,y=0,-- draw but don't update
		width=300,height=200-28,
		fgcol = 0x090d}),
	selected_gui,
	init = function(self,explorer)
		self:create_element({gui=self.page_mockup, x=0, y=0, w=explorer.current_width, h=explorer.current_height, name="untitled page", clr=0})

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
			image_str = pod(tbl.image),
			gui = tbl.gui or create_gui(),
			function_text = "",
			action_text = "",
			draw = tbl.draw or function()end,
			name = tbl.name or "untitled"..num,
			num = num,
			delete = function(self, page)
				if self.num != 1 then
					self.gui.detach()
					page.elements[self.num] = nil
				end
			end,
			update = function(self)
				if self.num!=1 then
					self.x = min(max(self.x,0),page.g.width-self.w)
					self.y = min(max(self.y,0),page.g.height-self.h)
				end
				self.gui.x = self.x
				self.gui.y = self.y + 15
				self.selection_btn.x = self.x
				self.selection_btn.y = self.y
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
		rectfill(0, 0, explorer.current_width, 15, 6)
		print("selected:", explorer.current_width-70, 0, 0)
		print(self.elements[self.selected_element].name, explorer.current_width-70, 8, 0)
		
		camera(0,-15)
		for i in all(self.elements) do
			i:draw()
		end
		camera()
		self.page_mockup:draw_all()
		camera(0,-15)
		self:draw_selection_indicator()
		camera()
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
		end
	end,
	data_from_element = function(self,element)
		return {w = element.w, h = element.h, label = element.gui.label, clr=element.clr, type = element.type, func = self.as_exportable_string(element.function_text), action = self.as_exportable_string(element.action_text), imgdata = element.image_str}
	end,
	parse_clipboard = function(self)
		local c = get_clipboard()
		local s = split(c,"(")
		if (#c > 4 and sub(s,#s-5,#s)!= "unpod") or (sub(c,1,1)=="{" and sub(c,#c,#c)=="}") then
			
			local p = unpod(split(c,"\"")[2])
			if sub(c,1,1)=="{" and sub(c,#c,#c)=="}" then
				p=unpod(c)
			end
			
			if type(p) == "userdata" then
				return {type="image", data=p}
			elseif type(p) == "table" and p.type then
				return p
			end
		else
			return {type="string", data=c}
		end
		return {type="unknown",data=c}
	end,
	add_to_clipboard = function(self,element)
		set_clipboard(pod(self:data_from_element(element)))
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
				f.items.button = f.pulldown:attach_pulldown_item({
					label = "save .pod",
					action = function()
						local pod = pod(self.elements)
						store("/downloads/savedsite.pod",pod)
					end
				})
				f.items.button = f.pulldown:attach_pulldown_item({
					label = "load .pod",
					action = function()
						--open file explorer
					end
				})
				f.items.button = f.pulldown:attach_pulldown_item({
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
	convert_to_code = function(self)
		local as_exportable_string = self.as_exportable_string
		local string =
			"p = {\n"..
			"	title=\""..as_exportable_string(self.elements[1].name).." \",\n"..
			"	g=create_gui({\n"..
			"		x=0,y=0,\n"..
			"		width="..self.elements[1].gui.width..",height="..self.elements[1].gui.width..",\n"..
			"		fgcol = 0x090d\n"..
			"	}),\n"..
			"	init = function(self,explorer)\n"
		for i in all(self.elements) do
			if i and i != self.elements[1] then	
				if i.gui.type == "button" then
					string = string..
						"		self."..as_exportable_string(i.name).." = self.g:"..
						"attach_button({\n"..
						"			x="..i.x..", y="..i.y..", w="..i.w..", h="..i.h..",\n"..
						"			label=\""..as_exportable_string(i.gui.label).." \",\n"..
						"			click=function()\n"..
						"				"..i.function_text.."\n"..
						"			end\n"..
						"		})\n"
				--else if i.gui.type == "text" then
					
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
				if i.gui.type == "text" then
					string = string..
						"		print(\""..as_exportable_string(i.gui.label).." \","..i.x..","..i.y..","..i.clr..")\n"
				end
			end
		end
		string = string..
			"		"..self.custom_code.draw.."\n"..
			"		g:draw_all()\n"..
			"	end,\n"..
			"	update = function(self,explorer)\n"..
			"		"..self.custom_code.update.."\n"..
			"	end\n"..
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
