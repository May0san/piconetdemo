window{
	width = 300,
	height = 200,
	title = "PicoNet Previewer"
}

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
		
		},
		code = {
			
		},
		file = {
		
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
	selection_gui = create_gui({x=0,y=28,-- update but don't draw
		width=300,height=200-28,
		fgcol = 0x090d}),
	page_mockup = create_gui({x=0,y=0,-- draw but don't update
		width=300,height=200-28,
		fgcol = 0x090d}),
	selected_gui,
	init = function(self,explorer)
		self:create_element(self.page_mockup, 0, 0, explorer.current_width, explorer.current_height, nil, "untitled page")

		local t = self.toolbar
		t.gui = create_gui({x=0, y=0, width=explorer.current_width, height = 15, fgcol = 0x90d})
		self.g:attach(t.gui)
		
		local f = t.file
		f.button = t.gui:attach_button({x=1,y=2,z=50,label="new",
			click=function()
				f.pulldown = self.g:attach_pulldown({x = -1, y = -2, width = 80})
				f.pulldown:attach_pulldown_item({label = "file",action = function()end})
				f.items.button = f.pulldown:attach_pulldown_item({
					label = "save .pod",
					action = function()
						local pod = pod(self.elements)
						store(pod,"/downloads/savedsite.pod")
					end
				})
				f.items.button = n.pulldown:attach_pulldown_item({
					label = "load .pod",
					action = function()
						--open file explorer
					end
				})
				f.items.button = n.pulldown:attach_pulldown_item({
					label = "export .lua site",
					action = function()
						local site = self:convert_to_code()
						store(site,"/downloads/savedsite.lua")
					end
				})
			end
		})
	
		local n = t.new
		n.button = t.gui:attach_button({x=1,y=2,z=50,label="new",
			click=function()
				n.pulldown = self.g:attach_pulldown({x = -1, y = -2, width = 80})
				n.pulldown:attach_pulldown_item({label = "new",action = function()end})
				n.items.button = n.pulldown:attach_pulldown_item({
					label = "button",
					action = function()
						self:create_element(
							self.page_mockup:attach_button({
								type = "button", x = (self.g.width/2)-25, y = (self.g.height/2)-7, width = 50, height = 13, label = "button", click = function()end
							}),
							(self.g.width/2)-25, (self.g.height/2)-7, 50, 13
						)
					end
				})
				n.items.button = n.pulldown:attach_pulldown_item({
					label = "text",
					action = function()
						self:create_element(
							self.page_mockup:attach({
								type = "text", x = (self.g.width/2) - 40, y = (self.g.height/2)-25, width = 80, height = 50, label = "select \"text\"\nunder \"edit\"", click = function()end
							}),
							(self.g.width/2) - 40, (self.g.height/2)-25, 80, 50,
							function(self)
								print(self.gui.label, self.x+2, self.y+3, self.clr)
							end
						)
					end
				})
			end
		})
		--
		
		self.selected_element = 1
	end,
	
	create_element = function(self, gui, x, y, w, h, draw_func, name)
		local num = count(self.elements) + 1
		local page = self
		local e = {
			x = x,
			y = y,
			w = w,
			h = h,
			clr = 7,
			gui = gui,
			function_text = "",
			draw = draw_func or function()end,
			selection_btn = self.selection_gui:attach({x=x,y=y,width=w,height=h,label="",
				event = function(self, msg)
					if msg.event == "drag" and page.selected_element == num and num != 1 then
						--assert(false)
						local mx, my = mouse()
						mx = max(min(mx, explorer.current_width),0)
						my = max(min(my - (15 + 13), explorer.current_height),0)
						--assert(false)
						page.elements[page.selected_element].x = mx - (self.width/2)
						page.elements[page.selected_element].y = my - (self.height/2)
					end
					if msg.event == "release" then
						page.selected_element = num
					end
					if msg.event == "hover" then
						if num > 1 and page.selected_element == num then
							window{cursor = "grab"}
						else
							window{cursor = nil}
						end
					end
				end
			}),
			name = name or "untitled"..num,
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
				self.gui.y = self.y --+ 15
				self.selection_btn.x = self.x
				self.selection_btn.y = self.y -- (15 + 13)
				self.gui.width = self.w
				self.gui.height = self.h
				self.selection_btn.width = self.w
				self.selection_btn.height = self.h
			end
		}
		add(self.elements, e)
	end,
	get_gui = function(self,explorer)
		return self.g
	end,
	draw = function(self, explorer)
		cls(self.bgclr)
		rectfill(0, 0, explorer.current_width, 15, 6)
		print("selected:", explorer.current_width-70, 0, 0)
		print(self.elements[self.selected_element].name, explorer.current_width-70, 8, 0)
		for i in all(self.elements) do
			i:draw()
		end
		self.page_mockup:draw_all()
		
		self:draw_selection_indicator()
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
	end,
	convert_to_code = function(self)
		local string =
			"p = {\n"..
			"	title=\""..self.elements[1].name.." \",\n"..
			"	g=create_gui(\n"..
			"		{x=0,y=0,\n"..
			"		width="..self.elements[1].gui.width..",height="..self.elements[1].gui.width..",\n"..
			"		fgcol = 0x090d}),\n"..
			"	),\n"..
			"	init = function(self,explorer)\n"
		for i in all(self.elements) do
			if i and i != self.elements[1] then
				string = string..
					"		self."..i.name.." = self.g:"
				if i.gui.type == "button" then
					string = string..
						"attach_button({\n"..
						"			x="..i.x..", y="..i.y..", w="..i.w..", h="..i.h.."\n"..
						"			label=\""..i.gui.label.." \",\n"..
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
			"		cls("..self.bgcol..")"
		for i in all(self.elements) do
			if i and i != self.elements[1] then
				if i.gui.type == "text" then
					string = string..
						"		print(\""..i.gui.label.." \","..i.x..","..i.y","..i.clr..")"
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
	end
}

explorer = {current_width = 300, current_height = 200}

function _init()
	p:init(explorer)
	g = p:get_gui()
end

function _update()
	explorer.current_width = get_display():width()
	explorer.current_height = get_display():height()
	p:update(explorer)
	g:update_all()
end

function _draw()
	cls()
	p:draw(explorer)
	g:draw_all()
end
