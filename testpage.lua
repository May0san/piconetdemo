p = {
	title="untitled page ",
	g=create_gui({
		x=0,y=0,
		width=300,height=300,
		fgcol = 0x090d
	}),
	init = function(self,explorer)
		self.untitled9 = self.g:attach_button({
			x=0, y=0, w=50, h=13,
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
		palt(0,false)
		palt(7, true)
		sspr(untitled2, 0, 0, 24,24,8.0,24.0,24,24)
		palt(0,false)
		palt(7, true)
		sspr(untitled3, 0, 0, 24,24,163.0,37.0,24,24)
		print("select \"text\"\nunder \"edit\" ",20.0,56.0,7)
		palt(0,false)
		palt(7, true)
		sspr(untitled5, 0, 0, 24,24,119.0,87.0,24,24)
		rectfill(107.0,32.0,147.0,72.0,8)
		ovalfill(161.0,71.0,201.0,111.0,8)
		print("select \"text\"\nunder \"edit\" ",110.0,68.5,7)
		
		g:draw_all()
	end,
	update = function(self,explorer)
		
	end,
untitled2 = unpod(userdata("u8",24,24,"0707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707202020202020202020200d07070707070707070707070707200707070707070707070d0d070707070707070707070707200706060606060606060d070d0707070707070707070707200706060603030606060d07070d0707070707070707070720070606030b0301060620202020070707070707070707072007060603030301060606060720070707070707070707072007060606010106060606060720070707070707070707072007060606060606101010010720070707070707070707072007060806060606100c10010720070707070707070707072007060e08060606101001010720070707070707070707072007060e0e080606010101010720070707070707070707072007060e0e0e08060606060607200707070707070707070720070601010101060606060607200707070707070707070720070606060606060606060607200707070707070707070720070707070707070707070707200707070707070707070720202020202020202020202020200707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707")),
untitled3 = unpod(userdata("u8",24,24,"0707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707202020202020202020200d07070707070707070707070707200707070707070707070d0d070707070707070707070707200706060606060606060d070d0707070707070707070707200706060603030606060d07070d0707070707070707070720070606030b0301060620202020070707070707070707072007060603030301060606060720070707070707070707072007060606010106060606060720070707070707070707072007060606060606101010010720070707070707070707072007060806060606100c10010720070707070707070707072007060e08060606101001010720070707070707070707072007060e0e080606010101010720070707070707070707072007060e0e0e08060606060607200707070707070707070720070601010101060606060607200707070707070707070720070606060606060606060607200707070707070707070720070707070707070707070707200707070707070707070720202020202020202020202020200707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707")),
untitled5 = unpod(userdata("u8",24,24,"0707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707202020202020202020200d07070707070707070707070707200707070707070707070d0d070707070707070707070707200706060606060606060d070d0707070707070707070707200706060603030606060d07070d0707070707070707070720070606030b0301060620202020070707070707070707072007060603030301060606060720070707070707070707072007060606010106060606060720070707070707070707072007060606060606101010010720070707070707070707072007060806060606100c10010720070707070707070707072007060e08060606101001010720070707070707070707072007060e0e080606010101010720070707070707070707072007060e0e0e08060606060607200707070707070707070720070601010101060606060607200707070707070707070720070606060606060606060607200707070707070707070720070707070707070707070707200707070707070707070720202020202020202020202020200707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707070707"))
}
