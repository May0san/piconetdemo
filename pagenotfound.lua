--[[pod_format="raw",created="2024-03-20 20:04:04",modified="2024-03-21 02:16:41",revision=827]]


p = {
	title = "not found",
	get_gui = function(self,explorer)
		local g = create_gui({x=0,y=0,
			width=explorer.current_width,height=explorer.current_height-28,
			fgcol = 0x090d})
		g:attach_button({x=0,y=10,label="page not found",
			bgcol=0x0706, fgcol=0x090d,
			tap=function()
				--load_page("pages/home.lua")
			end
		})
		return g
	end
}