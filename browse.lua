--[[pod_format="raw",created="2024-03-21 03:18:50",modified="2024-03-21 03:19:41",revision=4]]



--				<div style="margin-left:10px; cursor:pointer"
p = {
	g  = create_gui({x=0,y=0,
		width=300,height=500,
		fgcol = 0x090d}),
	title = "browse",
	sites = {},
	init = function(self, explorer)
		
		local n = 1
		while true do
			local times_added = 0
			local file = fetch("https://www.lexaloffle.com/bbs/?page="..n.."&tid=140647")
			
			local list = split(file,"\n")
			for i=1,#list do
				if list[i] == "				<div style=\"margin-left:10px; cursor:pointer\"" then
					for j=i,i+8 do
						--assert(split(list[j]," ") != nil)
						local line = split(list[j]," ")
						for k=1,#line do
							if line[k] == "[PICOSITE]" then
								local l = k+2
								local about = ""
								while line[l] != "[PICOSITE]" or l > #line do
									about = about.." "..line[l]
									l += 1
								end
								add(self.sites,{
									link = line[k+1],
									title = line[k+2],
									about = about
								})
								times_added += 1
								break
							end
						end
					end
					i += 8
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
	end
}
