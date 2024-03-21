--[[pod_format="raw",created="2024-03-21 02:05:41",modified="2024-03-21 02:16:41",revision=18]]


p = {
	title = "GAMES",
	g = create_gui({x=0,y=0,
		width=explorer.current_width,height=300,
		fgcol = 0x090d}),
	init = function(self,explorer)
		self.g:attach_button({x=0,y=100,label="Download Train Journey",
			bgcol=0x0706, fgcol=0x090d,
			tap=function()
				explorer:open_page("pages/home.lua")
			end
		})
		self.g:attach_button({x=2,y=2,label="Go Back",
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
		print("\n\nTRAIN JOURNEY GAME")
		print("This game is about TRAINS!!!!\n"..
		"I made it in high school, but I'm still working\n"..
		"on a new updae for it lolz.\n\n"..
		"I made it for da PICO-8 console, so you won't\n"..
		"be able to run it on a regular PICOTRON\n"..
		"computer.\n\n"..
		"DOWNLOAD BUTTON:", 50, 80)
	end
}