

p = {
	title = "sitebuilder",
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
			fgcol = 0}),
		edit = {
		
		},
		code = {
			
		},
		new = {
			button,
			pulldown = {x = t.new.button.x, y = 0, flat_top = true},
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
		fgcol = 0x090d})
	page_mockup = create_gui({x=0,y=0-- draw but don't update
		width=300,height=200-28,
		fgcol = 0x090d}),
	selected_gui,
	init = function(self,explorer)
		self:create_element(page_mockup, 0, 0, explorer.current_width, explorer.current_height, "root")

		local t = self.toolbar
		t.gui = g:attach(create_gui({x=0, y=0, width=explorer.current_width, height = 15}))
		
		local n = t.new
		n.pulldown:attach_pulldown_item("new")
		n.items.button = n.pulldown:attach_pulldown_item("button")
		
		
		selected_gui = self.page_elements[1]
	end,
	function create_element(self, gui, x, y, w, h, name, draw_func)
		local num = count(self.elements) + 1
		add(self.elements, {gui = gui,
			draw = draw_func or function()end,
			selection_btn = self.selection_gui:attach_button({x=(explorer.current_width/2)-25,y=(explorer.current_height/2) + 28,width=50,label="browse",
			click = function()
					--maybe is p rather than self, also need to do fancy stuff for overlapping
					self.selected_gui = self.page_elements[num]
				end
			}),
			name = name or "untitled" + num,
			num = num,
			delete = function(self, page)
				if self.num != 1 then
					self.gui.detach()
					page.elements[self.num] = nil
				end
			end
		})
	end,
	get_gui = function(self,explorer)
		return self.g
	end,
	draw = function(self, explorer)
		cls(self.bgclr)
	end,
	update = function(self, explorer)
	end
}
