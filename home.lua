

p = {
	title = "home",
	get_gui = function(self,explorer)
		local g = create_gui({
			x=0,y=0,
			width=300,height=200-28,
			fgcol = 0x090d,
			draw = function(self)
				cls(7)
				local center_x = self.parent.width/2--default 150
				local center_y = (self.parent.height/2) + 35--default 118
				circfill(center_x,center_y-46,40,1)
				ovalfill(center_x-38,center_y-84,center_x+38,center_y-18,16)
				ovalfill(center_x-24,center_y-82,center_x+24,center_y-56,12)
				ovalfill(center_x-10,center_y-78,center_x+10,center_y-71,28)
				spr(self.icon,center_x-31,center_y-50)
				print("Explore\n	The",center_x-49,center_y-71,13)
				print("Explore\n	The",center_x-50,center_y-71,0)
			end,
			update = function(self)
				self.browse.x = (self.parent.width/2)-25
				self.browse.y=(self.parent.height/2) + 35
			end,
			icon = --[[pod_type="gfx"]]unpod("b64:bHo0AI8AAABoAQAA8x1weHUAQyBAEATwMX8gDQBuDQBeDRBuDQAuDRAuDW4Nbg0Ajg1uDX4Njg1ODREAARsAAwMAIR4NCACCjg0uDVAuDSAVAAEDABFABgA-Lg1OGwAHEBAeAB8wHAAiAlQAP44NEBkAAz9_DSAZAAM-Lg1wGQAkBOsACRsAElAbAQMtARQQFAAKRAFQEC4N8DI=")
		})
		g.browse = g:attach_button({x=(explorer.current_width/2)-25,y=(explorer.current_height/2) + 28,width=50,label="browse",
			click = function()
				explorer:open_page("https://raw.githubusercontent.com/May0san/piconetdemo/main/browse.lua")
			end
		})
		return g
	end,
	draw = function(self, explorer)
--		cls(7)
--		local center_x = explorer.current_width/2--default 150
--		local center_y = (explorer.current_height/2) + 18--default 118
--		circfill(center_x,center_y-46,40,1)
--		ovalfill(center_x-38,center_y-84,center_x+38,center_y-18,16)
--		ovalfill(center_x-24,center_y-82,center_x+24,center_y-56,12)
--		ovalfill(center_x-10,center_y-78,center_x+10,center_y-71,28)
--		spr(self.icon,center_x-31,center_y-50)
--		print("Explore\n	The",center_x-49,center_y-71,13)
--		print("Explore\n	The",center_x-50,center_y-71,0)
	end,
	update = function(self, explorer)
--		self.browse.x = (explorer.current_width/2)-25
--		self.browse.y=(explorer.current_height/2) + 28
	end,
	icon = --[[pod_type="gfx"]]unpod("b64:bHo0AI8AAABoAQAA8x1weHUAQyBAEATwMX8gDQBuDQBeDRBuDQAuDRAuDW4Nbg0Ajg1uDX4Njg1ODREAARsAAwMAIR4NCACCjg0uDVAuDSAVAAEDABFABgA-Lg1OGwAHEBAeAB8wHAAiAlQAP44NEBkAAz9_DSAZAAM-Lg1wGQAkBOsACRsAElAbAQMtARQQFAAKRAFQEC4N8DI=")
}
