CVersions = {}

function Version(resource_name, repository, current_version)
  local self = {}

  self.resource_name = resource_name
  self.repository = repository
  self.current_version = current_version

  self.check = function()
    local url_check = ('https://api.github.com/repos/%s/releases'):format(self.repository)
    PerformHttpRequest(url_check, function(code, data, headers)
      if code ~= 200 then
        print(('[^5Version Control^7] [^1ERROR^7] Could not check latest version'))
        return
      end

      local json = json.decode(data)

      local last_version = json[1].tag_name
      local version = self.current_version

      if last_version > version then
        print("=======================================================")
        print(('| [^5Version Control^7] [^2INFO^7] ^3New version available for ^7%s'):format(self.resource_name))
        print(('| [^5Version Control^7] [^2INFO^7] ^3Current version: ^7%s'):format(version))
        print(('| [^5Version Control^7] [^2INFO^7] ^3Latest version: ^7%s'):format(last_version))
        print(('| [^5Version Control^7] [^2INFO^7] ^3Download from: ^7%s'):format(json[1].html_url))
        print("=======================================================")
      end
    end)
  end
  
  return self
end