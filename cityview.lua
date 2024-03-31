--[[pod_format="raw",created="2024-03-31 04:44:48",modified="2024-03-31 05:50:04",revision=3]]
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
		self.button6 = self.g:attach_button({
			x=20.5, y=217, width=101, height=20,
			label="Download Wallpaper ",
			click=function()
				download("https://github.com/May0san/piconetdemo/blob/main/cityview.p64.png")
			end
		})
		add(self.copybuttons, self.g:attach({
			x=138, y=74, width=140, height=140,
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
		rectfill(0,23,300,63,1)
		print("CityView Moving Wallpaper\n	\n	by Meivuu ",0,25,7)
		print("Watch the sparkling\nlights of the city\nin the background of\nyour PICOTRON\nworkstation!\n ",19,81,7)
		print("If you watch for\nlong enough, you\nmight catch\nsomething\n~~MYSTERIOUS~~\n ",19,148,7)
		rectfill(136.5,68.5,279.5,157.5,1)
		palt(0)
		palt(25, true)
		sspr(self.image8, 0, 0, 140,78,138,74,140,78)
		palt()
		print("preview screenshot imported\nwith pancelor's importpng\ntool :)\n ",138,161,7)
		print("Built with\nSiteBuilder!\n ",220,25,7)
		ovalfill(220.5,91,223.5,93,7)
		oval(216,87,226,97,8)
		rectfill(227,92,257,93,8)
		print("??? ",224,75,8)
		
	end,
	update = function(self,explorer)
		
	end,
	image8_raw = "b64:bHo0AG0DAAB6AwAAtnB4dQBDIIxOBPD-AQDQJw8U8P-kAfB8AfB6EQYAEnsDABARAwDwvH0R8HMBcCFwB1AHgA8WwAdwBqAHQA7ADoAO8BEFIAFwIRAHAA4nAA8PNxAGBw0QB1AHMAcABVAFEA8ODhAOoAdQDQAHBgcwBw0wBwAHEBYFBhAHBgAFUAcwCgAHAAkgBiAOIAcBoCEXAA4HABcQDgYAFwAGEA0HEAcABwYwDg8XMA0HBgAOAAcgBlAKDhAHcAYOIAdgBgAOB5ANgAYHUAcOAAcAB0AB0CEPDQcPFQcgBw5ABgcMDR4NIAcFMA8OAA0MDgAOBQAODQAeCgCwAAUNAAUOEB4HBQAGAPA9DgAHDxdADgAMBQAMEA5QHkAMEA4MByAFAAYOBTAOEAbwA0ENAAYQDgYHAA0KAA5gCgcFEAsOCwwFBgcwBUAMQAcNFw0FAAYHEAZADIkA8QZQBgWwBgWABRAHAAYADkAKDw3wBkEUAbBABwAGBwAHsBUQBQsA8BMwBkAHEAdgB0AGMAdQBRAHIA4QBTAHcAHwCVEQB6AHAA0OkQDxFWALUA4gBSAFAA5wBg4ABZAMIAQAB1AHAA7wBQHwCmHABgUgDVAA8CUHIAbwBQ7QCjAHUAfwBgHwDWEGBw6wDZAODAcNEA0gBwAOEAoADTALAAUNBwANAA0WEAoNsADw-ygOEAcNAA2ABhAGDRANBwYLIAwQDAAB8A5x8AAGsATwBgsABvAXDkAB8BBxAAQNUAUMEA7ABgwQDDAFMAxwDrANDpAH8ClxwAfwAQ2wByAMgA1wBqAG8AAB8BOBUAzwBAnwBQVAB7AN8AkB8BaBcAYL4A3wMBHwGIFgBvABCyAN8AwLwAYwDqAB8BmR8AgNYAXwFwfQAfAckfArBsANkBHwHpHwBQbwHQWwAfAjoeAFEA4wC-AUC9AB8CWh8AMNMA1QB-AOBqAR8Ceh8AEEMA4wDvAMDlAFUBHwKrHwBgfwGxHwLbHgBvAcEfA0wfAmEfA5waAN8BcR8DvR8AAF8A4R8D7h0A8UB-AKAfBD8QBQDVAO8F-xAMAN8AMB8EvxAdAH4AHwTvEBEA8fDfBp8QHwBwHwVvEC4QDwIVrxA7AB8F7xAyAFMAHwYfEEAAoQAfBm8QPwbNHwb6HwcmHwdiHwegHwdwHweQHwzA==",
	image8 = unpod("b64:bHo0AG0DAAB6AwAAtnB4dQBDIIxOBPD-AQDQJw8U8P-kAfB8AfB6EQYAEnsDABARAwDwvH0R8HMBcCFwB1AHgA8WwAdwBqAHQA7ADoAO8BEFIAFwIRAHAA4nAA8PNxAGBw0QB1AHMAcABVAFEA8ODhAOoAdQDQAHBgcwBw0wBwAHEBYFBhAHBgAFUAcwCgAHAAkgBiAOIAcBoCEXAA4HABcQDgYAFwAGEA0HEAcABwYwDg8XMA0HBgAOAAcgBlAKDhAHcAYOIAdgBgAOB5ANgAYHUAcOAAcAB0AB0CEPDQcPFQcgBw5ABgcMDR4NIAcFMA8OAA0MDgAOBQAODQAeCgCwAAUNAAUOEB4HBQAGAPA9DgAHDxdADgAMBQAMEA5QHkAMEA4MByAFAAYOBTAOEAbwA0ENAAYQDgYHAA0KAA5gCgcFEAsOCwwFBgcwBUAMQAcNFw0FAAYHEAZADIkA8QZQBgWwBgWABRAHAAYADkAKDw3wBkEUAbBABwAGBwAHsBUQBQsA8BMwBkAHEAdgB0AGMAdQBRAHIA4QBTAHcAHwCVEQB6AHAA0OkQDxFWALUA4gBSAFAA5wBg4ABZAMIAQAB1AHAA7wBQHwCmHABgUgDVAA8CUHIAbwBQ7QCjAHUAfwBgHwDWEGBw6wDZAODAcNEA0gBwAOEAoADTALAAUNBwANAA0WEAoNsADw-ygOEAcNAA2ABhAGDRANBwYLIAwQDAAB8A5x8AAGsATwBgsABvAXDkAB8BBxAAQNUAUMEA7ABgwQDDAFMAxwDrANDpAH8ClxwAfwAQ2wByAMgA1wBqAG8AAB8BOBUAzwBAnwBQVAB7AN8AkB8BaBcAYL4A3wMBHwGIFgBvABCyAN8AwLwAYwDqAB8BmR8AgNYAXwFwfQAfAckfArBsANkBHwHpHwBQbwHQWwAfAjoeAFEA4wC-AUC9AB8CWh8AMNMA1QB-AOBqAR8Ceh8AEEMA4wDvAMDlAFUBHwKrHwBgfwGxHwLbHgBvAcEfA0wfAmEfA5waAN8BcR8DvR8AAF8A4R8D7h0A8UB-AKAfBD8QBQDVAO8F-xAMAN8AMB8EvxAdAH4AHwTvEBEA8fDfBp8QHwBwHwVvEC4QDwIVrxA7AB8F7xAyAFMAHwYfEEAAoQAfBm8QPwbNHwb6HwcmHwdiHwegHwdwHweQHwzA==")
}
