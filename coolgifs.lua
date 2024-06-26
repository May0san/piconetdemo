--[[pod_format="raw",created="2024-03-27 20:33:33",modified="2024-03-27 20:33:33",revision=0]]
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
	title="The GIF Site ",
	g=create_gui({
		x=0,y=0,
		width=300,height=300,
		fgcol = 0x090d
	}),
	copybuttons = {},
	init = function(self,explorer)
		local page = self
		add(self.copybuttons,self.g:attach({
			x=12, y=146, width=18, height=18,
			event = function(self,msg)
				if(msg.event == "release") then
					set_clipboard(pod({type="gif", w=18, h=16, frames=4, speed=1, clr=0, imgdata=page.gif2_gif_raw}))
					notify("gif added to clipboard")
				end
			end
		}))
		add(self.copybuttons,self.g:attach({
			x=34, y=146, width=16, height=16,
			event = function(self,msg)
				if(msg.event == "release") then
					set_clipboard(pod({type="gif", w=16, h=16, frames=22, speed=3, clr=0, imgdata=page.gif5_gif_raw}))
					notify("gif added to clipboard")
				end
			end
		}))
		add(self.copybuttons,self.g:attach({
			x=56, y=146, width=16, height=16,
			event = function(self,msg)
				if(msg.event == "release") then
					set_clipboard(pod({type="gif", w=16, h=16, frames=3, speed=1, clr=0, imgdata=page.gif6_gif_raw}))
					notify("gif added to clipboard")
				end
			end
		}))
		add(self.copybuttons,self.g:attach({
			x=79, y=146, width=16, height=16,
			event = function(self,msg)
				if(msg.event == "release") then
					set_clipboard(pod({type="gif", w=16, h=16, frames=3, speed=1, clr=0, imgdata=page.gif7_gif_raw}))
					notify("gif added to clipboard")
				end
			end
		}))
		add(self.copybuttons,self.g:attach({
			x=102, y=146, width=16, height=16,
			event = function(self,msg)
				if(msg.event == "release") then
					set_clipboard(pod({type="gif", w=16, h=16, frames=8, speed=2, clr=0, imgdata=page.gif8_gif_raw}))
					notify("gif added to clipboard")
				end
			end
		}))
		add(self.copybuttons,self.g:attach({
			x=124, y=146, width=16, height=16,
			event = function(self,msg)
				if(msg.event == "release") then
					set_clipboard(pod({type="gif", w=16, h=16, frames=12, speed=1, clr=0, imgdata=page.gif9_gif_raw}))
					notify("gif added to clipboard")
				end
			end
		}))
		add(self.copybuttons,self.g:attach({
			x=144, y=146, width=16, height=16,
			event = function(self,msg)
				if(msg.event == "release") then
					set_clipboard(pod({type="gif", w=16, h=16, frames=6, speed=3, clr=0, imgdata=page.gif10_gif_raw}))
					notify("gif added to clipboard")
				end
			end
		}))
	end,
	get_gui = function(self,explorer)
		return self.g
	end,
	draw = function(self,explorer)
		cls(21)
		self.gif2:draw(12,146,18,16,1,0)
		print("Welcome to the GIF Site! ",9,12,7)
		print("Click on a gif to copy it to\nyour clipboard! Then you can\npaste it and use it in the\nSitebuilder! If you would like\nyour gif(s) to be added to the\ngif site, let me know and I\nwill add it!\n\nEnjoy:\n ",9,35,7)
		self.gif5:draw(34,146,16,16,3,0)
		self.gif6:draw(56,146,16,16,1,0)
		self.gif7:draw(79,146,16,16,1,0)
		self.gif8:draw(102,146,16,16,2,0)
		self.gif9:draw(124,146,16,16,1,0)
		self.gif10:draw(144,146,16,16,3,0)
		
	end,
	update = function(self,explorer)
		
	end,
	gif2_gif_raw = "b64:bHo0APYAAAAaAQAA8QdweHUAQyBIEAQgHyDgLvAALtAu0F6wAgD0AKAOAQ8TAT6QDgENTpAeDQoA8AdBPoBBPoAxToBBPpAeIS6QDjEukDE_BwC1oAEOET6AEQ4RPpAKAGOgIT6gAV4DAPILEV6QEV6QAW6QEV5wDgEuAT5wAS4BTnAuAV4JAGIOMU5wMV4DADGgfpACABCAKADTIA5ALgFOMAEwAX4gAQsA9QYRHiEuEA4BMAEeIT4gDgEgPhE_EBEOAPICES4xLhFALjFOESAuAQ4hLiEMAOMhHoEwDgEeoRAOAR4BDgwA8AchPmFAAS4BAHEgAR4RHmFAAS4BAHEA",
	gif5_gif_raw = "b64:bHo0AGIBAADTAwAA8zBweHUAQyhgAQAAEAAAAATw--_1AZ8QYA8gAW8QcBFOkB4hsAEfILARwB0BsCEekE4RcG4BDVCeAUABnlANAW4jAHkeDdAe0A0eIgDwEjABrlANAX5gEV6AHjGgHh2wHsAdHqAxHoBeEWB_AQ1AriIAGEAiAB-AIgAA-wwOeA8YDlANAQ5IDA5gEQ4oDA6AHgEcAaAeAg1RABLxCw0CHqABHAEegA4MKA4RYA4MSA4BDUAOeAwOXQAfDFwA-g_1AS4P_QE1IHEe4wAgQQ3jACAhDeMALx0BTgAYIAEd4QAgDSHhACENQeEAIHEeWAAgYS5YAO8xDR5gEQ4RDR6AHgENEVgAGSANEVgAIBEeWAAgMR5YAHRhLgEwAZ5gDwMXMU4ADzEDAQhOADcxHoAiAJGOcA0BXoARPqBTAxPAUwPioD4RgF4BDWCOAVABjmAiAAGYAyQdwJcDBCIAUAHw--_2",
	gif6_gif_raw = "b64:bHo0ANIAAAAGAQAA8wVweHUAQyAwEARAWZBZkFlwGVoZUAQAU0AJmgkwBADyAiAJKg8gOg4qCRAJugkQCSoODADVGi4aLhoJEAkKLjouChAA4gAJKi4aLioZOh4aHjoZDAACBgBTGi46LhoMAHM6DjoOOhnaCABZGg56DhoGADQKvgoEAPAEKRoODxg4DQ4aOQoOeA4KORoODQ4AwRkAGRoOPQ4aGRAZChIANAoZEBIA0ikaPhopECkKDj0OCikOAPAMIDk6OTApCj4KKTA5OjlAmVCZUJlwWZBZkFlA",
	gif7_gif_raw = "b64:bHo0AKcAAADbAAAA8wVweHUAQyAwEARAWZBZkFlwGVoZUAQAU0AJmgkwBABVIAm6CRAEAGQaDyBaDhoNABAODADiAAkaLjouGhkqLhouKhkMAAMGADQeWh4MAHUqDloOKhnaCACE2hnaKTo_OjkEALIaHjoeGjkqDjoOKgwA4xkACR56HgkQGR5aHhkQDADEDglaCQ4ZECkOWg4pDgDwBCC5MLkwuUCZUJlQmXBZkFmQWUA=",
	gif8_gif_raw = "b64:bHo0AA8BAAA5AgAAyXB4dQBDIIAQBEBZkAIAX3AZWhlQBAAIX0AJmgkwBAAIXyAJugkQBAAJ_BBfIBpeEA4GPhoGThAeBi4aDgY_EC4WDhoeFh4QXhpeBAD7DwAJCr4KGQoGXgY_ChkKFk4WLgoZCh4WThYOChkKvgQANU4aTgYAAF4AADMA_wAOFh4aDhYeChkKPgYaPgYmAAEGAFoaLjouGgYA2xYOOhYOGhkaHgY6HgYcAAEGABraAgB-KQoOeg4KOQYAFz8eeh4EAAmPGQAZCn4KGRAGAAE-DloOCAACAB4ArDkOPxgOORA5Dj0GABdeBAAAEgBYIDk_OTAEABG5AgBpOT45QJlQAgATcBcCkJBZkFmQWZBZQA==",
	gif9_gif_raw = "b64:bHo0ALcBAAAQAwAA-AJweHUAQyDAEATwtD8WsE7ALgIA-wCgTpAOLw8ekA4tLqAOHR4EAA3-BYAOLS5wLi0OkB4tHpAeLQ4NgC4dBQAOACgA-wVwHi0ecH6AfoBugA4fIA4cDoAOHAYAD7ducH5gBR4cDhyAHhYADwYAHBFwPACAcAUOHA0MDYAHAAUgAD8uDC4EAAYVDjYAAAcAgS4MDqAuDB6QHgAfCQQACAE_AP8EHpAFLgmgBR4JDrAeCQ4FoB4JCgUADzEOBZAyAP8EFQ0ACQqQFQ0JCrAFDQrABQ0ZsAQAByAKsCkA8gTgDxkZCqALDQkNoA0ZsA0OGgmgBQBGCgkPFAwAFAgLAHAOGgmwDRnQMQDxBtANCQ0JGoAdGRpgDQ4JKpANChgJoAUAWwoJKAmQCgACBQDyEw4JKsAdGRqgDg0JCgQJgA4ZCgQJYA0OCggECZANCQgECaAGAG4KGAQLCZAMAAMGAAExABHAPgCCoA4LCgQLCoAHALBgDQAJBAsKkA0psAMAWQkICwmgCQAiKbAiABLAMAD1BqANACmQDQApcA0AKaAN4A3gDQAZsAYAwOANACnQDQApsA3wpQ==",
	gif10_gif_raw = "b64:bHo0AOMAAADMAQAA5HB4dQBDIGAQBEBfHpBeAgA1cJ5QAgA1QL4wAgByIE4BHgFOEAYAEd4CAAMSAJgHHgdOEE4GHgYeAAEQAPALAA4PDj4PIB4NPg8OHgw_DR4NPgweDD4HHgcIAEEuEQ4REABUEQ4RLgwgAJ0uDC4BHgEuDD4IABOeBAADEAB2HB4BHgEeHAgAF34EAAIUAEYeAt4SAgB-HgIOXQ4CHggAFV9CDl0OcgQAAI8yABIuPS4SEAYACl8gIl4iMAQAAH4gTxgySxBLBACPAAs4GxIbOBsGAAprC1gLEAu4BABQuAsQC1g=",
	gif2 = new_gif("b64:bHo0APYAAAAaAQAA8QdweHUAQyBIEAQgHyDgLvAALtAu0F6wAgD0AKAOAQ8TAT6QDgENTpAeDQoA8AdBPoBBPoAxToBBPpAeIS6QDjEukDE_BwC1oAEOET6AEQ4RPpAKAGOgIT6gAV4DAPILEV6QEV6QAW6QEV5wDgEuAT5wAS4BTnAuAV4JAGIOMU5wMV4DADGgfpACABCAKADTIA5ALgFOMAEwAX4gAQsA9QYRHiEuEA4BMAEeIT4gDgEgPhE_EBEOAPICES4xLhFALjFOESAuAQ4hLiEMAOMhHoEwDgEeoRAOAR4BDgwA8AchPmFAAS4BAHEgAR4RHmFAAS4BAHEA",4),
	gif5 = new_gif("b64:bHo0AGIBAADTAwAA8zBweHUAQyhgAQAAEAAAAATw--_1AZ8QYA8gAW8QcBFOkB4hsAEfILARwB0BsCEekE4RcG4BDVCeAUABnlANAW4jAHkeDdAe0A0eIgDwEjABrlANAX5gEV6AHjGgHh2wHsAdHqAxHoBeEWB_AQ1AriIAGEAiAB-AIgAA-wwOeA8YDlANAQ5IDA5gEQ4oDA6AHgEcAaAeAg1RABLxCw0CHqABHAEegA4MKA4RYA4MSA4BDUAOeAwOXQAfDFwA-g_1AS4P_QE1IHEe4wAgQQ3jACAhDeMALx0BTgAYIAEd4QAgDSHhACENQeEAIHEeWAAgYS5YAO8xDR5gEQ4RDR6AHgENEVgAGSANEVgAIBEeWAAgMR5YAHRhLgEwAZ5gDwMXMU4ADzEDAQhOADcxHoAiAJGOcA0BXoARPqBTAxPAUwPioD4RgF4BDWCOAVABjmAiAAGYAyQdwJcDBCIAUAHw--_2",22),
	gif6 = new_gif("b64:bHo0ANIAAAAGAQAA8wVweHUAQyAwEARAWZBZkFlwGVoZUAQAU0AJmgkwBADyAiAJKg8gOg4qCRAJugkQCSoODADVGi4aLhoJEAkKLjouChAA4gAJKi4aLioZOh4aHjoZDAACBgBTGi46LhoMAHM6DjoOOhnaCABZGg56DhoGADQKvgoEAPAEKRoODxg4DQ4aOQoOeA4KORoODQ4AwRkAGRoOPQ4aGRAZChIANAoZEBIA0ikaPhopECkKDj0OCikOAPAMIDk6OTApCj4KKTA5OjlAmVCZUJlwWZBZkFlA",3),
	gif7 = new_gif("b64:bHo0AKcAAADbAAAA8wVweHUAQyAwEARAWZBZkFlwGVoZUAQAU0AJmgkwBABVIAm6CRAEAGQaDyBaDhoNABAODADiAAkaLjouGhkqLhouKhkMAAMGADQeWh4MAHUqDloOKhnaCACE2hnaKTo_OjkEALIaHjoeGjkqDjoOKgwA4xkACR56HgkQGR5aHhkQDADEDglaCQ4ZECkOWg4pDgDwBCC5MLkwuUCZUJlQmXBZkFmQWUA=",3),
	gif8 = new_gif("b64:bHo0AA8BAAA5AgAAyXB4dQBDIIAQBEBZkAIAX3AZWhlQBAAIX0AJmgkwBAAIXyAJugkQBAAJ_BBfIBpeEA4GPhoGThAeBi4aDgY_EC4WDhoeFh4QXhpeBAD7DwAJCr4KGQoGXgY_ChkKFk4WLgoZCh4WThYOChkKvgQANU4aTgYAAF4AADMA_wAOFh4aDhYeChkKPgYaPgYmAAEGAFoaLjouGgYA2xYOOhYOGhkaHgY6HgYcAAEGABraAgB-KQoOeg4KOQYAFz8eeh4EAAmPGQAZCn4KGRAGAAE-DloOCAACAB4ArDkOPxgOORA5Dj0GABdeBAAAEgBYIDk_OTAEABG5AgBpOT45QJlQAgATcBcCkJBZkFmQWZBZQA==",8),
	gif9 = new_gif("b64:bHo0ALcBAAAQAwAA-AJweHUAQyDAEATwtD8WsE7ALgIA-wCgTpAOLw8ekA4tLqAOHR4EAA3-BYAOLS5wLi0OkB4tHpAeLQ4NgC4dBQAOACgA-wVwHi0ecH6AfoBugA4fIA4cDoAOHAYAD7ducH5gBR4cDhyAHhYADwYAHBFwPACAcAUOHA0MDYAHAAUgAD8uDC4EAAYVDjYAAAcAgS4MDqAuDB6QHgAfCQQACAE_AP8EHpAFLgmgBR4JDrAeCQ4FoB4JCgUADzEOBZAyAP8EFQ0ACQqQFQ0JCrAFDQrABQ0ZsAQAByAKsCkA8gTgDxkZCqALDQkNoA0ZsA0OGgmgBQBGCgkPFAwAFAgLAHAOGgmwDRnQMQDxBtANCQ0JGoAdGRpgDQ4JKpANChgJoAUAWwoJKAmQCgACBQDyEw4JKsAdGRqgDg0JCgQJgA4ZCgQJYA0OCggECZANCQgECaAGAG4KGAQLCZAMAAMGAAExABHAPgCCoA4LCgQLCoAHALBgDQAJBAsKkA0psAMAWQkICwmgCQAiKbAiABLAMAD1BqANACmQDQApcA0AKaAN4A3gDQAZsAYAwOANACnQDQApsA3wpQ==",12),
	gif10 = new_gif("b64:bHo0AOMAAADMAQAA5HB4dQBDIGAQBEBfHpBeAgA1cJ5QAgA1QL4wAgByIE4BHgFOEAYAEd4CAAMSAJgHHgdOEE4GHgYeAAEQAPALAA4PDj4PIB4NPg8OHgw_DR4NPgweDD4HHgcIAEEuEQ4REABUEQ4RLgwgAJ0uDC4BHgEuDD4IABOeBAADEAB2HB4BHgEeHAgAF34EAAIUAEYeAt4SAgB-HgIOXQ4CHggAFV9CDl0OcgQAAI8yABIuPS4SEAYACl8gIl4iMAQAAH4gTxgySxBLBACPAAs4GxIbOBsGAAprC1gLEAu4BABQuAsQC1g=",6)
}
