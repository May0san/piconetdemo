p = {
	title="untitled page ",
	g=create_gui(
		{x=0,y=0,
		width=300,height=300,
		fgcol = 0x090d}
	),
	init = function(self,explorer)
		self.untitled4 = self.g:attach_button({
			x=27.0, y=92.5, w=50, h=13,
			label="button ",
			click=function()
				
			end
		})
	end,
	get_gui = function(self,explorer)
		return self.g
	end,
	draw = function(self,explorer)
		cls(0)
		print("select \"text\"\nunder \"edit\" ",68.0,59.0,7)
		print("select \"text\"\nunder \"edit\" ",24.0,27.0,7)
		print("select \"text\"\nunder \"edit\" ",110.0,68.5,7)
		
	end,
	update = function(self,explorer)
		
	end
}
