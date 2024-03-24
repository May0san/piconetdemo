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
			x=193.0, y=90.0, width=24, height=24,
			event = function(self,msg)
				if(msg.event == "release") then
					set_clipboard("--[[pod,pod_type=\"image\"]]unpod(\""..pod(page.untitled2).."\")")
					notify("image userdata added to clipboard")
				end
			end
		}))
		add(self.copybuttons,self.g:attach({
			x=72.0, y=80.0, width=16, height=16,
			event = function(self,msg)
				if(msg.event == "release") then
					set_clipboard(pod({type="gif", w=16, h=16, frames=12, speed=1, clr=0, imgdata=page.untitled3_gif_raw}))
					notify("gif added to clipboard")
				end
			end
		}))
		add(self.copybuttons, self.g:attach({
			x=182.0, y=52.0, width=24, height=24,
			event = function(self,msg)
				if(msg.event == "release") then
					set_clipboard("--[[pod,pod_type=\"image\"]]unpod(\""..pod(page.untitled2).."\")")
					notify("image userdata added to clipboard")
				end
			end
		}))
		self.untitled5 = self.g:attach_button({
			x=10.0, y=16.5, width=50, height=13,
			label="button ",
			click=function()
				
			end
		})
		add(self.copybuttons, self.g:attach({
			x=159.0, y=53.0, width=24, height=24,
			event = function(self,msg)
				if(msg.event == "release") then
					set_clipboard("--[[pod,pod_type=\"image\"]]unpod(\""..pod(page.untitled2).."\")")
					notify("image userdata added to clipboard")
				end
			end
		}))
		add(self.copybuttons, self.g:attach({
			x=85.0, y=30.0, width=24, height=24,
			event = function(self,msg)
				if(msg.event == "release") then
					set_clipboard("--[[pod,pod_type=\"image\"]]unpod(\""..pod(page.untitled2).."\")")
					notify("image userdata added to clipboard")
				end
			end
		}))
		add(self.copybuttons,self.g:attach({
			x=150.0, y=109.0, width=16, height=16,
			event = function(self,msg)
				if(msg.event == "release") then
					set_clipboard(pod({type="gif", w=16, h=16, frames=12, speed=1, clr=0, imgdata=page.untitled3_gif_raw}))
					notify("gif added to clipboard")
				end
			end
		}))
		add(self.copybuttons,self.g:attach({
			x=90.0, y=110.0, width=16, height=16,
			event = function(self,msg)
				if(msg.event == "release") then
					set_clipboard(pod({type="gif", w=16, h=16, frames=12, speed=1, clr=0, imgdata=page.untitled3_gif_raw}))
					notify("gif added to clipboard")
				end
			end
		}))
		add(self.copybuttons,self.g:attach({
			x=121.0, y=55.0, width=16, height=16,
			event = function(self,msg)
				if(msg.event == "release") then
					set_clipboard(pod({type="gif", w=16, h=16, frames=12, speed=1, clr=0, imgdata=page.untitled3_gif_raw}))
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
		palt(0)
		palt(0, true)
		sspr(self.untitled2, 0, 0, 24,24,193.0,90.0,24,24)
		palt()
		self.untitled3:draw(72.0,80.0,16,16,1,0)
		palt(0)
		palt(0, true)
		sspr(self.untitled2, 0, 0, 24,24,182.0,52.0,24,24)
		palt()
		palt(0)
		palt(0, true)
		sspr(self.untitled2, 0, 0, 24,24,159.0,53.0,24,24)
		palt()
		palt(0)
		palt(0, true)
		sspr(self.untitled2, 0, 0, 24,24,85.0,30.0,24,24)
		palt()
		self.untitled3:draw(150.0,109.0,16,16,1,0)
		self.untitled3:draw(90.0,110.0,16,16,1,0)
		self.untitled3:draw(121.0,55.0,16,16,1,0)
		
	end,
	update = function(self,explorer)
		
	end,
	untitled3_gif_raw = "b64:bHo0ALcBAAAQAwAA-AJweHUAQyDAEATwtD8WsE7ALgIA-wCgTpAOLw8ekA4tLqAOHR4EAA3-BYAOLS5wLi0OkB4tHpAeLQ4NgC4dBQAOACgA-wVwHi0ecH6AfoBugA4fIA4cDoAOHAYAD7ducH5gBR4cDhyAHhYADwYAHBFwPACAcAUOHA0MDYAHAAUgAD8uDC4EAAYVDjYAAAcAgS4MDqAuDB6QHgAfCQQACAE_AP8EHpAFLgmgBR4JDrAeCQ4FoB4JCgUADzEOBZAyAP8EFQ0ACQqQFQ0JCrAFDQrABQ0ZsAQAByAKsCkA8gTgDxkZCqALDQkNoA0ZsA0OGgmgBQBGCgkPFAwAFAgLAHAOGgmwDRnQMQDxBtANCQ0JGoAdGRpgDQ4JKpANChgJoAUAWwoJKAmQCgACBQDyEw4JKsAdGRqgDg0JCgQJgA4ZCgQJYA0OCggECZANCQgECaAGAG4KGAQLCZAMAAMGAAExABHAPgCCoA4LCgQLCoAHALBgDQAJBAsKkA0psAMAWQkICwmgCQAiKbAiABLAMAD1BqANACmQDQApcA0AKaAN4A3gDQAZsAYAwOANACnQDQApsA3wpQ==",
	untitled2 = unpod("b64:bHo0AHUAAACIAAAA8B1weHUAQyAYGAT3VZ8gDccOhx23Dgd2DQcNpw4HJhMmDRcNlw4HFgMLAwEWPgoAsSMBNgcOlw4HJhFGCABBVi8QAQkAcwYINgwPDAwNAGIPDggmHBEMAEIaCBYxCgAiKgg1ACIGMQgAsJYHDpcOtw6X3vdV"),
	untitled3 = new_gif("b64:bHo0ALcBAAAQAwAA-AJweHUAQyDAEATwtD8WsE7ALgIA-wCgTpAOLw8ekA4tLqAOHR4EAA3-BYAOLS5wLi0OkB4tHpAeLQ4NgC4dBQAOACgA-wVwHi0ecH6AfoBugA4fIA4cDoAOHAYAD7ducH5gBR4cDhyAHhYADwYAHBFwPACAcAUOHA0MDYAHAAUgAD8uDC4EAAYVDjYAAAcAgS4MDqAuDB6QHgAfCQQACAE_AP8EHpAFLgmgBR4JDrAeCQ4FoB4JCgUADzEOBZAyAP8EFQ0ACQqQFQ0JCrAFDQrABQ0ZsAQAByAKsCkA8gTgDxkZCqALDQkNoA0ZsA0OGgmgBQBGCgkPFAwAFAgLAHAOGgmwDRnQMQDxBtANCQ0JGoAdGRpgDQ4JKpANChgJoAUAWwoJKAmQCgACBQDyEw4JKsAdGRqgDg0JCgQJgA4ZCgQJYA0OCggECZANCQgECaAGAG4KGAQLCZAMAAMGAAExABHAPgCCoA4LCgQLCoAHALBgDQAJBAsKkA0psAMAWQkICwmgCQAiKbAiABLAMAD1BqANACmQDQApcA0AKaAN4A3gDQAZsAYAwOANACnQDQApsA3wpQ==",12)
}
