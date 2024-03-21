--[[pod_format="raw",created="2024-03-20 08:53:59",modified="2024-03-21 02:16:41",revision=1258]]


p = {
	get_gui = function(self,explorer)
		local g = create_gui({x=0,y=0,
			width=explorer.current_width,height=400,
			fgcol = 0x090d})
		g:attach_button({x=0,y=0,label="no page content",
			bgcol=0x0706, fgcol=0x090d,
			tap=function()
				--load_page("pages/home.lua")
			end
		})
		return g
	end
}
