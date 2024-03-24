p = {
	title = "Cool Gifs!", -- the title displayed on the tab
	g = create_gui({x=0,y=0,
		width=explorer.current_width,height=300,--this height determines scroll and page height
		fgcol = 0x090d}),
	init = function(self,explorer)
	end,
	get_gui = function(self,explorer)
		return self.g
	end,
	update = function(self,explorer)
		
	end,
	draw = function(self,explorer) -- use this to draw, write text, etc. You can use cls() without issues as well if you want a different bg
		cls(21)
		print("\n\n"..
			"Here's a bunch of gifs you can use\n"..
			"to get that nice early internet vibe!\n\n"..
			"Copy the link in the address bar and\n"..
			"paste it into a (non-PICOTRON) browser,\n"..
			"and you'll be able to copy the gifs into\n"..
			"your own pages! There's also some directions\n"..
			"there on how to make your own (it's easy!)\n\n"..
			"Here you go:", 10,0,7)
		self.spin_cartridge:draw(2,180,3,0)-- you only need to specify position when drawing gif
		self.smile:draw(20,180,1,0)
		self.sad:draw(38, 180,1,0)
		self.sunglasses:draw(56, 180,2,0)
		self.the_mystical_trumpeting_skeleton:draw(74,180,1,0)
		self.kirby_blink:draw(92, 180,3,0)
	end,
	--gifs use a pod. you can copy it directly from the gfx editor. The format is one frame tall by however many frames you have long
	spin_cartridge = new_gif(unpod("b64:bHo0AGIBAADTAwAA8zBweHUAQyhgAQAAEAAAAATw--_1AZ8QYA8gAW8QcBFOkB4hsAEfILARwB0BsCEekE4RcG4BDVCeAUABnlANAW4jAHkeDdAe0A0eIgDwEjABrlANAX5gEV6AHjGgHh2wHsAdHqAxHoBeEWB_AQ1AriIAGEAiAB-AIgAA-wwOeA8YDlANAQ5IDA5gEQ4oDA6AHgEcAaAeAg1RABLxCw0CHqABHAEegA4MKA4RYA4MSA4BDUAOeAwOXQAfDFwA-g_1AS4P_QE1IHEe4wAgQQ3jACAhDeMALx0BTgAYIAEd4QAgDSHhACENQeEAIHEeWAAgYS5YAO8xDR5gEQ4RDR6AHgENEVgAGSANEVgAIBEeWAAgMR5YAHRhLgEwAZ5gDwMXMU4ADzEDAQhOADcxHoAiAJGOcA0BXoARPqBTAxPAUwPioD4RgF4BDWCOAVABjmAiAAGYAyQdwJcDBCIAUAHw--_2"),
		22), -- params (excluding the pod) are: number of frames, frame width, frame height, speed (bigger number = faster), alpha color
	smile = new_gif(--[[pod,pod_type="image"]]unpod("b64:bHo0ANIAAAAGAQAA8wVweHUAQyAwEARAWZBZkFlwGVoZUAQAU0AJmgkwBADyAiAJKg8gOg4qCRAJugkQCSoODADVGi4aLhoJEAkKLjouChAA4gAJKi4aLioZOh4aHjoZDAACBgBTGi46LhoMAHM6DjoOOhnaCABZGg56DhoGADQKvgoEAPAEKRoODxg4DQ4aOQoOeA4KORoODQ4AwRkAGRoOPQ4aGRAZChIANAoZEBIA0ikaPhopECkKDj0OCikOAPAMIDk6OTApCj4KKTA5OjlAmVCZUJlwWZBZkFlA"),
		3),
	sad = new_gif(unpod("b64:bHo0AKcAAADbAAAA8wVweHUAQyAwEARAWZBZkFlwGVoZUAQAU0AJmgkwBABVIAm6CRAEAGQaDyBaDhoNABAODADiAAkaLjouGhkqLhouKhkMAAMGADQeWh4MAHUqDloOKhnaCACE2hnaKTo_OjkEALIaHjoeGjkqDjoOKgwA4xkACR56HgkQGR5aHhkQDADEDglaCQ4ZECkOWg4pDgDwBCC5MLkwuUCZUJlQmXBZkFmQWUA="),
		3),
	sunglasses = new_gif(unpod("b64:bHo0AA8BAAA5AgAAyXB4dQBDIIAQBEBZkAIAX3AZWhlQBAAIX0AJmgkwBAAIXyAJugkQBAAJ_BBfIBpeEA4GPhoGThAeBi4aDgY_EC4WDhoeFh4QXhpeBAD7DwAJCr4KGQoGXgY_ChkKFk4WLgoZCh4WThYOChkKvgQANU4aTgYAAF4AADMA_wAOFh4aDhYeChkKPgYaPgYmAAEGAFoaLjouGgYA2xYOOhYOGhkaHgY6HgYcAAEGABraAgB-KQoOeg4KOQYAFz8eeh4EAAmPGQAZCn4KGRAGAAE-DloOCAACAB4ArDkOPxgOORA5Dj0GABdeBAAAEgBYIDk_OTAEABG5AgBpOT45QJlQAgATcBcCkJBZkFmQWZBZQA=="),
		8),
	the_mystical_trumpeting_skeleton = new_gif(--[[pod,pod_type="image"]]unpod("b64:bHo0ALcBAAAQAwAA-AJweHUAQyDAEATwtD8WsE7ALgIA-wCgTpAOLw8ekA4tLqAOHR4EAA3-BYAOLS5wLi0OkB4tHpAeLQ4NgC4dBQAOACgA-wVwHi0ecH6AfoBugA4fIA4cDoAOHAYAD7ducH5gBR4cDhyAHhYADwYAHBFwPACAcAUOHA0MDYAHAAUgAD8uDC4EAAYVDjYAAAcAgS4MDqAuDB6QHgAfCQQACAE_AP8EHpAFLgmgBR4JDrAeCQ4FoB4JCgUADzEOBZAyAP8EFQ0ACQqQFQ0JCrAFDQrABQ0ZsAQAByAKsCkA8gTgDxkZCqALDQkNoA0ZsA0OGgmgBQBGCgkPFAwAFAgLAHAOGgmwDRnQMQDxBtANCQ0JGoAdGRpgDQ4JKpANChgJoAUAWwoJKAmQCgACBQDyEw4JKsAdGRqgDg0JCgQJgA4ZCgQJYA0OCggECZANCQgECaAGAG4KGAQLCZAMAAMGAAExABHAPgCCoA4LCgQLCoAHALBgDQAJBAsKkA0psAMAWQkICwmgCQAiKbAiABLAMAD1BqANACmQDQApcA0AKaAN4A3gDQAZsAYAwOANACnQDQApsA3wpQ=="),
		12),
	kirby_blink = new_gif(unpod("b64:bHo0AOMAAADMAQAA5HB4dQBDIGAQBEBfHpBeAgA1cJ5QAgA1QL4wAgByIE4BHgFOEAYAEd4CAAMSAJgHHgdOEE4GHgYeAAEQAPALAA4PDj4PIB4NPg8OHgw_DR4NPgweDD4HHgcIAEEuEQ4REABUEQ4RLgwgAJ0uDC4BHgEuDD4IABOeBAADEAB2HB4BHgEeHAgAF34EAAIUAEYeAt4SAgB-HgIOXQ4CHggAFV9CDl0OcgQAAI8yABIuPS4SEAYACl8gIl4iMAQAAH4gTxgySxBLBACPAAs4GxIbOBsGAAprC1gLEAu4BABQuAsQC1g="),
		6)
	
}
