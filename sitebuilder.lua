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
	selection_gui = create_gui({x=0,y=15+28,-- update but don't draw
		width=300,height=200-28,
		fgcol = 0x090d}),
	page_mockup = create_gui({x=0,y=0,-- draw but don't update
		width=300,height=200-28,
		fgcol = 0x090d}),
	selected_gui,
	init = function(self,explorer)
		self:create_element(self.page_mockup, 0, 0, explorer.current_width, explorer.current_height, "root")

		local t = self.toolbar
		t.gui = create_gui({x=0, y=0, width=explorer.current_width, height = 15, fgcol = 0x90d})
		self.g:attach(t.gui)
		
		local n = t.new
		n.button = t.gui:attach_button({x=1,y=0,z=50,label="new",
			click=function()
				n.pulldown = self.g:attach_pulldown({x = 1, y = -3, width = 80})
				n.pulldown:attach_pulldown_item({label = "new",action = function()end})
				n.items.button = n.pulldown:attach_pulldown_item({
					label = "button",
					action = function()
						self:create_element(
							self.page_mockup:attach_button({
								x = self.g.width/2, y = self.g.height/2, width = 50, height = 13, label = "button", click = function()end
							}),
							self.g.width/2, self.g.height/2, 50, 13
						)
					end
				})
			end
		})
		--
		
		self.selected_element = 1
	end,
	create_element = function(self, gui, x, y, w, h, name, draw_func)
		local num = count(self.elements) + 1
		local page = self
		local e = {
			x = x,
			y = y,
			w = w,
			h = h,
			gui = gui,
			draw = draw_func or function()end,
			selection_btn = self.selection_gui:attach({x=x,y=y,width=w,height=h,label="",
				event = function(self, msg)
					if msg.event == "drag" and page.selected_element == num and num != 1 then
						--assert(false)
						local mx, my = mouse()
						--assert(false)
						page.elements[page.selected_element].x = mx
						page.elements[page.selected_element].y = my
						page.elements[num].gui.x = mx
						page.elements[num].gui.y = my
					end
					if msg.event == "release" then
						page.selected_element = num
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
				self.gui.x = self.x
				self.gui.y = self.y
				self.selection_btn.x = self.x
				self.selection_btn.y = self.y
				self.gui.x = self.w
				self.gui.y = self.h
				self.selection_btn.x = self.w
				self.selection_btn.y = self.h
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
		print("selected:\n"..self.elements[self.selected_element].name, explorer.current_width-70, 0, 0)
		self.page_mockup:draw_all()
	end,
	update = function(self, explorer)
		self.selection_gui:update_all()
		for i in all(self.elements) do
			i:update()
		end
	end
}
