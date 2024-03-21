--[[pod_format="raw",created="2024-03-20 20:41:53",modified="2024-03-21 02:16:41",revision=748]]


p = {
	title = "GAMES",
	g = create_gui({x=0,y=0,
		width=explorer.current_width,height=300,
		fgcol = 0x090d}),
	init = function(self,explorer)
		self.g:attach_button({x=0,y=100,label="Train Journey (PICO-8)",
			bgcol=0x0706, fgcol=0x090d,
			tap=function()
				explorer:open_page("https://raw.githubusercontent.com/May0san/piconetdemo/main/trainjourney.lua")
			end
		})
		self.g:attach_button({x=0,y=120,label="3D Renderer",
			bgcol=0x0706, fgcol=0x090d,
			tap=function()
				--load_page("pages/home.lua")
			end
		})
	end,
	get_gui = function(self,explorer)
		return self.g
	end,
	update = function(self,explorer)
		
	end,
	draw = function(self,explorer)
		print("\n\nWELCOME\n\nto my\n\nCOOL GAMES WEBSITE")
		print("Play my AWESOME games:", 0, 80)
		self.mygif:draw(2,2)
		self.mygif:draw(18,2)
		self.mygif:draw(34,2)
		self.mygif:draw(50,2)
		self.smile:draw(120,74)
	end,
	mygif = new_gif(unpod("b64:bHo0AGIBAADTAwAA8zBweHUAQyhgAQAAEAAAAATw--_1AZ8QYA8gAW8QcBFOkB4hsAEfILARwB0BsCEekE4RcG4BDVCeAUABnlANAW4jAHkeDdAe0A0eIgDwEjABrlANAX5gEV6AHjGgHh2wHsAdHqAxHoBeEWB_AQ1AriIAGEAiAB-AIgAA-wwOeA8YDlANAQ5IDA5gEQ4oDA6AHgEcAaAeAg1RABLxCw0CHqABHAEegA4MKA4RYA4MSA4BDUAOeAwOXQAfDFwA-g_1AS4P_QE1IHEe4wAgQQ3jACAhDeMALx0BTgAYIAEd4QAgDSHhACENQeEAIHEeWAAgYS5YAO8xDR5gEQ4RDR6AHgENEVgAGSANEVgAIBEeWAAgMR5YAHRhLgEwAZ5gDwMXMU4ADzEDAQhOADcxHoAiAJGOcA0BXoARPqBTAxPAUwPioD4RgF4BDWCOAVABjmAiAAGYAyQdwJcDBCIAUAHw--_2"),
		22,16,16,3,0),
	smile = new_gif(unpod("b64:bHo0AM0AAAAFAQAA8wVweHUAQyAwEARAWZBZkFlwGVoZUAQAU0AJmgkwBADVIAkqADoAKgkQCboJEAwA1RogGiAaCRAJCiA6IAoQAOIACSogGiAqGToQGhA6GQwAAgYAUxogOiAaDABzOgA6ADoZ2ggAWRoAegAaBgA0CrAKBADwBCkaAA8YOA4AGjkKAHgACjkaAA4OAMEZABkaAD4AGhkQGQoSADQKGRASANIpGjAaKRApCgA_AAopDgDwDCA5OjkwKQowCikwOTo5QJlQmVCZcFmQWZBZQA=="),
		3,16,16,1,0)
}
