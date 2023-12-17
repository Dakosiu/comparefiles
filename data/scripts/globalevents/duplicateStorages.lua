local globalevent = GlobalEvent("checkStorages_onStartup")
function globalevent.onStartup()
   if configManager.getBoolean(configKeys.CHECK_DUPLICATES_VALUES) then
      -- List of table names to be checked for duplicates
      local variableNames = { "AccountStorageKeys", "PlayerStorageKeys", "GlobalStorageKeys" }
      -- Loop through the list of table names
      for _, variableName in ipairs(variableNames) do
         -- Call the checkDuplicatesValues function for each table
         local hasDuplicates, message = checkDuplicatesValues(variableName)
         -- Print the result of the check for each table
         print(">> Checking " .. variableName .. ": " .. message)
      end
   end
end

globalevent:register()
