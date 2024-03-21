p = {
	title = "GAMES",
	g = create_gui({x=0,y=0,
		width=explorer.current_width,height=300,
		fgcol = 0x090d}),
	init = function(self,explorer)
		self.g:attach_button({x=0,y=230,label="Download 3D Render",
			bgcol=0x0706, fgcol=0x090d,
			tap=function()
				local file = fetch("https://github.com/May0san/piconetdemo/raw/main/amateur_3d.p64.png")
				store("amateur_3d.p64.png",file,{})
			end
		})
		self.g:attach_button({x=2,y=2,label="Go Back",
			bgcol=0x0706, fgcol=0x090d,
			tap=function()
				explorer:open_page("https://raw.githubusercontent.com/May0san/piconetdemo/main/games.lua")
			end
		})
	end,
	get_gui = function(self,explorer)
		return self.g
	end,
	update = function(self,explorer)
		
	end,
	draw = function(self,explorer)
		print("\n\nLOOK IT'S 3D!!!!!")
		print(
		"This one wasn't really a game but it was\n"..
		"really hard to figure out how to make it\n"..
		"work right. I had to use the web browser\n"..
		"a lot!! Well at least it looks\n"..
		"REALLY COOL!!!!!!!!\n\n"..
		"This one is actually made for a PICOTRON!\n"..
		"So you can just go and download it and\n"..
		"play with it right away!! It's really fun\n"..
		"making the things spin all around."..
		"Be careful though!! One time I moved it\n"..
		"offscreen too far and couldn't find it\n"..
		"anymore!! XD\n\n"..
		"DOWNLOAD BUTTON:", 0, 80)
	end
}
