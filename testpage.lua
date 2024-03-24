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
	title="untitled page ",
	g=create_gui({
		x=0,y=0,
		width=300,height=300,
		fgcol = 0x090d
	}),
	copybuttons = {},	init = function(self,explorer)
		local page = self
		add(self.copybuttons, self.g:attach({
			x=173.0, y=22.0, width=24, height=24,
			event = function(self,msg)
				if(msg.event == "release") then
					set_clipboard("unpod(\""..pod(self.untitled3).."\")")
					notify("image userdata added to clipboard")
				end
			end
		}))
		add(self.copybuttons,self.g:attach({
			x=98.0, y=84.0, width=16, height=16,
			event = function(self,msg)
				if(msg.event == "release") then
					set_clipboard(pod({type="gif", w=16, h=16, frames=12, speed=1, clr=0, imgdata=self.untitled4_gif_raw}))
					notify("gif added to clipboard")
				end
			end
		}))
		add(self.copybuttons,self.g:attach({
			x=198.0, y=111.0, width=16, height=16,
			event = function(self,msg)
				if(msg.event == "release") then
					set_clipboard(pod({type="gif", w=16, h=16, frames=12, speed=1, clr=0, imgdata=self.untitled4_gif_raw}))
					notify("gif added to clipboard")
				end
			end
		}))
		add(self.copybuttons,self.g:attach({
			x=229.0, y=98.0, width=16, height=16,
			event = function(self,msg)
				if(msg.event == "release") then
					set_clipboard(pod({type="gif", w=16, h=16, frames=12, speed=1, clr=0, imgdata=self.untitled4_gif_raw}))
					notify("gif added to clipboard")
				end
			end
		}))
		add(self.copybuttons,self.g:attach({
			x=191.0, y=53.0, width=16, height=16,
			event = function(self,msg)
				if(msg.event == "release") then
					set_clipboard(pod({type="gif", w=16, h=16, frames=12, speed=1, clr=0, imgdata=self.untitled4_gif_raw}))
					notify("gif added to clipboard")
				end
			end
		}))
		add(self.copybuttons,self.g:attach({
			x=134.0, y=25.0, width=16, height=16,
			event = function(self,msg)
				if(msg.event == "release") then
					set_clipboard(pod({type="gif", w=16, h=16, frames=12, speed=1, clr=0, imgdata=self.untitled4_gif_raw}))
					notify("gif added to clipboard")
				end
			end
		}))
		add(self.copybuttons, self.g:attach({
			x=85.0, y=114.0, width=24, height=24,
			event = function(self,msg)
				if(msg.event == "release") then
					set_clipboard("unpod(\""..pod(self.untitled3).."\")")
					notify("image userdata added to clipboard")
				end
			end
		}))
		add(self.copybuttons, self.g:attach({
			x=40.0, y=84.0, width=24, height=24,
			event = function(self,msg)
				if(msg.event == "release") then
					set_clipboard("unpod(\""..pod(self.untitled3).."\")")
					notify("image userdata added to clipboard")
				end
			end
		}))
		add(self.copybuttons, self.g:attach({
			x=58.0, y=34.0, width=24, height=24,
			event = function(self,msg)
				if(msg.event == "release") then
					set_clipboard("unpod(\""..pod(self.untitled3).."\")")
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
		rectfill(130.0,73.5,170.0,113.5,8)
		palt(0)
		palt(0, true)
		sspr(self.untitled3, 0, 0, 24,24,173.0,22.0,24,24)
		palt()
		self.untitled4:draw(98.0,84.0,16,16,1,0)
		self.untitled4:draw(198.0,111.0,16,16,1,0)
		self.untitled4:draw(229.0,98.0,16,16,1,0)
		self.untitled4:draw(191.0,53.0,16,16,1,0)
		self.untitled4:draw(134.0,25.0,16,16,1,0)
		palt(0)
		palt(0, true)
		sspr(self.untitled3, 0, 0, 24,24,85.0,114.0,24,24)
		palt()
		palt(0)
		palt(0, true)
		sspr(self.untitled3, 0, 0, 24,24,40.0,84.0,24,24)
		palt()
		palt(0)
		palt(0, true)
		sspr(self.untitled3, 0, 0, 24,24,58.0,34.0,24,24)
		palt()
		
	end,
	update = function(self,explorer)
		
	end,
	untitled4_gif_raw = "b64:bHo0ALcBAAAQAwAA-AJweHUAQyDAEATwtD8WsE7ALgIA-wCgTpAOLw8ekA4tLqAOHR4EAA3-BYAOLS5wLi0OkB4tHpAeLQ4NgC4dBQAOACgA-wVwHi0ecH6AfoBugA4fIA4cDoAOHAYAD7ducH5gBR4cDhyAHhYADwYAHBFwPACAcAUOHA0MDYAHAAUgAD8uDC4EAAYVDjYAAAcAgS4MDqAuDB6QHgAfCQQACAE_AP8EHpAFLgmgBR4JDrAeCQ4FoB4JCgUADzEOBZAyAP8EFQ0ACQqQFQ0JCrAFDQrABQ0ZsAQAByAKsCkA8gTgDxkZCqALDQkNoA0ZsA0OGgmgBQBGCgkPFAwAFAgLAHAOGgmwDRnQMQDxBtANCQ0JGoAdGRpgDQ4JKpANChgJoAUAWwoJKAmQCgACBQDyEw4JKsAdGRqgDg0JCgQJgA4ZCgQJYA0OCggECZANCQgECaAGAG4KGAQLCZAMAAMGAAExABHAPgCCoA4LCgQLCoAHALBgDQAJBAsKkA0psAMAWQkICwmgCQAiKbAiABLAMAD1BqANACmQDQApcA0AKaAN4A3gDQAZsAYAwOANACnQDQApsA3wpQ==",12),
	untitled3 = unpod("b64:bHo0AHUAAACIAAAA8B1weHUAQyAYGAT3VZ8gDccOhx23Dgd2DQcNpw4HJhMmDRcNlw4HFgMLAwEWPgoAsSMBNgcOlw4HJhFGCABBVi8QAQkAcwYINgwPDAwNAGIPDggmHBEMAEIaCBYxCgAiKgg1ACIGMQgAsJYHDpcOtw6X3vdV"),
	untitled4 = new_gif("b64:bHo0ALcBAAAQAwAA-AJweHUAQyDAEATwtD8WsE7ALgIA-wCgTpAOLw8ekA4tLqAOHR4EAA3-BYAOLS5wLi0OkB4tHpAeLQ4NgC4dBQAOACgA-wVwHi0ecH6AfoBugA4fIA4cDoAOHAYAD7ducH5gBR4cDhyAHhYADwYAHBFwPACAcAUOHA0MDYAHAAUgAD8uDC4EAAYVDjYAAAcAgS4MDqAuDB6QHgAfCQQACAE_AP8EHpAFLgmgBR4JDrAeCQ4FoB4JCgUADzEOBZAyAP8EFQ0ACQqQFQ0JCrAFDQrABQ0ZsAQAByAKsCkA8gTgDxkZCqALDQkNoA0ZsA0OGgmgBQBGCgkPFAwAFAgLAHAOGgmwDRnQMQDxBtANCQ0JGoAdGRpgDQ4JKpANChgJoAUAWwoJKAmQCgACBQDyEw4JKsAdGRqgDg0JCgQJgA4ZCgQJYA0OCggECZANCQgECaAGAG4KGAQLCZAMAAMGAAExABHAPgCCoA4LCgQLCoAHALBgDQAJBAsKkA0psAMAWQkICwmgCQAiKbAiABLAMAD1BqANACmQDQApcA0AKaAN4A3gDQAZsAYAwOANACnQDQApsA3wpQ==",12)
}
