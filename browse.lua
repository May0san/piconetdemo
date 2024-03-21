--[[pod_format="raw",created="2024-03-21 03:18:50",modified="2024-03-21 03:19:41",revision=4]]



--				<div style="margin-left:10px; cursor:pointer"
p = {
	g  = create_gui({x=0,y=0,
		width=300,height=500,
		fgcol = 0x090d}),
	title = "browse",
	sites = {},
	--debug = {},
	init = function(self, explorer)
		--local times_added = 0
		local n = 1
		while true do
			local file = fetch("https://www.lexaloffle.com/bbs/?tid=140960")
--			local list = split(file,"\n")
--			self.debug = list
--			for i=1,#list do
--				if list[i] == "				<div style=\"margin-left:10px; cursor:pointer\"" then
--					for j=i,i+8 do
						--assert(split(list[j]," ") != nil)
						local line = split(file,"^")--local line = split(list[j],")(")
						for k=1,#line do
							if line[k] == "PICOSITE" then
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
--					end
--					i += 8
--				end
--			end
			n+=1
			--if times_added == 0 then
				break
			--end
		end

		self.g.height = (#self.sites*50)+150		local g = self.g
		assert(g!=nil)
		for i = #self.sites,1,-1 do
			g:attach_button({x=5,y=(i*50)+60,label=self.sites[i].title,
				bgcol=0x0706, fgcol=0x090d,
				tap=function()
					explorer:open_page(self.sites[i].link)
				end
			})
		end
	end,
	get_gui = function(self,explorer)
		return self.g
	end,
	draw = function(self,explorer)
		cls(12)
		print("Browse the PICO-Net!", 5, 5, 0)
		for i = #self.sites,1,-1 do
			print(self.sites[i].about, 10, (i * 50) + 75, 0)
		end
		--for i in all(self.debug) do
		--	print(i)
		--end
		--print(#self.debug)
		--print("https://www.lexaloffle.com/bbs/?tid=140960")
	end
}
