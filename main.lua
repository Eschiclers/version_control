TriggerEvent('version_control:register', GetCurrentResourceName(),GetResourceMetadata(GetCurrentResourceName(), 'repository', 0), GetResourceMetadata(GetCurrentResourceName(), 'version', 0), function(response)
  if(response.success) then
    -- Do stuff
    -- We have the object with functions and info
  end
end)

AddEventHandler('version_control:onCheck', function(resource_name, data)
  if resource_name == GetCurrentResourceName() then
    -- Do stuff, we also have data with this information:
    -- data.has_new_version = true | false
    -- data.last_version = "1.0.0"
    -- data.download_url = "githuburl"
  end
end)