--[[pod_format="raw",created="2024-03-31 05:12:36",modified="2024-03-31 05:46:59",revision=8]]
--[[	Thanks for using PicoNet Sitebuilder! I look forward
	to seeing your picosite! In order to make this available
	on PicoNet Explorer, you'll need to upload this lua file
	somewhere on the internet that you can get a link to it.
	Then, you'll want to go to the following thread:
	
		https://www.lexaloffle.com/bbs/?tid=140960
	
	and post your link based on the format provided there.
	it's  very possible that this format could change slightly
	and so I will not be listing that here just yet.
]]

	p = {
	title="Meivuu ",
	g=create_gui({
		x=0,y=0,
		width=300,height=300,
		fgcol = 0x090d
	}),
	copybuttons = {},
	init = function(self,explorer)
		local page = self
		self.button5 = self.g:attach_button({
			x=16.0, y=235.5, width=100, height=13,
			label="CityView Wallpaper ",
			click=function()
				explorer:open_page("https://raw.githubusercontent.com/May0san/piconetdemo/main/cityview.lua")
			end
		})
		self.button6 = self.g:attach_button({
			x=16.0, y=254.5, width=124, height=13,
			label="Snowy Lamp Screensaver ",
			click=function()
				explorer:open_page("https://raw.githubusercontent.com/May0san/piconetdemo/main/screensnower.lua")
			end
		})
		add(self.copybuttons, self.g:attach({
			x=183, y=66, width=64, height=64,
			event = function(self,msg)
				if(msg.event == "release") then
					set_clipboard("--[[pod,pod_type=\"image\"]]unpod(\""..page.image8_raw.."\")")
					notify("image userdata added to clipboard")
				end
			end
		}))
	end,
	get_gui = function(self,explorer)
		return self.g
	end,
	draw = function(self,explorer)
		cls(0)
		rectfill(0,0,300,40,1)
		print("Meivuu's Picosite! ",7.0,15.0,7)
		print("Welcome to my picosite!\nIt's pretty plain and\nempty right now, but\nI'll add more to it\nsoon, hopefully!!\n\nThis was made using the\nsitebuilder tool I made,\nyou can use it too at\nthe top of the browse\npage!\n\nYou can visit some of\nthe other pages on my\nsite with some content:\n ",13,62,7)
		rectfill(178,61,252,135,1)
		palt(0)
		palt(0, true)
		sspr(self.image8, 0, 0, 32,32,183,66,64,64)
		palt()
		
	end,
	update = function(self,explorer)
		
	end,
	image8_raw = "b64:bHo0APYBAAASAgAA8gJweHUAQyAgIAQEEgEHFgEEEgMAMxcGAgwA8C0kJxZkBgcENwYCZAIkBx4XBkQXFDcGtAYOCA4mJAYHBgQGJxYCZAIEAgQBBw4IDgYNBAECFwEEBhcWAgEVAPA8AgQCASQCBgcOCBYNFg0HRg0GRAKEBgceB0Y3Fg3EAhQGBw4HBhcGBwYHBicGRAJEAi0mJwZXBicGAQQCPQIBBA0MBw0WNwYHBocGDADxBy0CHQcNFicGJwYXBicGJx0HjRYXBncPAPAcTQwtDBZXDw8Gtw0MDSYdBgwWRwYbBgcbBmcGDBYHBg0EDRZXezcGJzYNJBoAYDcrJwYnPZsAwQZHKwcNASsGFwsGF-cA4BQWRwY7AQArAQcrF0QCDgDyEcsHBgd0BgcGNztXCCsHBAdEAgQCBwZHOwg_GBsNBgQH6AAQBEwAsQY7SBsNBiQLAgs01QDwIBYdew0GByQLBAskBzYnBj04LQYNBiQrNAIWNxYNCC4IHggdFgEEAjsCARQWJxYNEQDxFC4IDQYCBAgOKwQCFAY3Bg0OCC4IDggOCB4IBhROCCQGNwYeEgDgHggeBwIEDgg_AgQWJxYmAAIWALEBCB4YDggBBCYXBjgAEQ5nADAeAl6xAVMHFj4IHgIA8AVOCCQWBwYHCC4IAh4IDgguCG4IJA==",
	image8 = unpod("b64:bHo0APYBAAASAgAA8gJweHUAQyAgIAQEEgEHFgEEEgMAMxcGAgwA8C0kJxZkBgcENwYCZAIkBx4XBkQXFDcGtAYOCA4mJAYHBgQGJxYCZAIEAgQBBw4IDgYNBAECFwEEBhcWAgEVAPA8AgQCASQCBgcOCBYNFg0HRg0GRAKEBgceB0Y3Fg3EAhQGBw4HBhcGBwYHBicGRAJEAi0mJwZXBicGAQQCPQIBBA0MBw0WNwYHBocGDADxBy0CHQcNFicGJwYXBicGJx0HjRYXBncPAPAcTQwtDBZXDw8Gtw0MDSYdBgwWRwYbBgcbBmcGDBYHBg0EDRZXezcGJzYNJBoAYDcrJwYnPZsAwQZHKwcNASsGFwsGF-cA4BQWRwY7AQArAQcrF0QCDgDyEcsHBgd0BgcGNztXCCsHBAdEAgQCBwZHOwg_GBsNBgQH6AAQBEwAsQY7SBsNBiQLAgs01QDwIBYdew0GByQLBAskBzYnBj04LQYNBiQrNAIWNxYNCC4IHggdFgEEAjsCARQWJxYNEQDxFC4IDQYCBAgOKwQCFAY3Bg0OCC4IDggOCB4IBhROCCQGNwYeEgDgHggeBwIEDgg_AgQWJxYmAAIWALEBCB4YDggBBCYXBjgAEQ5nADAeAl6xAVMHFj4IHgIA8AVOCCQWBwYHCC4IAh4IDgguCG4IJA==")
}
