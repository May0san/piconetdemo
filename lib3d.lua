function draw_mesh(mesh, x, y, rx, ry, depth_clrs, gradient_depth, split_half)
--	set_draw_target(mesh.canvas)
--	cls()
	camera(-x, -y)
	local tris_to_draw = mesh.tris
	
	
	
	for i=1,#tris_to_draw do
		local tri = tris_to_draw[mesh.sorting_tri_map:get(1,i-1)]
--	for tri in all(tris_to_draw) do
		local drawtri = {verts = {}}
		local zavg = 0
		for v in all(tri.verts) do
			local newvert = v:matmul3d(mat_transformation(vec(0,0,0), vec(rx,ry,0)))
			add(drawtri.verts, newvert)
			zavg += newvert.z
		end
		zavg /= 3
		if not split_half or split_half==0 or (split_half == 1 and zavg >= 0) or (split_half == 2 and zavg < 0) then
			local clr = depth_clrs[mid(1,flr(((gradient_depth/2)+zavg) / gradient_depth),#depth_clrs)]
			draw_triangle(drawtri, clr)
		end
	end
	camera()
--	set_draw_target()
	palt()
--	blit(mesh.canvas, nil, 0, 0, x-(mesh.dwidth/2), y-(mesh.dheight/2))
end


--webinclude does not currently work unfortunately


function new_tri(vec1, vec2, vec3, clr)
	return {
		verts = {
			vec1 or vec(0,0,0,1),
			vec2 or vec(0,0,0,1),
			vec3 or vec(0,0,0,1)
		},
		clr =  clr or 7
	}
	
	
end

--mesh
function new_mesh(tris, dwidth, dheight)
	mesh = {
		tris = tris,
		canvas = userdata("u8", dwidth, dheight),
		dwidth = dwidth,
		dheight = dheight
	}
	
	--sorting
	if #mesh.tris > 0 then
		mesh.sorting_tri_map = userdata("f64", 2, #mesh.tris)
		for i = 1,#mesh.tris do
			local tri = mesh.tris[i]
			local zavg = 0
			for v in all(tri.verts) do
				zavg += v.z
			end
			mesh.sorting_tri_map:set(0, i-1, zavg)
			mesh.sorting_tri_map:set(1, i-1, i)
		end
		mesh.sorting_tri_map:sort()
	end
	
	return mesh
end

--draw triangle wireframe
function draw_triangle(tri, clr)
	local verts = tri.verts
	line(verts[1].x, verts[1].y, verts[2].x, verts[2].y, clr)
	line(verts[2].x, verts[2].y, verts[3].x, verts[3].y, clr)
	line(verts[3].x, verts[3].y, verts[1].x, verts[1].y, clr)
end

function parse_obj_file(file, scale)
	local list = split(file,"\n")
	local verts = {}
	local faces = {}
	local scale = scale or 1
	for i=1,#list do
		local data = split(list[i]," ")
		if data[1] == "v" then
			add(verts,vec(tonum(data[2])*scale,tonum(data[3])*scale,tonum(data[4])*scale,1))
		elseif data[1] == "f" then
			local data1 = tonum(split(data[2],"/")[1])
			local data2 = tonum(split(data[3],"/")[1])
			local data3 = tonum(split(data[4],"/")[1])
			add(faces,new_tri(verts[data1],verts[data2],verts[data3]))
		end
	end
	return faces
end

function mat_rot_x(theta)
	local c = math.cos(theta)
	local s = math.sin(theta)
	local mat = userdata("f64", 4, 4)
	mat:set(0,0,
		1, 0, 0, 0,
		0, c, s, 0,
		0, -s, c, 0,
		0, 0, 0, 1
	)
	return mat
end

function mat_rot_y(theta)
	local c = math.cos(theta)
	local s = math.sin(theta)
	local mat = userdata("f64", 4, 4)
	mat:set(0,0,
		c, 0, s, 0,
		0, 1, 0, 0,
		-s, 0, c, 0,
		0, 0, 0, 1
	)
	return mat
end

function mat_rot_z(theta)
	local c = math.cos(theta)
	local s = math.sin(theta)
	local mat = userdata("f64", 4, 4)
	mat:set(0,0,
		c, s, 0, 0,
		-s, c, 0, 0,
		0, 0, 1, 0,
		0, 0, 0, 1
	)
	return mat
end

function mat_trans(vector)
	local mat = userdata("f64", 4, 4)
	mat:set(0,0,
		1, 0, 0, 0,
		0, 1, 0, 0,
		0, 0, 1, 0,
		vector.x, vector.y, vector.z, 1
	)
	return mat
end

function mat_identity()
	local mat = userdata("f64", 4, 4)
	mat:set(0,0,
		1, 0, 0, 0,
		0, 1, 0, 0,
		0, 0, 1, 0,
		0, 0, 0, 1
	)
	return mat
end

function mat_transformation(trans, rot)--x * y * z * t
	local rot = rot or vec(0, 0, 0)
	local trans = trans or vec(0, 0, 0)
	local mat = mat_rot_z(rot.z):matmul3d(mat_rot_y(rot.y)):matmul3d(mat_rot_x(rot.x)):matmul3d(mat_trans(trans))
	--[[local x = trans.x
	local y = trans.y
	local z = trans.z
	local cx = math.cos(rot.x or 0)
	local cy = math.cos(rot.y or 0)
	local cz = math.cos(rot.z or 0)
	local sx = math.sin(rot.x or 0)
	local sy = math.sin(rot.y or 0)
	local sz = math.sin(rot.z or 0)
	local mat = userdata("f64", 4, 4)
	mat:set(0,0,
		(sy*sx*sz)+(cy*cz), (sz*cy)-(sy*sx*cx), (sy*cx), 0,
		-(sz*cx), cx*cx, sx, 0,
		(sx*sz*cy)-(sy*cz), -(sy*sz)-(sx*cy*cx), cy*cx, 0,
		x, y, z, 1
	)]]
	return mat
end

function mat_point_at(pos, target, up)
	-- calculate fwd
	local new_forward = target - pos
	new_forward /= new_forward:magnitude()
	
	-- calculate up
	local new_up = up - (new_forward * up:dot(new_forward))
	new_up /= new_up:magnitude()
	
	-- calculate new right
	local new_right = new_up:cross(new_forward)
	
	--matrix
	local mat = userdata("f64", 4, 4)
	mat:set(0,0,
		new_right.x, new_right.y, new_right.z, 0,
		new_up.x, new_up.y, new_up.z, 0,
		new_forward.x, new_forward.y, new_forward.z, 0,
		pos.x, pos.y, pos.z, 1
	)
	
	return mat
end

function mat_look_at(pos, target, up)
	-- calculate fwd
	local new_forward = target - pos
	new_forward /= new_forward:magnitude()
	
	-- calculate up
	local new_up = up - (new_forward * up:dot(new_forward))
	new_up /= new_up:magnitude()
	
	-- calculate new right
	local new_right = new_up:cross(new_forward)
	
	--matrix
	local mat = userdata("f64", 4, 4)
	mat:set(0,0,
		new_right.x, new_up.x, new_forward.x, 0,
		new_right.y, new_up.y, new_forward.y, 0,
		new_right.z, new_up.z, new_forward.z, 0,
		-pos:dot(new_right), -pos:dot(new_up), -pos:dot(new_forward), 1
	)
	
	return mat
end

UP = vec(0, 1, 0)

DOWN = vec(0, -1, 0)

WEST = vec(-1, 0, 0)

EAST = vec(1, 0, 0)

NORTH = vec(0, 0, 1)

SOUTH = vec(0, 0, -1)
