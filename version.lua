CVersions = {}

function Version(resource_name, repository, current_version)
  local self = {}

  self.resource_name = resource_name
  self.repository = repository
  self.current_version = current_version
  self.interval = 1000 * 60 * 60 * 24 -- 1 day
  self.timeoutid = nil

  self.check = function()
    local url_check = ('https://api.github.com/repos/%s/releases/latest'):format(self.repository)
    PerformHttpRequest(url_check, function(code, data, headers)
      if code ~= 200 then
        print(('[^5Version Control^7] [^1ERROR^7] Could not check latest version'))
        return
      end

      local json = json.decode(data)

      local last_version = json.tag_name
      local version = self.current_version

      if last_version > version then
        print("=======================================================")
        print(('| [^5Version Control^7] [^2INFO^7] ^3New version available for ^7%s'):format(self.resource_name))
        print(('| [^5Version Control^7] [^2INFO^7] ^3Current version: ^7%s'):format(version))
        print(('| [^5Version Control^7] [^2INFO^7] ^3Latest version: ^7%s'):format(last_version))
        print(('| [^5Version Control^7] [^2INFO^7] ^3Download from: ^7%s'):format(json.html_url))
        print("=======================================================")
      end

      TriggerEvent('version_control:onCheck', self.resource_name, { success = true, has_new_version = last_version > version, last_version = last_version, download_url = json.html_url })
    end, 'GET', '', {})
  end
  
  self.start = function()
    Wait(2000)
    self.check()

    self.timeoutid = VC.SetTimeout(self.interval, function()
      self.start()
    end)
  end

  self.stop = function()
    VC.ClearTimeout(self.timeoutid)
  end

  self.setInterval = function(interval)
    self.interval = interval
    self.stop()
    self.start()
  end

  self.start()

  return self
end