--[[pod_format="raw",created="2024-03-21 02:05:41",modified="2024-03-21 02:16:41",revision=18]]


p = {
	title = "GAMES",
	g = create_gui({x=0,y=0,
		width=explorer.current_width,height=300,
		fgcol = 0x090d}),
	init = function(self,explorer)
		self.g:attach_button({x=0,y=200,label="Download Train Journey",
			tap=function()
				download("https://github.com/May0san/piconetdemo/raw/main/TrainJourney_windows.zip","TrainJourney_windows.zip","/downloads")
			end
		})
		self.g:attach_button({x=0,y=240,label="Download Train Journey",
			tap=function()
				download("https://github.com/May0san/piconetdemo/raw/main/TrainJourney_windows.zip","TrainJourney_windows.zip","/downloads")
			end
		})
		self.g:attach_button({x=2,y=2,label="Go Back",
			tap=function()
				explorer:open_page("https://raw.githubusercontent.com/May0san/piconetdemo/main/games.lua")
			end
		})
		self.g:attach_button({x=0,y=220,label="Download kaiba thing",
			tap=function()
				download("https://raw.githubusercontent.com/May0san/piconetdemo/refs/heads/main/planet_pico-8_version.p8","planet_pico-8_version.p8","/downloads")
			end
		})
	end,
	get_gui = function(self,explorer)
		return self.g
	end,
	update = function(self,explorer)
		
	end,
	draw = function(self,explorer)
		cls()
		rect(-1,-1,-1,-1,7)
		print("\n\nTRAIN JOURNEY GAME")
		print("This game is about TRAINS!!!!\n"..
		"I made it a while ago, but I'm still working\n"..
		"on a new updae for it lolz.\n\n"..
		"I made it for da PICO-8 console, so you won't\n"..
		"be able to run it on a regular PICOTRON\n"..
		"computer.\n\n"..
		"DOWNLOAD BUTTON:", 0, 80)
		self.sad:draw(230,128,16,16,1,0)
	end,
	sad = new_gif("b64:bHo0AKIAAADaAAAA8wVweHUAQyAwEARAWZBZkFlwGVoZUAQAU0AJmgkwBABVIAm6CRAEAFkaAFoAGgwA4gAJGiA6IBoZKiAaICoZDAADBgA0EFoQDAB1KgBaACoZ2ggAhNoZ2ik6MDo5BACyGhA6EBo5KgA6ACoMAOMZAAkQehAJEBkQWhAZEAwAxAAJWgkAGRApAFoAKQ4A8AQguTC5MLlAmVCZUJlwWZBZkFlA",
		3)
}
