CVersions = {}

function Version(resource_name, repository, current_version)
  local self = {}

  self.resource_name = resource_name
  self.repository = repository
  self.current_version = current_version

  self.check = function()

  end

  self.try = function()
    print(("Soy: %s"):format(self.resource_name))
    print(("Mi repositorio es: %s"):format(self.repository))
    print(("Mi versión actual es: %s"):format(self.current_version))
  end
  
  return self
end