p = {
	title = "GAMES",
	g = create_gui({x=0,y=0,
		width=explorer.current_width,height=300,
		fgcol = 0x090d}),
	init = function(self,explorer)
		self.g:attach_button({x=0,y=240,label="Download 3D Render",
			tap=function()
				--these two lines dowload a file, but I'm pretty sure you need to have a downloads folder in your root already.
				--I also want to create a function for this in the near future to simplify it down to something like "download(link, [path or downloads folder])"
				download("https://github.com/May0san/piconetdemo/raw/main/amateur_3d.p64.png","amateur_3d.p64.png","/downloads")
			end
		})
		self.g:attach_button({x=2,y=2,label="Go Back",
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
		rect(-1,-1,-1,-1,7)
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
		"making the things spin all around.\n"..
		"Be careful though!! One time I moved it\n"..
		"offscreen too far and couldn't find it\n"..
		"anymore!! XD\n\n"..
		"DOWNLOAD BUTTON:", 0, 50)
	end
}
