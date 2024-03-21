--[[pod_format="raw",created="2024-03-21 03:18:50",modified="2024-03-21 03:19:41",revision=4]]


--				<div style="margin-left:10px; cursor:pointer"
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
		g.
		return g
	end
}