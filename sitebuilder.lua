p = {
	title = "sitebuilder (wip)",
	g = create_gui({x=0,y=0,
		width=300,height=200-28+15,
		fgcol = 0x090d}),
	elements = {},
	bgclr = 0,
	custom_code = {
		init = "",
		update = "",
		draw = ""
	},
	toolbar = {
		gui = create_gui({x=0,y=0,
			width=300,height=15,
			fgcol = 0x090d}),
		edit = {
			page = {},
			button = {},
			text = {},
			rectangle = {},
			circle = {},
			image = {},
			gif = {}
		},
		code = {
			init,
			update,
			draw
		},
		file = {
			items = {
				save,
				load,
				export
			}
		},
		new = {
			button,
			pulldown,
			items = {
				button,
				gif,
				custom_gui,
				rectangle,
				circle,
				image,
				text
			}
		}
	},
	selection_gui = create_gui({x=0,y=28 + 15,-- update but don't draw
		width=300,height=200-28,---15,
		fgcol = 0x090d}),
	page_mockup = create_gui({x=0,y=0,-- draw but don't update
		width=300,height=200-28,---15,
		fgcol = 0x090d}),
	selected_gui,
	last_save={t=time(), a=0},
	init = function(self,explorer)
		self:create_element({gui=self.page_mockup, x=0, y=0, w=self.page_mockup.width, h=self.page_mockup.height, name="untitled_page", clr=0})

		self:create_toolbar_menu(explorer)
		self:initialize_editors(explorer)
		
		self.selected_element = 1
	end,
	
	--create_element({gui,x,y,w,h,draw,name,type,clr})
	create_element = function(self, tbl)
		local num = count(self.elements) + 1
		local page = self
		local e = {
			type = tbl.type or "unknown",
			x = tbl.x or 0,
			y = tbl.y or 0,
			w = tbl.w or 0,
			h = tbl.h or 0,
			clr = tbl.clr or 7,
			image = tbl.image,
			image_str = tbl.image_str,
			gui = tbl.gui or create_gui({tbl.x,tbl.y,tbl.w,tbl.h}),
			function_text = "",
			action_text = tbl.action_text or "",
			speed=tbl.speed,
			draw = tbl.draw or function()end,
			name = tbl.name or tbl.type..num,
			num = num,
			frames = tbl.frames or 1,
			delete = function(self, page)
				if self.num != 1 then
					if self.gui.parent then
						self.gui:detach()
					end
					self.selection_btn:detach()
					
					page.elements[self.num] = nil
				end
			end,
			update = function(self)
				if self.num!=1 then
					self.x = min(max(self.x,0),page.selection_gui.width-self.w)
					self.y = min(max(self.y,0),page.selection_gui.height-self.h)
				end
				self.gui.x = self.x
				if self.num == 1 then
					self.gui.y = self.y
				else
					self.gui.y = self.y + 15
				end
				
				self.selection_btn.x = self.x + page.g.x
				self.selection_btn.y = self.y + page.g.y
				self.gui.width = self.w
				self.gui.height = self.h
				self.selection_btn.width = self.w
				self.selection_btn.height = self.h
				
				
			end
		}
		e.selection_btn = self.selection_gui:attach({x=e.x,y=e.y,width=e.w,height=e.h,label="",
			event = function(self, msg)
				if msg.event == "drag" and page.selected_element == num and num != 1 then
					--assert(false)
					local mx, my = mouse()
					mx = max(min(mx, explorer.current_width),0) - page.g.x
					my = max(min(my - (15 + 13 + 15), explorer.current_height),0) - page.g.y
					--assert(false)
					page.elements[page.selected_element].x = mx - (self.width/2)
					page.elements[page.selected_element].y = my - (self.height/2)
				end
				if msg.event == "release" and not self.editing then
					page.selected_element = num
					page.last_save.a+=0.2
				end
				if msg.event == "hover" then
					if num > 1 and page.selected_element == num then
						window{cursor = "grab"}
					else
						window{cursor = "point"}
					end
				end
			end
		})
		
		add(self.elements, e)
		return e
	end,
	get_gui = function(self,explorer)
		return self.g
	end,
	draw = function(self, explorer)
		cls(self.bgclr)--self.elements[1].clr)
				
		camera(0,-15)
		for i in all(self.elements) do
			i:draw()
		end
		camera()
		self.page_mockup:draw_all()
		camera(0,-15)
		self:draw_selection_indicator()
		camera()
		rectfill(0, 0, explorer.current_width, 15, 6)
		print("selected:", explorer.current_width-70, 0, 0)
		print(self.elements[self.selected_element].name, explorer.current_width-70, 8, 0)
		--camera(0,-15)
		
		--camera()
	end,
	draw_selection_indicator = function(self)
		local clr = 28
		if self.bgclr == 28 then
			clr = 8
		end
		local e = self.elements[self.selected_element]
		rect(e.x-1, e.y-1, e.x+e.w, e.y+e.h, 7)
		rect(e.x-2, e.y-2, e.x+e.w+1, e.y+e.h+1, clr)
		
	end,
	update = function(self, explorer)
		self.g.width = self.elements[1].w
		self.selection_gui.width = self.elements[1].w
		self.g.height = self.elements[1].h + 30
		self.selection_gui.height = self.elements[1].h
		if explorer.current_height-28 > self.g.height then
			self.g.x = 0
		end
		if not self.editing then
			self.selection_gui:update_all()
		end		
		for i in all(self.elements) do
			i:update()
		end
		
		if key"ctrl" and not self.editing then
			if keyp"v" then
				self:element_from_data(self:parse_clipboard_data(get_clipboard()))
			elseif keyp"c" and self.selected_element!=1 then
				self:add_to_clipboard(self.elements[self.selected_element])
			end
		end
		
		--autosave frequency is maybe a little to high? idk
		if (time()-self.last_save.t > 300 and self.last_save.a>8) or self.last_save.a>16 then
			self:autosave(explorer)
		end
	end,
	element_from_data = function(self,data)
		local e
		if data.type == "string" then
			e = self:new_text((self.g.width/2)-25,(self.g.height/2)-6,50,25,data.data)
		elseif data.type=="button" then 
			e = self:new_button(data.x or (self.g.width/2)-(data.w/2), data.y or (self.g.height/2)-(data.h/2),data.w,data.h,data.label,data.action)
		elseif data.type=="text" then 
			e = self:new_text(data.x or (self.g.width/2)-(data.w/2),data.y or (self.g.height/2)-(data.h/2),data.w,data.h,data.label, data.clr, data.action)
		elseif data.type=="rect" then 
			e = self:new_rect(data.x or (self.g.width/2)-(data.w/2),data.y or (self.g.height/2)-(data.h/2),data.w,data.h, data.clr, data.imgdata)
		elseif data.type=="circle" then 
			e = self:new_circ(data.x or (self.g.width/2)-(data.w/2),data.y or (self.g.height/2)-(data.h/2),data.w,data.h, data.clr, data.imgdata)
		elseif data.type=="image" then
			local img = unpod(data.imgdata)
			local w = data.w or img:width()
			local h = data.h or img:height()
			e = self:new_image(data.x or (self.g.width/2)-(w/2),data.y or (self.g.height/2)-(h/2),w,h, data.imgdata, data.clr or 0)
		elseif data.type=="gif" then
			local img = data.imgdata
			local w = data.w
			local h = data.h
			e = self:new_gif(data.x or (self.g.width/2)-(w/2),data.y or (self.g.height/2)-(h/2),w,h, data.frames, img, data.speed, data.clr)
		end
		if e then
			e.horiz_justify = data.horiz_justify or -1
			e.vert_justify = data.vert_justify or -1
			e.action_text = data.action_text or ""
			e.function_text = data.function_text or ""
		end
	end,
	data_from_element = function(self,element)
		return {w = element.w, h = element.h, label = element.gui.label, clr=element.clr, type = element.type, func = element.function_text, action = element.action_text, imgdata = element.image_str, frames=element.frames, speed=element.speed}
	end,
	parse_clipboard_data = function(self,str)
		local c = str
		local s = split(c,"(")
		if (#c > 4 and sub(s[1],#s-7)== "unpod") or (sub(c,1,1)=="{" and sub(c,#c,#c)=="}") then
			local h = split(c,"\"")[4]
			local p = unpod(h)
			if sub(c,1,1)=="{" and sub(c,#c,#c)=="}" then
				p=unpod(c)
			end
			
			if type(p) == "userdata" then
				return {type="image", imgdata=h}
			elseif type(p) == "table" and p.type then
				return p
			end
		else
			return {type="string", data=c}
		end
		return {type="unknown",data=c}
	end,
	add_to_clipboard = function(self,element)
		local data = self:data_from_element(element)
		set_clipboard(pod(data))
		notify(data.type.." added to clipboard.")
	end,
	create_toolbar_menu = function(self,explorer)
		local page = self
		local t = self.toolbar
		t.draw = function(self)
			self.x = -page.g.x
			self.y = -page.g.y
		end
		t.gui = create_gui({x=0, y=0, width=explorer.current_width, height = 15, fgcol = 0x90d})
		self.g:attach(t.gui)
		
		self:attach_file_menu(explorer,t)
		self:attach_new_menu(explorer,t)
		self:attach_edit_menu(explorer,t)
	end,
	attach_file_menu = function(self,explorer,t)
		on_event("save_file_as", function(msg)
			if self.filing == "load" then
				local first = self.elements[1]
				self.selection_gui = create_gui({x=0,y=28 + 15,
					width=300,height=200-28,
					fgcol = 0x090d})
				self.page_mockup = create_gui({x=0,y=0,
					width=300,height=200-28,
					fgcol = 0x090d})
				self.elements = {}
				self:create_element({gui=self.page_mockup, x=0, y=0, w=self.page_mockup.width, h=self.page_mockup.height, name="untitled_page", clr=0})
				
				self.selected_element=1
				assert(msg.filename, pod(msg))
				local podtable = unpod(fetch(msg.filename))
				for e in all(podtable) do
					local un = unpod(e)
					if un.bgclr then
						self.bgclr = un.bgclr
						self.custom_code.init = un.init
						self.custom_code.update = un.update
						self.custom_code.draw = un.draw
						self.elements[1].name = un.name
						self.elements[1].w = un.w or self.elements[1].w
						self.elements[1].h = un.h or self.elements[1].h
					else
						self:element_from_data(un)
					end
				end
			elseif self.filing == "savepod" then
				local podsite = self:podify_site(explorer)
				if sub(msg.filename,#msg.filename-3) == ".pod" then
					store(msg.filename,podsite)
				else
					store(msg.filename..".pod",podsite)
				end
				self.last_save = {t=time(), a=0}
			elseif self.filing == "savelua" then
				local site = self:convert_to_code()
				if sub(msg.filename,#msg.filename-3) == ".lua" then
					store(msg.filename,site)
				else
					store(msg.filename..".lua",site)
				end
			end
		end)
		local f = t.file
		f.button = t.gui:attach_button({x=1,y=2,z=50,label="file",
			click=function()
				f.pulldown = self.g:attach_pulldown({x = -1, y = -2, width = 80})
				f.pulldown:attach_pulldown_item({label = "file",action = function()end})
				f.items.save = f.pulldown:attach_pulldown_item({
					label = "save .pod",
					action = function()
						self.filing = "savepod"
						create_process("/system/apps/filenav.p64", {
							path="/downloads",
							intention="save_file_as",
							window_attribs={workspace = "current", autoclose=true},
						})
						
					end
				})
				f.items.load = f.pulldown:attach_pulldown_item({
					label = "load .pod",
					action = function()
						self.filing = "load"
						create_process("/system/apps/filenav.p64", {
							path="/downloads",
							intention="save_file_as",
							window_attribs={workspace = "current", autoclose=true},
						})
						
					end
				})
				f.items.export = f.pulldown:attach_pulldown_item({
					label = "export .lua",
					action = function()
						self.filing = "savelua"
						create_process("/system/apps/filenav.p64", {
							path="/downloads",
							intention="save_file_as",
							window_attribs={workspace = "current", autoclose=true},
						})
					end
				})
			end
		})
	end,
	podify_site = function(self,explorer)
		local podded = {}
		for e in all(self.elements) do
			local d = {}
			if e.num == 1 then
				d = {
					bgclr = self.bgclr,
					init = self.custom_code.init,
					update = self.custom_code.update,
					draw = self.custom_code.draw,
					name = e.name,
					w = e.w,
					h = e.h
				}
			else
				d = self:data_from_element(e)
				d.x = e.x
				d.y = e.y
				d.horiz_justifyn = e.horiz_justify
				d.vert_justify = e.vert_justify
				d.action_text = e.action_text
				d.function_text = e.function_text
			end
			add(podded,pod(d))
		end
		return pod(podded)
	end,
	autosave = function(self, explorer)
		
		mkdir("/appdata/sitebuilder")
		mkdir("/appdata/sitebuilder/autosaves")
		--cd("/appdata/sitebuilder/autosaves")
		--local autosaves = ls()
		--if count(autosaves) > 10 then--number of autosaves at a given time
		--	for i = 1,#autosaves-10 do
		--		--delete (idk how so I guess it won't)
		--	end
		--end
		local podsite = self:podify_site(explorer)
		--cd("/")
		local date_as_str = table.concat(split(table.concat(split(date()," "),"-"),":"),"-")
		store("/appdata/sitebuilder/autosaves/autosave"..date_as_str..".pod", podsite, {})
		--save as "autosave" with date and time appended (split and concat with dashes)
		self.last_save = {t=time(),a=0}--last time() and number of actions since last autosave
		notify("autosaving to /appdata/sitebuilder/autosaves...".." "..date_as_str)
	end,
	attach_edit_menu = function(self,explorer,t)
		local n = t.new
		n.button = t.gui:attach_button({x=58,y=2,z=50,label="edit",
			click=function()
				if not self.editing then
					local editor = self.g:attach(self.toolbar.edit.editor)
					self.editing = true
					local ed = self.toolbar.edit
					if self.selected_element == 1 then
						ed.page.page_editor:open(self,explorer)
					else
						local t = self.elements[self.selected_element].type
						if t == "button" then
							ed.button.button_editor:open(self,explorer)
						elseif t == "text" then
							ed.text.text_editor:open(self,explorer)
						elseif t == "rect" then
							ed.rectangle.rect_editor:open(self,explorer)
						elseif t == "circle" then
							ed.rectangle.rect_editor:open(self,explorer)
						elseif t == "image" then
							ed.image.image_editor:open(self,explorer)
						elseif t == "gif" then
							ed.gif.gif_editor:open(self,explorer)
						end
					end
				end
			end
		})
	end,
	initialize_editors = function(self, explorer)
		local page = self
		local ed = self.toolbar.edit
		ed.editor = create_gui({
			x=(explorer.current_width/2)-77, y=(explorer.current_height/2)-67, width=154, height=134,
			justify = "top", vjustify = "left",
			draw=function(self)
				self.y = min(((explorer.current_height/2)-67)-page.g.y,page.g.height-134)
				self.x = min(((explorer.current_width/2)-77)-page.g.x,page.g.width-154)
				rectfill(0,0,self.width,self.height,13)
				rectfill(2,2,self.width-4,self.height-4,12)
				local el = page.elements[page.selected_element]
				print(el.name,(self.width/2)-(page.get_print_size(el.name)/2),7,1)
			end
		})
		ed.delete = ed.editor:attach_button({
			x=2,y=2,label = "delete",
			click = function(self)
				if self.label == "delete" and page.selected_element!=1 then
					self.label = "really??"
				elseif self.label == "really??" then
					page.elements[page.selected_element]:delete(page)
					page.selected_element=1
					local ed = page.toolbar.edit
					ed.current_editor:detach()
					page.editing = false
					ed.editor:detach()
					self.label = "delete"
				elseif self.label == "can't delete page silly goober" then
					self.label = "delete"
					self.width = 40
				elseif page.selected_element==1 then
					self.label = "can't delete page silly goober"
					self.width = page.get_print_size(self.label)
				end
				page.last_save.a+=1
			end
		})
		
	
		
		--page editor
		ed.page.page_editor = create_gui({
			x=5, y=20, width=142, height=108,
			open = function(self,page,explorer)
				ed.current_editor = ed.editor:attach(self)
				ed.page.tabname:set_text(page.elements[1].name)
				ed.page.width.default = page.elements[1].w
				ed.page.height.default = page.elements[1].h
				ed.page.color.default = page.bgclr
			end,
			apply_changes=function(page,explorer)
				page.elements[1].name = ((ed.page.tabname:get_text()[1]!="") and ed.page.tabname:get_text()[1]) or page.elements[1].name
				page.elements[1].w = mid(500,tonum(ed.page.width.current_val or page.elements[1].w),200)
				page.elements[1].h = mid(1000,tonum(ed.page.height.current_val or page.elements[1].h),100)
				page.bgclr = tonum(ed.page.color.current_val or page.bgclr)
				
				ed.page.width.current_val = nil
				ed.page.height.current_val = nil
				ed.page.color.current_val = nil
			end,
			draw = function(self)
				rectfill(0,0,self.width,self.height,13)
			end,
			
		})
		local pgtr = ed.page.page_editor:attach(create_gui({x=0, y=0, width=142, height=108,
			draw = function(self)
				print("tab title:",10,4,1)
				print("width, height:",10,30,1)
				print("color:",10,54,1)
			end
		}))
		ed.page.page_editor:attach_scrollbars({autohide=true})--scrollbars are so finnicky
		
		page:put_close_btns(pgtr)
		ed.page.tabname = pgtr:attach_text_editor({
			x=10,y=15,width=120-8,height=11,
			click = function(self)
				ed.page.tabname:set_keyboard_focus(true)
			end
		})
		ed.page.width = self:put_field(pgtr, 10, 41, page.elements[1].w)
		ed.page.height =  self:put_field(pgtr, 40, 41, page.elements[1].h)
		ed.page.color = self:put_field(pgtr, 10, 65, page.bgclr)
		
	

		--button editor
		ed.button.button_editor = create_gui({
			x=5, y=20, width=142, height=108,
			open = function(self,page,explorer)
				ed.current_editor = ed.editor:attach(self)
				local e = page.elements[page.selected_element]
				ed.button.label:set_text(e.gui.label)
				ed.button.width.default = e.w
				ed.button.height.default = e.h
				ed.button.x.default = e.x
				ed.button.y.default = e.y
				ed.button.action:set_text(e.action_text)
			end,
			apply_changes=function(page,explorer)
				local e = page.elements[page.selected_element]
				local txt = table.concat(ed.button.label:get_text(), "\n")
				e.gui.label = ((txt!="") and txt) or e.gui.label
				e.w = mid(300,tonum(ed.button.width.current_val or e.w),10)
				e.h = mid(200,tonum(ed.button.height.current_val or e.h),10)
				e.x = mid(300,tonum(ed.button.x.current_val or e.x),0)
				e.y = mid(200,tonum(ed.button.y.current_val or e.y),0)
				local code = table.concat(ed.button.action:get_text(), "\n")
				e.action_text = ((code!="") and code) or e.action_text
				
				ed.button.width.current_val = nil
				ed.button.height.current_val = nil
				ed.button.x.current_val = nil
				ed.button.y.current_val = nil
			end,
			draw = function(self)
				rectfill(0,0,self.width,self.height,13)
			end,
			
		})
		local bttr = ed.button.button_editor:attach(create_gui({x=0, y=0, width=142, height=238,
			draw = function(self)
				print("label:",10,4,1)
				print("x, y positions:",10,30,1)
				print("width, height:",10,54,1)
				--print("color:",10,70,1)
				print("button pushed code:",10,80,1)
				print("presets:", 15, 100, 6)
			end
		}))
		ed.button.button_editor:attach_scrollbars({autohide=true})
		
		page:put_close_btns(bttr)
		ed.button.label = bttr:attach_text_editor({
			x=10,y=15,width=120-8,height=11,
			click = function(self)
				ed.button.label:set_keyboard_focus(true)
			end
		})
		ed.button.width = self:put_field(bttr, 10, 65, 13)
		ed.button.height =  self:put_field(bttr, 40, 65, 42)
		ed.button.x = self:put_field(bttr, 10, 41, (self.g.width/2)-21)
		ed.button.y = self:put_field(bttr, 40, 41, (self.g.height/2)-7)
		ed.button.auto_width = bttr:attach_button({
			x=70,y=63, label="auto width",
			click = function()
				ed.button.width:set(page.get_print_size(ed.button.label:get_text()[1] or e.gui.label) + 12)
			end
		})
		ed.button.action = bttr:attach_text_editor({
			x=10,y=122,width=120-8,height=100,markup=true,syntax_highlighting=true,
			click = function(self)
				ed.button.action:set_keyboard_focus(true)
			end
		})
		ed.button.action:attach_scrollbars({autohide=true})
		ed.button.preset1 = bttr:attach_button({
			x=55,y=90, label="download file",
			click = function()
				ed.button.action:set_text(
					"download(\"https://courses.cs.washington.edu/courses/cse163/20wi/files/lectures/L04/bee-movie.txt\")"
				)
			end
		})
		ed.button.preset2 = bttr:attach_button({
			x=55,y=106, label="visit page",
			click = function()
				ed.button.action:set_text(
					"explorer:open_page(\"https://raw.githubusercontent.com/May0san/piconetdemo/main/testpage.lua\")"
				)
			end
		})
		
		
		
		
		--text editor
		ed.text.text_editor = create_gui({
			x=5, y=20, width=142, height=108,
			open = function(self,page,explorer)
				ed.current_editor = ed.editor:attach(self)
				local e = page.elements[page.selected_element]
				ed.text.content:set_text(e.image_str)
				ed.text.width.default = e.w
				ed.text.color.default = e.clr
				ed.text.x.default = e.x
				ed.text.y.default = e.y
			end,
			apply_changes=function(page,explorer)
				local e = page.elements[page.selected_element]
				local txt = table.concat(ed.text.content:get_text(),"\n")
				e.image_str = ((txt!="") and txt) or e.image_str
				e.w = mid(300,tonum(ed.text.width.current_val or e.w),10)
				e.x = tonum(ed.text.x.current_val) or e.x
				e.y = tonum(ed.text.y.current_val) or e.y
				e.clr = tonum(ed.text.color.current_val) or e.clr
				
				e.gui.label = page:squash_text(e.image_str, e.w)
				
				ed.text.width.current_val = nil
				ed.text.color.current_val = nil
				ed.text.x.current_val = nil
				ed.text.y.current_val = nil
			end,
			draw = function(self)
				rectfill(0,0,self.width,self.height,13)
			end
			
		})
		local txtr = ed.text.text_editor:attach(create_gui({x=0, y=0, width=142, height=238,
			draw = function(self)
				print("x, y positions:",10,4,1)
				print("width:",10,30,1)
				print("color:",10,56,1)
				print("font pod: (coming soon!)",10,82,1)
				print("text:", 10, 108, 1)
			end
		}))
		ed.text.text_editor:attach_scrollbars({autohide=true})
		
		page:put_close_btns(txtr)
		ed.text.width = self:put_field(txtr, 10, 42, 80)
		ed.text.color = self:put_field(txtr, 10, 68, 7)
		ed.text.x = self:put_field(txtr, 10, 16, (self.g.width/2)-40)
		ed.text.y = self:put_field(txtr, 40, 16, (self.g.height/2)-25)
		ed.text.content = txtr:attach_text_editor({
			x=10,y=122,width=120-8,height=100,
			click = function(self)
				ed.text.content:set_keyboard_focus(true)
			end
		})
		ed.text.content:attach_scrollbars({autohide=true})
		
		
		
		
		--rect editor
		ed.rectangle.rect_editor = create_gui({
			x=5, y=20, width=142, height=108,
			open = function(self,page,explorer)
				ed.current_editor = ed.editor:attach(self)
				local e = page.elements[page.selected_element]
				ed.rectangle.width.default = e.w
				ed.rectangle.height.default = e.h
				ed.rectangle.x.default = e.x
				ed.rectangle.y.default = e.y
				ed.rectangle.color.default = e.clr
				ed.rectangle.filled.label = (e.image_str and "filled") or "outline"
			end,
			apply_changes=function(page,explorer)
				local e = page.elements[page.selected_element]
				e.image_str = ed.rectangle.filled.label == "filled"
				e.w = mid(500,tonum(ed.rectangle.width.current_val or e.w),1)
				e.h = mid(500,tonum(ed.rectangle.height.current_val or e.h),1)
				e.x = tonum(ed.rectangle.x.current_val) or e.x
				e.y = tonum(ed.rectangle.y.current_val) or e.y
				e.clr = tonum(ed.rectangle.color.current_val) or e.clr
				
				ed.rectangle.width.current_val = nil
				ed.rectangle.height.current_val = nil
				ed.rectangle.color.current_val = nil
				ed.rectangle.x.current_val = nil
				ed.rectangle.y.current_val = nil
			end,
			draw = function(self)
				rectfill(0,0,self.width,self.height,13)
			end
			
		})
		local rctr = ed.rectangle.rect_editor:attach(create_gui({x=0, y=0, width=142, height=108,
			draw = function(self)
				print("x, y positions:",10,4,1)
				print("width, height:",10,30,1)
				print("color:",10,56,1)
				print("filled",10,82,1)
			end
		}))
		ed.rectangle.rect_editor:attach_scrollbars({autohide=true})
		
		page:put_close_btns(rctr)
		ed.rectangle.width = self:put_field(rctr, 10, 42, 80)
		ed.rectangle.height = self:put_field(rctr, 40, 42, 80)
		ed.rectangle.color = self:put_field(rctr, 10, 68, 7)
		ed.rectangle.x = self:put_field(rctr, 10, 16, (self.g.width/2)-40)
		ed.rectangle.y = self:put_field(rctr, 40, 16, (self.g.height/2)-25)
		ed.rectangle.filled = rctr:attach_button({
			x=10,y=80,label = "filled",
			click = function(self)
				if self.label=="filled" then
					self.label = "outline"
				else
					self.label = "filled"
				end
			end
		})
		
	


		--image editor
		ed.image.image_editor = create_gui({
			x=5, y=20, width=142, height=108,
			open = function(self,page,explorer)
				ed.current_editor = ed.editor:attach(self)
				local e = page.elements[page.selected_element]
				ed.image.width.default = e.w
				ed.image.height.default = e.h
				ed.image.x.default = e.x
				ed.image.y.default = e.y
				ed.image.alpha.default = e.clr
				ed.image.import:set_text(e.image_str)
			end,
			apply_changes=function(page,explorer)
				local e = page.elements[page.selected_element]
				local text = ed.image.import:get_text()[1]
				local paste = page:parse_clipboard_data(text)
				if paste.type != "image" then
					if	unpod(text) and type(unpod(text)) == "userdata" then
						e.image_str = text
					else
						e.image_str = e.image_str
						notify("failed to import image data")
					end
				else
					e.image_str = paste.imgdata
				end 
				e.image = unpod(e.image_str)
				e.w = mid(500,tonum(ed.image.width.current_val or e.w),1)
				e.h = mid(500,tonum(ed.image.height.current_val or e.h),1)
				e.x = tonum(ed.image.x.current_val) or e.x
				e.y = tonum(ed.image.y.current_val) or e.y
				e.clr = tonum(ed.image.alpha.current_val) or e.clr
				
				ed.image.width.current_val = nil
				ed.image.height.current_val = nil
				ed.image.alpha.current_val = nil
				ed.image.x.current_val = nil
				ed.image.y.current_val = nil
			end,
			draw = function(self)
				rectfill(0,0,self.width,self.height,13)
			end
			
		})
		local imtr = ed.image.image_editor:attach(create_gui({x=0, y=0, width=142, height=183,
			draw = function(self)
				print("x, y positions:",10,4,1)
				print("width, height:",10,30,1)
				print("alpha color:",10,56,1)
				print("paste image data:\n - paste from gfx editor\n - paste raw pod",10,82,1)
			end
		}))
		ed.image.image_editor:attach_scrollbars({autohide=true})
		
		page:put_close_btns(imtr)
		ed.image.width = self:put_field(imtr, 10, 42, 80)
		ed.image.height = self:put_field(imtr, 40, 42, 80)
		ed.image.alpha = self:put_field(imtr, 10, 68, 7)
		ed.image.x = self:put_field(imtr, 10, 16, (self.g.width/2)-40)
		ed.image.y = self:put_field(imtr, 40, 16, (self.g.height/2)-25)
		ed.image.import = imtr:attach_text_editor({
			x=10, y=117, width = 120-8, height=50, embed_pods=true,
			click = function(self)
				ed.image.import:set_keyboard_focus(true)
			end
		})
		
		
		
		
		--gif editor
		ed.gif.gif_editor = create_gui({
			x=5, y=20, width=142, height=108,
			open = function(self,page,explorer)
				ed.current_editor = ed.editor:attach(self)
				local e = page.elements[page.selected_element]
				ed.gif.width.default = e.w
				ed.gif.height.default = e.h
				ed.gif.x.default = e.x
				ed.gif.y.default = e.y
				ed.gif.alpha.default = e.clr
				ed.gif.frames.default = e.frames
				ed.gif.speed.default = e.speed
				ed.gif.import:set_text(e.image_str)
			end,
			apply_changes=function(page,explorer)
				local e = page.elements[page.selected_element]
				local text = ed.gif.import:get_text()[1]
				local paste = page:parse_clipboard_data(text)
				if paste.type != "image" then
					if	unpod(text) and (type(unpod(text)) == "userdata") then
						e.image_str = text
					else
						e.image_str = e.image_str
						notify("failed to import gif frame data")
					end
				else
					e.image_str = paste.imgdata
				end 
				
				e.w = mid(500,tonum(ed.gif.width.current_val or e.w),1)
				e.h = mid(500,tonum(ed.gif.height.current_val or e.h),1)
				e.x = tonum(ed.gif.x.current_val) or e.x
				e.y = tonum(ed.gif.y.current_val) or e.y
				e.clr = tonum(ed.gif.alpha.current_val) or e.clr
				e.frames = tonum(ed.gif.frames.current_val) or e.frames
				e.speed = tonum(ed.gif.speed.current_val) or e.speed
				e.image = new_gif(e.image_str,e.frames)
				
				ed.gif.width.current_val = nil
				ed.gif.height.current_val = nil
				ed.gif.alpha.current_val = nil
				ed.gif.x.current_val = nil
				ed.gif.y.current_val = nil
				ed.gif.speed.current_val = nil
				ed.gif.frames.current_val = nil
			end,
			draw = function(self)
				rectfill(0,0,self.width,self.height,13)
			end
			
		})
		local gftr = ed.gif.gif_editor:attach(create_gui({x=0, y=0, width=142, height=248,
			draw = function(self)
				print("x, y positions:",10,4,1)
				print("width, height:",10,30,1)
				print("alpha color:",10,56,1)
				print("number of frames:",10,82,1)
				print("speed:",10,108,1)
				print("paste frames as\nimage data:\n - paste from gfx editor\n - paste raw pod",10,134,1)
			end
		}))
		ed.gif.gif_editor:attach_scrollbars({autohide=true})
		
		page:put_close_btns(gftr)
		ed.gif.width = self:put_field(gftr, 10, 42, 80)
		ed.gif.height = self:put_field(gftr, 40, 42, 80)
		ed.gif.alpha = self:put_field(gftr, 10, 68, 7)
		ed.gif.x = self:put_field(gftr, 10, 16, (self.g.width/2)-40)
		ed.gif.y = self:put_field(gftr, 40, 16, (self.g.height/2)-25)
		ed.gif.frames = self:put_field(gftr, 10, 94, 12)
		ed.gif.speed = self:put_field(gftr, 10, 120, 1)
		ed.gif.import = gftr:attach_text_editor({
			x=10, y=180, width = 120-8, height=50, embed_pods=true,
			click = function(self)
				ed.gif.import:set_keyboard_focus(true)
			end
		})
	end,
	
	put_field = function(page,gui,x,y,default)
		return gui:attach_field({
			x=x,y=y,width=25,height=9,default=default,
			get = function(self)
				return self.current_val or self.default
			end,
			current_val,
			set = function(self,val)
				self.current_val = tonum(val)
			end
		})
	end,
	put_close_btns = function(page,gui)
		gui:attach_button({
			x=-49, y=0, vjustify = "bottom", justify = "right", label="apply",
			width = 40,
			click=function()
				local ed = page.toolbar.edit
				ed.current_editor.apply_changes(page,explorer)
				ed.current_editor:detach()
				page.editing = false
				ed.editor:detach()
				ed.delete.label = "delete"
				ed.delete.width = 40
				page.last_save.a+=1
			end
		})
		gui:attach_button({
			x=-8, y=0, vjustify = "bottom", justify = "right", label="cancel",
			click=function()
				local ed = page.toolbar.edit
				ed.current_editor:detach()
				page.editing = false
				ed.editor:detach()
				ed.delete.label = "delete"
				ed.delete.width = 40
			end
		})
	end,
	squash_text = function(page,text,width)
		local px,py = page.get_print_size(text)
		if px>width then
			local new = ""
			local ps = split(text," ")
			local i = 1
			while i<=#ps do
				local ix,iy = page.get_print_size(ps[i])
				if  ix > width then
					local subbed = ""
					while true do
						local test = subbed..sub(ps[i],1,1)
						local tx,ty = page.get_print_size(test)
						
						if tx > width then
							break
						end
						subbed = subbed..sub(ps[i],1,1)
						ps[i] = sub(ps[i],2,#ps[i])
					end
					new = new..subbed.."\n"
				else
					local cat = ps[i]
					while i<#ps do
						local test = cat.." "..ps[i+1]
						local tx,ty = page.get_print_size(test)
						
						if tx > width then
							break
						end
						cat = cat.." "..ps[i+1]
						i+=1
					end
					i+=1
					new = new..cat.."\n"
				end
			end
			return new
			
		else
			return text
		end
	end,
	attach_new_menu = function(self,explorer,t)
		local n = t.new
		n.button = t.gui:attach_button({x=32,y=2,z=50,label="new",
			click=function()
				n.pulldown = self.g:attach_pulldown({x = 30, y = -2, width = 80})
				n.pulldown:attach_pulldown_item({label = "new",action = function()end})
				n.items.button = n.pulldown:attach_pulldown_item({
					label = "button",
					action = function()
						self:new_button(((explorer.current_width/2)-self.g.x)-21,((explorer.current_height/2)-self.g.y)-7,42,13,"button")
					end
				})
				n.items.button = n.pulldown:attach_pulldown_item({
					label = "text",
					action = function()
						self:new_text(((explorer.current_width/2)-self.g.x)-21 - 40,((explorer.current_height/2)-self.g.y)-25,80,50,"select \"text\"\nunder \"edit\"", 7)
					end
				})
				n.items.rectangle = n.pulldown:attach_pulldown_item({
					label = "rectangle",
					action = function()
						self:new_rect(((explorer.current_width/2)-self.g.x)-21 - 20,((explorer.current_height/2)-self.g.y)-20,40,40,8,true)
					end
				})
				n.items.circle = n.pulldown:attach_pulldown_item({
					label = "circle",
					action = function()
						self:new_circ(((explorer.current_width/2)-self.g.x)-21 - 20,((explorer.current_height/2)-self.g.y)-20,40,40,8,true)
					end
				})
				n.items.image = n.pulldown:attach_pulldown_item({
					label = "image",
					action = function()
						self:new_image(((explorer.current_width/2)-self.g.x)-21 - 12,((explorer.current_height/2)-self.g.y)-12,24,24,"b64:bHo0AHUAAACIAAAA8B1weHUAQyAYGAT3VZ8gDccOhx23Dgd2DQcNpw4HJhMmDRcNlw4HFgMLAwEWPgoAsSMBNgcOlw4HJhFGCABBVi8QAQkAcwYINgwPDAwNAGIPDggmHBEMAEIaCBYxCgAiKgg1ACIGMQgAsJYHDpcOtw6X3vdV",0)
					end
				})
				n.items.image = n.pulldown:attach_pulldown_item({
					label = "gif",
					action = function()
						self:new_gif(((explorer.current_width/2)-self.g.x)-21 - 8,((explorer.current_height/2)-self.g.y)-8,16,16,12,"b64:bHo0ALcBAAAQAwAA-AJweHUAQyDAEATwtD8WsE7ALgIA-wCgTpAOLw8ekA4tLqAOHR4EAA3-BYAOLS5wLi0OkB4tHpAeLQ4NgC4dBQAOACgA-wVwHi0ecH6AfoBugA4fIA4cDoAOHAYAD7ducH5gBR4cDhyAHhYADwYAHBFwPACAcAUOHA0MDYAHAAUgAD8uDC4EAAYVDjYAAAcAgS4MDqAuDB6QHgAfCQQACAE_AP8EHpAFLgmgBR4JDrAeCQ4FoB4JCgUADzEOBZAyAP8EFQ0ACQqQFQ0JCrAFDQrABQ0ZsAQAByAKsCkA8gTgDxkZCqALDQkNoA0ZsA0OGgmgBQBGCgkPFAwAFAgLAHAOGgmwDRnQMQDxBtANCQ0JGoAdGRpgDQ4JKpANChgJoAUAWwoJKAmQCgACBQDyEw4JKsAdGRqgDg0JCgQJgA4ZCgQJYA0OCggECZANCQgECaAGAG4KGAQLCZAMAAMGAAExABHAPgCCoA4LCgQLCoAHALBgDQAJBAsKkA0psAMAWQkICwmgCQAiKbAiABLAMAD1BqANACmQDQApcA0AKaAN4A3gDQAZsAYAwOANACnQDQApsA3wpQ==",1,0)
					end
				})
			end
		})
	end,
	new_text = function(self,x,y,w,h,text,clr,font)
		local page = self
		self:create_element({
			type="text",
			gui=self.page_mockup:attach({
				type = "text", x = x, y = y, width = w, height = h, label = text
			}),
			x=x, y=y, w=w, h=h, clr=clr, image_str=text, action_text=font,
			draw=function(self)--todo: change fetch to fetchurl
				
				print(self.gui.label, self.x+2, self.y+3, self.clr)
			end
		})
	end,
	get_print_size = function(str)
		local ww, hh = print(tostr(str), -10000, -10000)
		ww += 10000
		hh += 10000
		return ww, hh
	end,
	new_button = function(self,x,y,w,h,label,action_text)
		self:create_element({
			type="button",
			gui=self.page_mockup:attach_button({
				type = "button", x = x, y = y, width = w, height = h, label = label, click = function()end
			}),
			x=x, y=y, w=w, h=h, action_text = action_text or ""
		})
	end,
	new_rect = function(self,x,y,w,h,clr,filled)
		self:create_element({
			type="rect",
			gui=create_gui({x,y,w,h}),
			x=x, y=y, w=w, h=h, clr=clr, image_str=filled,
			draw=function(self)
				if self.image_str then
					rectfill(self.x, self.y, self.x+self.w, self.y+self.h, self.clr)
				else
					rect(self.x, self.y, self.x+self.w, self.y+self.h, self.clr)
				end
			end
		})
	end,
	new_circ = function(self,x,y,w,h,clr,filled)
		self:create_element({
			type="circle",
			gui=create_gui({x,y,w,h}),
			x=x, y=y, w=w, h=h, clr=clr, image_str=filled,
			draw=function(self)
				if self.image_str then
					ovalfill(self.x, self.y, self.x+self.w, self.y+self.h, self.clr)
				else
					oval(self.x, self.y, self.x+self.w, self.y+self.h, self.clr)
				end
			end
		})
	end,
	new_image = function(self,x,y,w,h,image,alpha)
		self:create_element({
			type="image",
			gui=create_gui({x,y,w,h}),
			x=x, y=y, w=w, h=h, clr=alpha, image_str=image, image=unpod(image),
			draw=function(self)
				palt(0,false)
				palt(self.clr, true)
				sspr(self.image,0,0,self.image:width(),self.image:height(),self.x,self.y,self.w,self.h)
				palt()
				pal()
			end
		})
	end,
	new_gif = function(self,x,y,w,h,frames,image,speed,alpha)
		self:create_element({
			type="gif",
			gui=create_gui({x,y,w,h}),
			x=x, y=y, w=w, h=h, frames=frames, speed=speed, clr=alpha, image_str=image, image=new_gif(image, frames),
			draw=function(self)
				self.image:draw(self.x,self.y,self.w,self.h,self.speed,self.clr)
			end
		})
	end,
	convert_to_code = function(self)
		local images = {}
		local as_exportable_string = self.as_exportable_string
		local string =
			"--[["..
			"	Thanks for using PicoNet Sitebuilder! I look forward\n"..
			"	to seeing your picosite! In order to make this available\n"..
			"	on PicoNet Explorer, you'll need to upload this lua file\n"..
			"	somewhere on the internet that you can get a link to it.\n"..
			"	Then, you'll want to go to the following thread:\n"..
			"	\n"..
			"		https://www.lexaloffle.com/bbs/?tid=140960\n"..
			"	\n"..
			"	and post your link based on the format provided there.\n"..
			"	it's  very possible that this format could change slightly\n"..
			"	and so I will not be listing that here just yet.\n"..
			"]]\n"..
			"\n"..
			"	p = {\n"..
			"	title=\""..as_exportable_string(self.elements[1].name).." \",\n"..
			"	g=create_gui({\n"..
			"		x=0,y=0,\n"..
			"		width="..self.elements[1].gui.width..",height="..self.elements[1].gui.width..",\n"..
			"		fgcol = 0x090d\n"..
			"	}),\n"..
			"	copybuttons = {},\n"..
			"	init = function(self,explorer)\n"..
			"		local page = self\n"
		for i in all(self.elements) do
			if i and i != self.elements[1] then	
				if i.type == "button" then
					string = string..
						"		self."..as_exportable_string(i.name).." = self.g:"..
						"attach_button({\n"..
						"			x="..i.x..", y="..i.y..", width="..i.w..", height="..i.h..",\n"..
						"			label=\""..as_exportable_string(i.gui.label).." \",\n"..
						"			click=function()\n"..
						"				"..i.action_text.."\n"..
						"			end\n"..
						"		})\n"					
				elseif i.type == "gif" then
					local name = i.name
					for j in all(self.elements) do
						if j.image_str==i.image_str then
							name = j.name
							add(images,{type="gifraw",name=name.."_gif_raw",image=i.image_str,frames=i.frames})
							break
						end
					end
					string = string..
						"		add(self.copybuttons,self.g:attach({\n"..
						"			x="..i.x..", y="..i.y..", width="..i.w..", height="..i.w..",\n"..
						"			event = function(self,msg)\n"..
						"				if(msg.event == \"release\") then\n"..
						"					set_clipboard(pod({type=\"gif\", w="..i.w..", h="..i.h..", frames="..i.frames..", speed="..i.speed..", clr="..i.clr..", imgdata=page."..name.."_gif_raw".."}))\n"..
						"					notify(\"gif added to clipboard\")\n"..
						"				end\n"..
						"			end\n"..
						"		}))\n"
				elseif i.type == "image" then
					local name = i.name
					for j in all(self.elements) do
						if j.image_str==i.image_str then
							name = j.name
							break
						end
					end
					string = string..
						"		add(self.copybuttons, self.g:attach({\n"..
						"			x="..i.x..", y="..i.y..", width="..i.w..", height="..i.w..",\n"..
						"			event = function(self,msg)\n"..
						"				if(msg.event == \"release\") then\n"..
						"					set_clipboard(\"--[[pod,pod_type=\\\"image\\\"]]unpod(\\\"\"..page."..name.."_raw..\"\\\")\")\n"..
						"					notify(\"image userdata added to clipboard\")\n"..
						"				end\n"..
						"			end\n"..
						"		}))\n"
				end
			end
		end
		string = string..
			"	end,\n"..
			"	get_gui = function(self,explorer)\n"..
			"		return self.g\n"..
			"	end,\n"..
			"	draw = function(self,explorer)\n"..
			"		cls("..self.bgclr..")\n"
		for i in all(self.elements) do
			if i and i != self.elements[1] then
				if i.type == "rect" then
					string = string..
						"		rect"
					if i.image_str then
						string = string.."fill"
					end
					string = string..
						"("..i.x..","..i.y..","..i.x+i.w..","..i.y+i.h..","..i.clr..")\n"
					
				elseif i.type == "circle" then
					string = string..
						"		oval"
					if i.image_str then
						string = string.."fill"
					end
					string = string..
						"("..i.x..","..i.y..","..i.x+i.w..","..i.y+i.h..","..i.clr..")\n"
					
				elseif i.type == "image" then
					local name = i.name
					for j in all(self.elements) do
						if j.image_str==i.image_str then
							name = j.name
							add(images,{type="image",name=name,image=i.image_str})
							break
						end
					end
					local img = unpod(i.image_str)
					string = string..
						"		palt(0)\n"..
						"		palt("..i.clr..", true)\n"..
						"		sspr(self."..name..", 0, 0, "..img:width()..","..img:height()..","..i.x..","..i.y..","..i.w..","..i.h..")\n"..
						"		palt()\n"
				elseif i.type == "gif" then
					local name = i.name
					for j in all(self.elements) do
						if j.image_str==i.image_str then
							name = j.name
							add(images,{type="gif",name=name,image=i.image_str,frames=i.frames})
							break
						end
					end
					local img = unpod(i.image_str)
					string = string..
						"		self."..name..":draw("..i.x..","..i.y..","..i.w..","..i.h..","..i.speed..","..i.clr..")\n"
				elseif i.type == "text" then
					string = string..
						"		print(\""..as_exportable_string(i.gui.label).." \","..i.x..","..i.y..","..i.clr..")\n"
				end
				
			end
		end
		string = string..
			"		"..self.custom_code.draw.."\n"..
			--"		self.g:draw_all()\n"..
			"	end,\n"..
			"	update = function(self,explorer)\n"..
			"		"..self.custom_code.update.."\n"..
			"	end"
		
		local did = {}
		for i in all(images) do
			if i.type == "image" and count(did,i.name)==0 then
				string = string..",\n"..
					"	"..as_exportable_string(i.name).."_raw = \""..i.image.."\",\n"..
					"	"..as_exportable_string(i.name).." = unpod(\""..i.image.."\")"
				add(did,i.name)
					
			elseif i.type == "gif" and count(did,i.name)==0 then
				string = string..",\n"..
					"	"..as_exportable_string(i.name).." = new_gif(\""..i.image.."\","..i.frames..")"
				add(did,i.name)
			elseif i.type == "gifraw" and count(did,i.name)==0 then
				string = string..",\n"..
					"	"..as_exportable_string(i.name).." = \""..i.image.."\""
				add(did,i.name)
			end
		end
		string = string.."\n"..
			"}"
			
		return string
	end,
	as_exportable_string = function(string)
		local sr = ""
		for i =1,#string do
			local s = sub(string,i,i)
			if s == "\n" then
				sr = sr.."\\n"
			elseif s == sub(" \"",2) then
				sr = sr.."\\"..s
			else
				sr = sr..s
			end
		end
		
		return sr
	end
}
