# version_control

`version_control` is a resource/dependency for FiveM resource versioning.

# Installation
* Download the latest version from [here](https://github.com/Eschiclers/version_control/releases).
* Create a folder name `[dependencies]` (e.g.) in your FiveM resources folder and drop the downloaded folder there.
* Make sure it's one of the first resources to be loaded in your `server.cfg` file.

# Usage
To use `version_control` in your resource, make sure to add the `repository` line and the location of your resource on GitHub in the format "GitHubUserName/Repository" in the `fxmanifest.lua` file.

Example using the `version_control` resource in the `Eschiclers` account:
```
repository 'Eschiclers/version_control'
```

Also make sure to add `version_control` as a dependency to your resource with this lines in your `fxmanifest.lua` file:
```
dependencies {
  'version_control'
}
```

For version control to work, your resource must be in a public GitHub repository. Whenever you want to publish a new version, you must do so by releasing a "release" in your GitHub repository with the version of the new "release". When `version_control` finds the new version in its repository, it will notify the server by console.

Demo screenshot of new release detected:

![Screenshot 1](https://i.imgur.com/MIEAyhK.png)

## How to start version control of your resource
In order for `version_control` to start controlling your resource, you need to call the `version_control:register` event like this

Example:

```lua
TriggerEvent('version_control:register', GetCurrentResourceName(),GetResourceMetadata(GetCurrentResourceName(), 'repository', 0), GetResourceMetadata(GetCurrentResourceName(), 'version', 0), function(response)
  -- This trigger will call this function with the response.
  -- The response have response.success with true if the resource has been successfully registered
  -- also response.obj with the version_control object which includes some functions to interact with the resource.
  if(response.success) then
    -- Do stuff
    -- We have the object with functions and info
  end
end)
```

And that's all. Absolutely nothing else needs to be done for everything to work. Your resource will be checked for a newer version upon registered and once every 24 hours unless otherwise noted.

The trigger event need this arguments:
```lua
TriggerEvent('version_control:register', 
  GetCurrentResourceName(), -- The resource name. I recommend using this function
  GetResourceMetadata(GetCurrentResourceName(), 'repository', 0), -- The repository of the resource. I recommend using this function.
  GetResourceMetadata(GetCurrentResourceName(), 'version', 0), -- Te version of the resource. I recommend using this function.
  function(response) -- The callback function with the response.

  -- Magic code

end)
```

## The obj functions
When you trigger the `version_control:register` you will get an object in the callback function.

The object is an instance of your resource inside the `version_control`. And it contains the following functions that you can use whenever you want.

```lua
TriggerEvent('version_control:register', GetCurrentResourceName(),GetResourceMetadata(GetCurrentResourceName(), 'repository', 0), GetResourceMetadata(GetCurrentResourceName(), 'version', 0), function(response)
  if(response.success) then
    local obj = response.obj
    -- You can stop manually the version_control timer for the next check
    obj.stop()
    -- You can start the timer again
    obj.start()
    -- You can launch the check for a new version manually
    obj.check()
    -- And you can change the interval between checks in ms (default is 24 hours)
    obj.setInterval( 1000 * 60 * 60 * 1) -- 1 hour
    -- The setInterval function will stop and start the timer for you. Dont need to do it manually.
  end
end)
```

## Trigger called onCheck
When `version_control` checks for any updates to your resource, it will call the following event: `version_control:onCheck` with the following arguments:

```lua
-- The resource name checked
-- data object with the following properties:
-- If the resource has been updated
-- The new version
-- The download url

-- So you can handle the event like this:
AddEventHandler('version_control:onCheck', function(resource_name, data)
  if resource_name == GetCurrentResourceName() then
    -- Do stuff, we also have data with this information:
    -- data.has_new_version = true | false
    -- data.last_version = "1.0.0"
    -- data.download_url = "githuburl"
  end
end)

```

# Support me
You can support me through ko-fi

[![ko-fi](https://ko-fi.com/img/githubbutton_sm.svg)](https://ko-fi.com/chicle)

# Do you need help?
If you need help you can open an [issue](https://github.com/Eschiclers/version_control/issues) or you can contact me via email [hola@chicle.dev](mailto:hola@chicle.dev) or via discord [Chicle.dev discord server](https://discord.gg/KJxsuVPnmu).