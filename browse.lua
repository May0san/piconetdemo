--[[pod_format="raw",created="2024-03-21 03:18:50",modified="2024-03-21 03:19:41",revision=4]]



--				<div style="margin-left:10px; cursor:pointer"
p = {
	g  = create_gui({x=0,y=0,
		width=300,height=500,
		fgcol = 0x090d}),
	title = "browse",
	sites = {},
	build_btn,
	--debug = {},
	init = function(self, explorer)
		self.build_btn = self.g:attach_button({x=explorer.current_width-90,y=2,label="build a site!",
			tap=function()
				explorer:open_page("https://raw.githubusercontent.com/May0san/piconetdemo/main/sitebuilder.lua")
			end
		})
		local times_added = 0
		local n = 1
		while true do
			local file = fetchurl("https://www.lexaloffle.com/bbs/?page="..n.."&tid=140960")
			local line = split(file,"^")
			for k=1,#line do
				if line[k] == "PICOSITE" then
					local about_sec = split(line[k+3],"\\n")[1]
					local about = about_sec --""
					--for i in all(about_sec) do
					--	about = about..i.."\n"
					--end
					
					local link_section = split(line[k+1],"\"")
					local actual_link = link_section[2]
					add(self.sites,{
						link = actual_link,
						title = line[k+2],
						about = line[k+3]
					})
					--times_added += 1
				end
			end
			n+=1
			if times_added == 0 then
				break
			end
		end

		self.g.height = (#self.sites*50)+150
		local g = self.g
		assert(g!=nil)
		for i = 1,#self.sites do
			g:attach_button({x=10,y=(i*50)+60,label=self.sites[i].title,
				tap=function()
					explorer:open_page(self.sites[i].link)
				end
			})
		end
	end,
	update = function(self,explorer)
		self.build_btn.x=explorer.current_width-90
		self.build_btn.y=2
	end,
	get_gui = function(self,explorer)
		return self.g
	end,
	draw = function(self,explorer)
		cls(12)
		self.g.width = explorer.current_width
		print("Browse the PICO-Net!", 5, 5, 0)
		for i = 1,#self.sites do
			rectfill(5,(i * 50) + 55, explorer.current_width-5-8, (i * 50) + 90, 28)
			print(self.sites[i].about, 15, (i * 50) + 75, 0)
		end
		
		--for i in all(self.debug) do
		--	print(i)
		--end
		--print(#self.debug)
		--print("https://www.lexaloffle.com/bbs/?tid=140960")
	end
}
