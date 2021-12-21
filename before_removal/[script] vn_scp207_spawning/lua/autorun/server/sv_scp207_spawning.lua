

local timer = timer

local table = table

local math = math

local Vector = Vector



local scp207 = {

	"scp_207",

};



local spawnBounds = {



	{
			--Near Trashcan outside Bank
		minimumBound = Vector(-2590.402588, 3574.031250, -736.914734),

		maximumBound = Vector(-2601.669678, 3579.260742, -736.914734)

	},



	{
			--Bench outside Subway
		minimumBound = Vector(-3522.955078, 7789.961914, -711.397949),

		maximumBound = Vector(-3487.270020, 7768.326172, -728.968750)

	},



	{
			--Outside LCZ Breach Shelter Table
		minimumBound = Vector(-4657.011719, 8573.731445, -2849.489258),

		maximumBound = Vector(-4666.141602, 8537.592773, -2849.472900)

	},


	{
			--Outside SCP-939 Checkpoint Door
		minimumBound = Vector(-7765.076172, 14315.725586, -3141.968750),

		maximumBound = Vector(-7772.929688, 14322.295898, -3141.968750)

	},
	
	{
			--Outside EZ Blue Room Offices table with PC
		minimumBound = Vector(-10396.166016, 13069.631836, -2720.292236),

		maximumBound = Vector(-10397.166016, 13070.631836, -2720.292236)

	}

	--[[{

		minimumBound = Vector(0, 0, 0),

		maximumBound = Vector(0, 0, 0)

	}]]

};



timer.Simple(1, function()



	timer.Create("vSCP207Spawning", 3000, 0, function()



		if (#scp207 == 0) then

			return;

		end;



		if (#spawnBounds == 0) then

			return;

		end;



		local scp207Class = table.Random(scp207);

		local spawnBound = table.Random(spawnBounds);

		local randomX = math.Rand(spawnBound.minimumBound.x, spawnBound.maximumBound.x);

		local randomY = math.Rand(spawnBound.minimumBound.y, spawnBound.maximumBound.y);

		local randomZ = math.Rand(spawnBound.minimumBound.z, spawnBound.maximumBound.z);

		local randomVector = Vector(randomX, randomY, randomZ);



		local scp207 = ents.Create(scp207Class);



		scp207:Spawn();

		scp207:Activate();

		print("SCP-207 Spawned. -vn_sc207_spawning")


		local minimumCollisionBound, maximumCollisionBound = scp207:GetCollisionBounds();



		local iterations = 0;

		local maximumIterations = 20;



		while (iterations < maximumIterations and (util.PointContents(randomVector + minimumCollisionBound) != CONTENTS_EMPTY or util.PointContents(randomVector + maximumCollisionBound) != CONTENTS_EMPTY)) do

			randomX = math.Rand(spawnBound.minimumBound.x, spawnBound.maximumBound.x);

			randomY = math.Rand(spawnBound.minimumBound.y, spawnBound.maximumBound.y);

			randomZ = math.Rand(spawnBound.minimumBound.z, spawnBound.maximumBound.z);



			randomVector = Vector(randomX, randomY, randomZ);



			iterations = iterations + 1;

		end;



		local downwardsTrace = util.QuickTrace(randomVector, Vector(0, 0, -4096));

		if !downwardsTrace.Hit then
            SafeRemoveEntity(scp207)
            return
        end

		scp207:SetPos(downwardsTrace.HitPos - Vector(0, 0, minimumCollisionBound.z));


		print( scp207:GetPos() )



		timer.Simple(420,function()


			SafeRemoveEntity(scp207)


			print("SCP-207 Despawned. -vn_sc207_spawning")



		end)

	end);

end);