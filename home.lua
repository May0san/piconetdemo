--[[pod_format="raw",created="2024-03-20 06:16:57",modified="2024-03-21 02:16:41",revision=1654]]


p = {
	title = "home",
	get_gui = function(self,explorer)
		local g = create_gui({x=0,y=0,
			width=300,height=200-28,
			fgcol = 0x090d})
		g:attach_button({x=100,y=0,label="home",
			bgcol=0x0706, fgcol=0x090d
		})
		return g
	end,
	draw = function(self, explorer)
		cls(12)
	end
}