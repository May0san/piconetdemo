--[[pod_format="raw",created="2024-03-31 05:12:36",modified="2024-03-31 05:27:42",revision=2]]
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
	title="CityView Wallpaper ",
	g=create_gui({
		x=0,y=0,
		width=300,height=300,
		fgcol = 0x090d
	}),
	copybuttons = {},
	init = function(self,explorer)
		local page = self
		self.button5 = self.g:attach_button({
			x=15.0, y=239.5, width=100, height=13,
			label="CityView Wallpaper ",
			click=function()
				
			end
		})
		self.button6 = self.g:attach_button({
			x=15.0, y=255.5, width=124, height=13,
			label="Snowy Lamp Screensaver ",
			click=function()
				
			end
		})
		add(self.copybuttons, self.g:attach({
			x=183.0, y=66.0, width=64, height=64,
			event = function(self,msg)
				if(msg.event == "release") then
					set_clipboard("--[[pod,pod_type=\"image\"]]unpod(\""..page.image9_raw.."\")")
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
		print("Meivuu's Picosite! ",5.0,12.0,7)
		print("Welcome to my picosite!\nIt's pretty plain and\nempty right now, but\nI'll add more to it\nsoon, hopefully!!\n\nThis was made using the\nsitebuilder tool I made,\nyou can use it too at\nthe top of the browse\npage!\n\nYou can visit some of\nthe other pages on my\nsite with some content:\n ",13.0,62.0,7)
		rectfill(178.0,61.0,252.0,135.0,1)
		palt(0)
		palt(0, true)
		sspr(self.image9, 0, 0, 32,32,183.0,66.0,64,64)
		palt()
		
	end,
	update = function(self,explorer)
		
	end,
	image9_raw = "b64:bHo0APYBAAASAgAA8gJweHUAQyAgIAQEEgEHFgEEEgMAMxcGAgwA8C0kJxZkBgcENwYCZAIkBx4XBkQXFDcGtAYOCA4mJAYHBgQGJxYCZAIEAgQBBw4IDgYNBAECFwEEBhcWAgEVAPA8AgQCASQCBgcOCBYNFg0HRg0GRAKEBgceB0Y3Fg3EAhQGBw4HBhcGBwYHBicGRAJEAi0mJwZXBicGAQQCPQIBBA0MBw0WNwYHBocGDADxBy0CHQcNFicGJwYXBicGJx0HjRYXBncPAPAcTQwtDBZXDw8Gtw0MDSYdBgwWRwYbBgcbBmcGDBYHBg0EDRZXezcGJzYNJBoAYDcrJwYnPZsAwQZHKwcNASsGFwsGF-cA4BQWRwY7AQArAQcrF0QCDgDyEcsHBgd0BgcGNztXCCsHBAdEAgQCBwZHOwg_GBsNBgQH6AAQBEwAsQY7SBsNBiQLAgs01QDwIBYdew0GByQLBAskBzYnBj04LQYNBiQrNAIWNxYNCC4IHggdFgEEAjsCARQWJxYNEQDxFC4IDQYCBAgOKwQCFAY3Bg0OCC4IDggOCB4IBhROCCQGNwYeEgDgHggeBwIEDgg_AgQWJxYmAAIWALEBCB4YDggBBCYXBjgAEQ5nADAeAl6xAVMHFj4IHgIA8AVOCCQWBwYHCC4IAh4IDgguCG4IJA==",
	image9 = --[[pod_type="gfx"]]unpod("b64:bHo0APYBAAASAgAA8gJweHUAQyAgIAQEEgEHFgEEEgMAMxcGAgwA8C0kJxZkBgcENwYCZAIkBx4XBkQXFDcGtAYOCA4mJAYHBgQGJxYCZAIEAgQBBw4IDgYNBAECFwEEBhcWAgEVAPA8AgQCASQCBgcOCBYNFg0HRg0GRAKEBgceB0Y3Fg3EAhQGBw4HBhcGBwYHBicGRAJEAi0mJwZXBicGAQQCPQIBBA0MBw0WNwYHBocGDADxBy0CHQcNFicGJwYXBicGJx0HjRYXBncPAPAcTQwtDBZXDw8Gtw0MDSYdBgwWRwYbBgcbBmcGDBYHBg0EDRZXezcGJzYNJBoAYDcrJwYnPZsAwQZHKwcNASsGFwsGF-cA4BQWRwY7AQArAQcrF0QCDgDyEcsHBgd0BgcGNztXCCsHBAdEAgQCBwZHOwg_GBsNBgQH6AAQBEwAsQY7SBsNBiQLAgs01QDwIBYdew0GByQLBAskBzYnBj04LQYNBiQrNAIWNxYNCC4IHggdFgEEAjsCARQWJxYNEQDxFC4IDQYCBAgOKwQCFAY3Bg0OCC4IDggOCB4IBhROCCQGNwYeEgDgHggeBwIEDgg_AgQWJxYmAAIWALEBCB4YDggBBCYXBjgAEQ5nADAeAl6xAVMHFj4IHgIA8AVOCCQWBwYHCC4IAh4IDgguCG4IJA==")
