--[[pod_format="raw",created="2024-03-31 04:53:59",modified="2024-03-31 05:10:01",revision=2]]
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
	title="Snowy Lamp Screensaver ",
	g=create_gui({
		x=0,y=0,
		width=300,height=300,
		fgcol = 0x090d
	}),
	copybuttons = {},
	init = function(self,explorer)
		local page = self
		self.button5 = self.g:attach_button({
			x=20, y=200, width=112, height=20,
			label="Download Screensaver ",
			click=function()
				download("https://github.com/May0san/piconetdemo/blob/main/screensnower.p64.png")
			end
		})
		add(self.copybuttons, self.g:attach({
			x=206, y=113, width=32, height=32,
			event = function(self,msg)
				if(msg.event == "release") then
					set_clipboard("--[[pod,pod_type=\"image\"]]unpod(\""..page.image7_raw.."\")")
					notify("image userdata added to clipboard")
				end
			end
		}))
		add(self.copybuttons,self.g:attach({
			x=176.0, y=104.0, width=16, height=16,
			event = function(self,msg)
				if(msg.event == "release") then
					set_clipboard(pod({type="gif", w=16, h=16, frames=5, speed=1, clr=0, imgdata=page.gif8_gif_raw}))
					notify("gif added to clipboard")
				end
			end
		}))
		add(self.copybuttons,self.g:attach({
			x=192.0, y=104.0, width=16, height=16,
			event = function(self,msg)
				if(msg.event == "release") then
					set_clipboard(pod({type="gif", w=16, h=16, frames=5, speed=1, clr=0, imgdata=page.gif8_gif_raw}))
					notify("gif added to clipboard")
				end
			end
		}))
		add(self.copybuttons,self.g:attach({
			x=208.0, y=104.0, width=16, height=16,
			event = function(self,msg)
				if(msg.event == "release") then
					set_clipboard(pod({type="gif", w=16, h=16, frames=5, speed=1, clr=0, imgdata=page.gif8_gif_raw}))
					notify("gif added to clipboard")
				end
			end
		}))
		add(self.copybuttons,self.g:attach({
			x=208.0, y=120.0, width=16, height=16,
			event = function(self,msg)
				if(msg.event == "release") then
					set_clipboard(pod({type="gif", w=16, h=16, frames=5, speed=1, clr=0, imgdata=page.gif8_gif_raw}))
					notify("gif added to clipboard")
				end
			end
		}))
		add(self.copybuttons,self.g:attach({
			x=194.0, y=120.0, width=16, height=16,
			event = function(self,msg)
				if(msg.event == "release") then
					set_clipboard(pod({type="gif", w=16, h=16, frames=5, speed=1, clr=0, imgdata=page.gif8_gif_raw}))
					notify("gif added to clipboard")
				end
			end
		}))
		add(self.copybuttons,self.g:attach({
			x=178.0, y=121.0, width=16, height=16,
			event = function(self,msg)
				if(msg.event == "release") then
					set_clipboard(pod({type="gif", w=16, h=16, frames=5, speed=1, clr=0, imgdata=page.gif8_gif_raw}))
					notify("gif added to clipboard")
				end
			end
		}))
		add(self.copybuttons,self.g:attach({
			x=224.0, y=119.0, width=16, height=16,
			event = function(self,msg)
				if(msg.event == "release") then
					set_clipboard(pod({type="gif", w=16, h=16, frames=5, speed=1, clr=0, imgdata=page.gif8_gif_raw}))
					notify("gif added to clipboard")
				end
			end
		}))
		add(self.copybuttons,self.g:attach({
			x=224.0, y=105.0, width=16, height=16,
			event = function(self,msg)
				if(msg.event == "release") then
					set_clipboard(pod({type="gif", w=16, h=16, frames=5, speed=1, clr=0, imgdata=page.gif8_gif_raw}))
					notify("gif added to clipboard")
				end
			end
		}))
		add(self.copybuttons,self.g:attach({
			x=224.0, y=136.0, width=16, height=16,
			event = function(self,msg)
				if(msg.event == "release") then
					set_clipboard(pod({type="gif", w=16, h=16, frames=5, speed=1, clr=0, imgdata=page.gif8_gif_raw}))
					notify("gif added to clipboard")
				end
			end
		}))
		add(self.copybuttons,self.g:attach({
			x=209.0, y=137.0, width=16, height=16,
			event = function(self,msg)
				if(msg.event == "release") then
					set_clipboard(pod({type="gif", w=16, h=16, frames=5, speed=1, clr=0, imgdata=page.gif8_gif_raw}))
					notify("gif added to clipboard")
				end
			end
		}))
		add(self.copybuttons,self.g:attach({
			x=195.0, y=136.0, width=16, height=16,
			event = function(self,msg)
				if(msg.event == "release") then
					set_clipboard(pod({type="gif", w=16, h=16, frames=5, speed=1, clr=0, imgdata=page.gif8_gif_raw}))
					notify("gif added to clipboard")
				end
			end
		}))
		add(self.copybuttons,self.g:attach({
			x=179.0, y=137.0, width=16, height=16,
			event = function(self,msg)
				if(msg.event == "release") then
					set_clipboard(pod({type="gif", w=16, h=16, frames=5, speed=1, clr=0, imgdata=page.gif8_gif_raw}))
					notify("gif added to clipboard")
				end
			end
		}))
		add(self.copybuttons,self.g:attach({
			x=224.0, y=152.0, width=16, height=16,
			event = function(self,msg)
				if(msg.event == "release") then
					set_clipboard(pod({type="gif", w=16, h=16, frames=5, speed=1, clr=0, imgdata=page.gif8_gif_raw}))
					notify("gif added to clipboard")
				end
			end
		}))
		add(self.copybuttons,self.g:attach({
			x=209.0, y=153.0, width=16, height=16,
			event = function(self,msg)
				if(msg.event == "release") then
					set_clipboard(pod({type="gif", w=16, h=16, frames=5, speed=1, clr=0, imgdata=page.gif8_gif_raw}))
					notify("gif added to clipboard")
				end
			end
		}))
		add(self.copybuttons,self.g:attach({
			x=194.0, y=154.0, width=16, height=16,
			event = function(self,msg)
				if(msg.event == "release") then
					set_clipboard(pod({type="gif", w=16, h=16, frames=5, speed=1, clr=0, imgdata=page.gif8_gif_raw}))
					notify("gif added to clipboard")
				end
			end
		}))
		add(self.copybuttons,self.g:attach({
			x=180.0, y=154.0, width=16, height=16,
			event = function(self,msg)
				if(msg.event == "release") then
					set_clipboard(pod({type="gif", w=16, h=16, frames=5, speed=1, clr=0, imgdata=page.gif8_gif_raw}))
					notify("gif added to clipboard")
				end
			end
		}))
		add(self.copybuttons,self.g:attach({
			x=240.0, y=106.0, width=16, height=16,
			event = function(self,msg)
				if(msg.event == "release") then
					set_clipboard(pod({type="gif", w=16, h=16, frames=5, speed=1, clr=0, imgdata=page.gif8_gif_raw}))
					notify("gif added to clipboard")
				end
			end
		}))
		add(self.copybuttons,self.g:attach({
			x=240.0, y=121.0, width=16, height=16,
			event = function(self,msg)
				if(msg.event == "release") then
					set_clipboard(pod({type="gif", w=16, h=16, frames=5, speed=1, clr=0, imgdata=page.gif8_gif_raw}))
					notify("gif added to clipboard")
				end
			end
		}))
		add(self.copybuttons,self.g:attach({
			x=240.0, y=136.0, width=16, height=16,
			event = function(self,msg)
				if(msg.event == "release") then
					set_clipboard(pod({type="gif", w=16, h=16, frames=5, speed=1, clr=0, imgdata=page.gif8_gif_raw}))
					notify("gif added to clipboard")
				end
			end
		}))
		add(self.copybuttons,self.g:attach({
			x=240.0, y=154.0, width=16, height=16,
			event = function(self,msg)
				if(msg.event == "release") then
					set_clipboard(pod({type="gif", w=16, h=16, frames=5, speed=1, clr=0, imgdata=page.gif8_gif_raw}))
					notify("gif added to clipboard")
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
		print("Snowy Lamp Screensaver\n	\n	by Meivuu ",3,27,7)
		print("Watch the snow fall\nand slowly reveal a\nlamp post! You can\nsee one of them to\nthe right, but as it\nplays more and\nmore, it will reveal\ndifferent lamps.\n ",19,81,7)
		print("Built with\nSiteBuilder! ",220,29,7)
		palt(0)
		palt(0, true)
		sspr(self.image7, 0, 0, 32,64,206,113,32,64)
		palt()
		self.gif8:draw(176.0,104.0,16,16,1,0)
		self.gif8:draw(192.0,104.0,16,16,1,0)
		self.gif8:draw(208.0,104.0,16,16,1,0)
		self.gif8:draw(208.0,120.0,16,16,1,0)
		self.gif8:draw(194.0,120.0,16,16,1,0)
		self.gif8:draw(178.0,121.0,16,16,1,0)
		self.gif8:draw(224.0,119.0,16,16,1,0)
		self.gif8:draw(224.0,105.0,16,16,1,0)
		self.gif8:draw(224.0,136.0,16,16,1,0)
		self.gif8:draw(209.0,137.0,16,16,1,0)
		self.gif8:draw(195.0,136.0,16,16,1,0)
		self.gif8:draw(179.0,137.0,16,16,1,0)
		self.gif8:draw(224.0,152.0,16,16,1,0)
		self.gif8:draw(209.0,153.0,16,16,1,0)
		self.gif8:draw(194.0,154.0,16,16,1,0)
		self.gif8:draw(180.0,154.0,16,16,1,0)
		self.gif8:draw(240.0,106.0,16,16,1,0)
		self.gif8:draw(240.0,121.0,16,16,1,0)
		self.gif8:draw(240.0,136.0,16,16,1,0)
		self.gif8:draw(240.0,154.0,16,16,1,0)
		
	end,
	update = function(self,explorer)
		
	end,
	gif8_gif_raw = "b64:bHo0AK8AAADKAAAA8AtweHUAQyBQEASQB-AEJzAH8AIHUCfwBifwBAsAcTAnUAfwAQcFACDwBR8AEwEfABAFCwAGHwBAAAfwBh8AoAgn8AUn8AYH8A8UANFQBxAH8BgH8AsncBfAHQCACweAB3AHcAcjAIABB-AMJ1An4DsAIfAMFwBRUCdwB8BOAFANJ1AHcF8AQQUn8A1lAEAncAewlADwCfAQBzAHcBdQB4AHwBfwHxcwJ-AHBwAH0A==",
	image7_raw = "b64:bHo0ABgBAACTAQAA8idweHUAQyAgQATwnV3wCI3wBR0GDWbwBA0GHxUWTgbwAx0OHxIeXPADDQ4cDSwNLA3wAg0OHB0KAPEBDhwNEAFXAfACDgwNIBE3EQkATxCR8AEHAAVNALHwAAcALdHgBQD-BA8d4dAODAvh0BwL4dAMDQvxAMAGAAMnAbAGACCgAQcALwKQBwABIIARBwApA3AHACBgIQcAIwRQBwDxAhEOHA0M8QNQEQwdCw3xA0AhCAArBDAIACAgMQgAUSZXJoEQCgDwBNcWQRAhBhwNCw33AQYhEBEGDUwKAPAKEQABBicNDA0MDfcEBhFHDfcIAQb3Dgb3EAYA8A4A9w4QBvcMBjAG9wgGYAb3BgaQFvcAFvAAJlcmkA==",
	image7 = unpod("b64:bHo0ABgBAACTAQAA8idweHUAQyAgQATwnV3wCI3wBR0GDWbwBA0GHxUWTgbwAx0OHxIeXPADDQ4cDSwNLA3wAg0OHB0KAPEBDhwNEAFXAfACDgwNIBE3EQkATxCR8AEHAAVNALHwAAcALdHgBQD-BA8d4dAODAvh0BwL4dAMDQvxAMAGAAMnAbAGACCgAQcALwKQBwABIIARBwApA3AHACBgIQcAIwRQBwDxAhEOHA0M8QNQEQwdCw3xA0AhCAArBDAIACAgMQgAUSZXJoEQCgDwBNcWQRAhBhwNCw33AQYhEBEGDUwKAPAKEQABBicNDA0MDfcEBhFHDfcIAQb3Dgb3EAYA8A4A9w4QBvcMBjAG9wgGYAb3BgaQFvcAFvAAJlcmkA=="),
	gif8 = new_gif("b64:bHo0AK8AAADKAAAA8AtweHUAQyBQEASQB-AEJzAH8AIHUCfwBifwBAsAcTAnUAfwAQcFACDwBR8AEwEfABAFCwAGHwBAAAfwBh8AoAgn8AUn8AYH8A8UANFQBxAH8BgH8AsncBfAHQCACweAB3AHcAcjAIABB-AMJ1An4DsAIfAMFwBRUCdwB8BOAFANJ1AHcF8AQQUn8A1lAEAncAewlADwCfAQBzAHcBdQB4AHwBfwHxcwJ-AHBwAH0A==",5)
}
