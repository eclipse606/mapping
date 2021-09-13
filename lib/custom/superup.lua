SUPERUP = {
	msg = {
		naoDisponivel = "Essa cave está ocupada pelo jogador %s até %s.",
		disponivel = "Parabéns, você comprou uma cave do Super UP com duração de %d %s!",
		naoItem = "Você precisa de uma %s para comprar uma cave.",
		tempoAcabou = "O seu tempo de Super UP acabou!",
		possuiCave = "Você já possui uma cave do Super UP!",
	},
	areas = {
		[20000] = {nome = "Super Terror Bird", entrada = Position(542, 1251, 7), from = Position(1257, 1435, 6), to = Position(1062, 1158, 7)},
		[20001] = {nome = "Super Penguin", entrada = Position(544, 1251, 7), from = Position(1843, 1959, 7), to = Position(1393, 1474, 8)},
		[20002] = {nome = "Super Hydra", entrada = Position(546, 1251, 7), from = Position(1577, 1667, 7), to = Position(1485, 1544, 8)},
		[20003] = {nome = "Super Flamingo", entrada = Position(548, 1251, 7), from = Position(1816, 784, 7), to = Position(1938, 834, 7)}, 
		[20004] = {nome = "SacredEx Spider", entrada = Position(550, 1251, 7), from = Position(1610, 1118, 7), to = Position(1722, 1159, 7)},
		[20005] = {nome = "SacredEx Spider", entrada = Position(553, 1245, 7), from = Position(1508, 993, 7), to = Position(1620, 1034, 7)},
		[20006] = {nome = "Super Terror Bird", entrada = Position(553, 1243, 7), from = Position(1257, 1062, 6), to = Position(1435, 1158, 7)},
		[20007] = {nome = "Super Penguin", entrada = Position(553, 1241, 7), from = Position(1981, 1369, 7), to = Position(2096, 1449, 8)},
		[20008] = {nome = "Super Hydra", entrada = Position(553, 1239, 7), from = Position(1684, 1505, 6), to = Position(1783, 1596, 7)},
		[20009] = {nome = "Super Flamingo", entrada = Position(553, 1237, 7), from = Position(1816, 710, 7), to = Position(1938, 760, 7)},
		[20010] = {nome = "SacredEx Spider", entrada = Position(550, 1231, 7), from = Position(1368, 951, 7), to = Position(1479, 951, 7)},
		[20011] = {nome = "Super Flamingo", entrada = Position(548, 1231, 7), from = Position(1816, 638, 7), to = Position(1938, 687, 7)},
		[20012] = {nome = "Super Hydra", entrada = Position(546, 1231, 7), from = Position(1839, 1275, 7), to = Position(1929, 1342, 8)},
		[20013] = {nome = "Super Penguin", entrada = Position(544, 1231, 7), from = Position(1982, 1276, 7), to = Position(2098, 1356, 8)},
		[20014] = {nome = "Super Terror Bird", entrada = Position(542, 1231, 7), from = Position(1083, 773, 6), to = Position(1277, 876, 7)},
		[20016] = {nome = "Super Flamingo", entrada = Position(539, 1237, 7), from = Position(1816, 565, 7), to = Position(1938, 615, 7)},
		[20017] = {nome = "Super Hydra", entrada = Position(539, 1239, 7), from = Position(1990, 1108, 7), to = Position(2080, 1175, 8)},
		[20018] = {nome = "Super Penguin", entrada = Position(539, 1241, 7), from = Position(1984, 1189, 7), to = Position(2095, 1267, 8)},
		[20019] = {nome = "Super Terror Bird", entrada = Position(539, 1243, 7), from = Position(1327, 770, 6), to = Position(1521, 873, 7)},
		[20020] = {nome = "SacredEx Spider", entrada = Position(539, 1245, 7), from = Position(1606, 782, 7), to = Position(1718, 782, 7)},
	},{x = 539, y = 1241, z = 7}
	setTime = 3, -- Em horas
	itemID = 8978,
}

function SUPERUP:getCave(id)
	local resultCave = db.storeQuery("SELECT guid_player, to_time FROM exclusive_hunts WHERE `hunt_id` = " .. id)
	if not resultCave then
		return false
	end

	local caveOwner = result.getDataInt(resultCave, "guid_player")
	local caveTime = result.getDataLong(resultCave, "to_time")
	result.free(resultCave)

	return {dono = caveOwner, tempo = caveTime}
end

function SUPERUP:freeCave()
	freeCaves = {}
	local db = db.storeQuery("SELECT `hunt_id`, `to_time`, `guid_player` FROM exclusive_hunts")
	if not db then
		return
	end

	repeat
		local idHunt = result.getDataInt(db, "hunt_id")
		local tempoFinal = result.getDataLong(db, "to_time")
		local guidPlayer = result.getDataInt(db, "guid_player")
		result.free(db)

		table.insert(freeCaves, {idHunt, tempoFinal, guidPlayer})

	until not result.next(db)
	return freeCaves
end
