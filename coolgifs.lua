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
		self.spin_cartridge:draw(2,180)-- you only need to specify position when drawing gif
		self.smile:draw(20,180)
		self.sad:draw(38, 180)
		self.sunglasses:draw(56, 180)
	end,
	--gifs use a pod. you can copy it directly from the gfx editor. The format is one frame tall by however many frames you have long
	spin_cartridge = new_gif(unpod("b64:bHo0AGIBAADTAwAA8zBweHUAQyhgAQAAEAAAAATw--_1AZ8QYA8gAW8QcBFOkB4hsAEfILARwB0BsCEekE4RcG4BDVCeAUABnlANAW4jAHkeDdAe0A0eIgDwEjABrlANAX5gEV6AHjGgHh2wHsAdHqAxHoBeEWB_AQ1AriIAGEAiAB-AIgAA-wwOeA8YDlANAQ5IDA5gEQ4oDA6AHgEcAaAeAg1RABLxCw0CHqABHAEegA4MKA4RYA4MSA4BDUAOeAwOXQAfDFwA-g_1AS4P_QE1IHEe4wAgQQ3jACAhDeMALx0BTgAYIAEd4QAgDSHhACENQeEAIHEeWAAgYS5YAO8xDR5gEQ4RDR6AHgENEVgAGSANEVgAIBEeWAAgMR5YAHRhLgEwAZ5gDwMXMU4ADzEDAQhOADcxHoAiAJGOcA0BXoARPqBTAxPAUwPioD4RgF4BDWCOAVABjmAiAAGYAyQdwJcDBCIAUAHw--_2"),
		22,16,16,3,0), -- params (excluding the pod) are: number of frames, frame width, frame height, speed (bigger number = faster), alpha color
	smile = new_gif(unpod("b64:bHo0AM0AAAAFAQAA8wVweHUAQyAwEARAWZBZkFlwGVoZUAQAU0AJmgkwBADVIAkqADoAKgkQCboJEAwA1RogGiAaCRAJCiA6IAoQAOIACSogGiAqGToQGhA6GQwAAgYAUxogOiAaDABzOgA6ADoZ2ggAWRoAegAaBgA0CrAKBADwBCkaAA8YOA4AGjkKAHgACjkaAA4OAMEZABkaAD4AGhkQGQoSADQKGRASANIpGjAaKRApCgA_AAopDgDwDCA5OjkwKQowCikwOTo5QJlQmVCZcFmQWZBZQA=="),
		3,16,16,1,0),
	sad = new_gif(unpod("b64:bHo0AKIAAADaAAAA8wVweHUAQyAwEARAWZBZkFlwGVoZUAQAU0AJmgkwBABVIAm6CRAEAFkaAFoAGgwA4gAJGiA6IBoZKiAaICoZDAADBgA0EFoQDAB1KgBaACoZ2ggAhNoZ2ik6MDo5BACyGhA6EBo5KgA6ACoMAOMZAAkQehAJEBkQWhAZEAwAxAAJWgkAGRApAFoAKQ4A8AQguTC5MLlAmVCZUJlwWZBZkFlA"),
		3,16,16,1,0),
	sunglasses = new_gif(unpod("b64:bHo0AA8BAAA5AgAAyXB4dQBDIIAQBEBZkAIAX3AZWhlQBAAIX0AJmgkwBAAIXyAJugkQBAAJ_BBfIBpeEA4GPhoGThAeBi4aDgY_EC4WDhoeFh4QXhpeBAD7DwAJCr4KGQoGXgY_ChkKFk4WLgoZCh4WThYOChkKvgQANU4aTgYAAF4AADMA_wAOFh4aDhYeChkKPgYaPgYmAAEGAFoaLjouGgYA2xYOOhYOGhkaHgY6HgYcAAEGABraAgB-KQoOeg4KOQYAFz8eeh4EAAmPGQAZCn4KGRAGAAE-DloOCAACAB4ArDkOPxgOORA5Dj0GABdeBAAAEgBYIDk_OTAEABG5AgBpOT45QJlQAgATcBcCkJBZkFmQWZBZQA=="),
		8,16,16,2,0)
}
