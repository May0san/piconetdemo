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
	init = function(self,explorer)
		local page = self
		self.untitled2btn = self.g:attach({
			x=39.0, y=65.0, width=16, height=16,
			event = function(self,msg)
				if(msg.event == "release") then
					set_clipboard(pod({type="gif", w=16, h=16, frames=12, speed=1, clr=0, imgdata=untitled2_gif_raw}))
					notify("gif added to clipboard")
				end
			end
		})
		self.untitled3btn = self.g:attach({
			x=107.0, y=28.0, width=24, height=24,
			event = function(self,msg)
				if(msg.event == "release") then
					set_clipboard("unpod(\""..pod(untitled3).."\")")
					notify("image userdata added to clipboard")
				end
			end
		})
		self.untitled4btn = self.g:attach({
			x=191.0, y=54.0, width=24, height=24,
			event = function(self,msg)
				if(msg.event == "release") then
					set_clipboard("unpod(\""..pod(untitled3).."\")")
					notify("image userdata added to clipboard")
				end
			end
		})
		self.untitled5btn = self.g:attach({
			x=155.0, y=1.0, width=24, height=24,
			event = function(self,msg)
				if(msg.event == "release") then
					set_clipboard("unpod(\""..pod(untitled3).."\")")
					notify("image userdata added to clipboard")
				end
			end
		})
		self.untitled6btn = self.g:attach({
			x=69.0, y=34.0, width=24, height=24,
			event = function(self,msg)
				if(msg.event == "release") then
					set_clipboard("unpod(\""..pod(untitled3).."\")")
					notify("image userdata added to clipboard")
				end
			end
		})
		self.untitled7btn = self.g:attach({
			x=173.0, y=96.0, width=16, height=16,
			event = function(self,msg)
				if(msg.event == "release") then
					set_clipboard(pod({type="gif", w=16, h=16, frames=12, speed=1, clr=0, imgdata=untitled2_gif_raw}))
					notify("gif added to clipboard")
				end
			end
		})
		self.untitled8btn = self.g:attach({
			x=104.0, y=91.0, width=16, height=16,
			event = function(self,msg)
				if(msg.event == "release") then
					set_clipboard(pod({type="gif", w=16, h=16, frames=12, speed=1, clr=0, imgdata=untitled2_gif_raw}))
					notify("gif added to clipboard")
				end
			end
		})
		self.untitled9btn = self.g:attach({
			x=156.0, y=59.0, width=16, height=16,
			event = function(self,msg)
				if(msg.event == "release") then
					set_clipboard(pod({type="gif", w=16, h=16, frames=12, speed=1, clr=0, imgdata=untitled2_gif_raw}))
					notify("gif added to clipboard")
				end
			end
		})
		self.untitled10btn = self.g:attach({
			x=72.0, y=83.0, width=16, height=16,
			event = function(self,msg)
				if(msg.event == "release") then
					set_clipboard(pod({type="gif", w=16, h=16, frames=12, speed=1, clr=0, imgdata=untitled2_gif_raw}))
					notify("gif added to clipboard")
				end
			end
		})
	end,
	get_gui = function(self,explorer)
		return self.g
	end,
	draw = function(self,explorer)
		cls(0)
		self.untitled2:draw(39.0,65.0,16,16,1,0)
		palt(0)
		palt(0, true)
		sspr(self.untitled3, 0, 0, 24,24,107.0,28.0,24,24)
		palt()
		palt(0)
		palt(0, true)
		sspr(self.untitled3, 0, 0, 24,24,191.0,54.0,24,24)
		palt()
		palt(0)
		palt(0, true)
		sspr(self.untitled3, 0, 0, 24,24,155.0,1.0,24,24)
		palt()
		palt(0)
		palt(0, true)
		sspr(self.untitled3, 0, 0, 24,24,69.0,34.0,24,24)
		palt()
		self.untitled2:draw(173.0,96.0,16,16,1,0)
		self.untitled2:draw(104.0,91.0,16,16,1,0)
		self.untitled2:draw(156.0,59.0,16,16,1,0)
		self.untitled2:draw(72.0,83.0,16,16,1,0)
		
	end,
	update = function(self,explorer)
		
	end,
	untitled2_gif_raw = "b64:bHo0ALcBAAAQAwAA-AJweHUAQyDAEATwtD8WsE7ALgIA-wCgTpAOLw8ekA4tLqAOHR4EAA3-BYAOLS5wLi0OkB4tHpAeLQ4NgC4dBQAOACgA-wVwHi0ecH6AfoBugA4fIA4cDoAOHAYAD7ducH5gBR4cDhyAHhYADwYAHBFwPACAcAUOHA0MDYAHAAUgAD8uDC4EAAYVDjYAAAcAgS4MDqAuDB6QHgAfCQQACAE_AP8EHpAFLgmgBR4JDrAeCQ4FoB4JCgUADzEOBZAyAP8EFQ0ACQqQFQ0JCrAFDQrABQ0ZsAQAByAKsCkA8gTgDxkZCqALDQkNoA0ZsA0OGgmgBQBGCgkPFAwAFAgLAHAOGgmwDRnQMQDxBtANCQ0JGoAdGRpgDQ4JKpANChgJoAUAWwoJKAmQCgACBQDyEw4JKsAdGRqgDg0JCgQJgA4ZCgQJYA0OCggECZANCQgECaAGAG4KGAQLCZAMAAMGAAExABHAPgCCoA4LCgQLCoAHALBgDQAJBAsKkA0psAMAWQkICwmgCQAiKbAiABLAMAD1BqANACmQDQApcA0AKaAN4A3gDQAZsAYAwOANACnQDQApsA3wpQ==",
	untitled2 = new_gif("b64:bHo0ALcBAAAQAwAA-AJweHUAQyDAEATwtD8WsE7ALgIA-wCgTpAOLw8ekA4tLqAOHR4EAA3-BYAOLS5wLi0OkB4tHpAeLQ4NgC4dBQAOACgA-wVwHi0ecH6AfoBugA4fIA4cDoAOHAYAD7ducH5gBR4cDhyAHhYADwYAHBFwPACAcAUOHA0MDYAHAAUgAD8uDC4EAAYVDjYAAAcAgS4MDqAuDB6QHgAfCQQACAE_AP8EHpAFLgmgBR4JDrAeCQ4FoB4JCgUADzEOBZAyAP8EFQ0ACQqQFQ0JCrAFDQrABQ0ZsAQAByAKsCkA8gTgDxkZCqALDQkNoA0ZsA0OGgmgBQBGCgkPFAwAFAgLAHAOGgmwDRnQMQDxBtANCQ0JGoAdGRpgDQ4JKpANChgJoAUAWwoJKAmQCgACBQDyEw4JKsAdGRqgDg0JCgQJgA4ZCgQJYA0OCggECZANCQgECaAGAG4KGAQLCZAMAAMGAAExABHAPgCCoA4LCgQLCoAHALBgDQAJBAsKkA0psAMAWQkICwmgCQAiKbAiABLAMAD1BqANACmQDQApcA0AKaAN4A3gDQAZsAYAwOANACnQDQApsA3wpQ==",12),
	untitled3 = unpod("b64:bHo0AHUAAACIAAAA8B1weHUAQyAYGAT3VZ8gDccOhx23Dgd2DQcNpw4HJhMmDRcNlw4HFgMLAwEWPgoAsSMBNgcOlw4HJhFGCABBVi8QAQkAcwYINgwPDAwNAGIPDggmHBEMAEIaCBYxCgAiKgg1ACIGMQgAsJYHDpcOtw6X3vdV")
}
