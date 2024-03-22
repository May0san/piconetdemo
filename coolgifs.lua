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
			"on how to make your own (it's easy!)\n\n"..
			"Here you go:", 0,0,7)
		self.spin_cartridge:draw(2,2)-- you only need to specify position when drawing gif
		self.smile:draw(18,2)
	end,
	--gifs use a pod. you can copy it directly from the gfx editor. The format is one frame tall by however many frames you have long
	spin_cartridge = new_gif(unpod("b64:bHo0AGIBAADTAwAA8zBweHUAQyhgAQAAEAAAAATw--_1AZ8QYA8gAW8QcBFOkB4hsAEfILARwB0BsCEekE4RcG4BDVCeAUABnlANAW4jAHkeDdAe0A0eIgDwEjABrlANAX5gEV6AHjGgHh2wHsAdHqAxHoBeEWB_AQ1AriIAGEAiAB-AIgAA-wwOeA8YDlANAQ5IDA5gEQ4oDA6AHgEcAaAeAg1RABLxCw0CHqABHAEegA4MKA4RYA4MSA4BDUAOeAwOXQAfDFwA-g_1AS4P_QE1IHEe4wAgQQ3jACAhDeMALx0BTgAYIAEd4QAgDSHhACENQeEAIHEeWAAgYS5YAO8xDR5gEQ4RDR6AHgENEVgAGSANEVgAIBEeWAAgMR5YAHRhLgEwAZ5gDwMXMU4ADzEDAQhOADcxHoAiAJGOcA0BXoARPqBTAxPAUwPioD4RgF4BDWCOAVABjmAiAAGYAyQdwJcDBCIAUAHw--_2"),
		22,16,16,3,0), -- params (excluding the pod) are: number of frames, frame width, frame height, speed (bigger number = faster), alpha color
	smile = new_gif(unpod("b64:bHo0AM0AAAAFAQAA8wVweHUAQyAwEARAWZBZkFlwGVoZUAQAU0AJmgkwBADVIAkqADoAKgkQCboJEAwA1RogGiAaCRAJCiA6IAoQAOIACSogGiAqGToQGhA6GQwAAgYAUxogOiAaDABzOgA6ADoZ2ggAWRoAegAaBgA0CrAKBADwBCkaAA8YOA4AGjkKAHgACjkaAA4OAMEZABkaAD4AGhkQGQoSADQKGRASANIpGjAaKRApCgA_AAopDgDwDCA5OjkwKQowCikwOTo5QJlQmVCZcFmQWZBZQA=="),
		3,16,16,1,0)
}
