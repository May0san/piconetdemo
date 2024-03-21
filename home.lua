--[[pod_format="raw",created="2024-03-20 06:16:57",modified="2024-03-21 02:16:41",revision=1654]]


p = {
	title = "home",
	get_gui = function(self,explorer)
		local g = create_gui({x=0,y=0,
			width=300,height=200-28,
			fgcol = 0x090d})
		g:attach_button({x=125,y=128,width=50,label="browse",
			bgcol=0x0706, fgcol=0x090d,
			click = function()
				explorer:open_page("https://raw.githubusercontent.com/May0san/piconetdemo/main/browse.lua")
			end
		})
		return g
	end,
	draw = function(self, explorer)
		cls(7)
		palt(7)
		circfill(150,72,40,1)
		ovalfill(112,34,188,100,16)
		ovalfill(126,36,174,62,12)
		ovalfill(140,40,160,47,28)
		spr(--[[pod,pod_type="image"]]unpod("b64:bHo0AI8AAABoAQAA8x1weHUAQyBAEAT-EDFwDQ5gDQ5QDR5gDQ4gDR4gDWANYA0OgA1gDXANgA1ADREAARsAAwMAIRANCACCgA0gDV4gDS4VAAEDABFOBgA-IA1AGwAHEB4eAB8_HAAiAlQAP4ANHhkAAz9wDS4ZAAM-IA1_GQAkBOsACRsAEl4bAQMtARQeFAAKRAFQHiAN-jI="),
		119,68)
		print("Explore\n	The",101,47,13)
		print("Explore\n	The",100,47,0)
		palt()
	end
}
