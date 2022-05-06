local Entries = {}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'bar:grabDrink' },
    data = {
        {
            id = "bar:grabDrink",
            label = "Grab Drink",
            icon = "circle",
            event = "pw-interact:grabDrink"
        }
    },
    options = {
        distance = { radius = 2.0 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'bar:openFridge' },
    data = {
        {
            id = "bar:openFridge",
            label = "Open Fridge",
            icon = "circle",
            event = "pw-interact:openFridge"
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
}

Entries[#Entries + 1] = {
  type = 'polytarget',
  group = { 'tbar:chargeCustomer' },
  data = {
      {
          id = "tbar:chargeCustomer",
          label = "Charge Customer",
          icon = "dollar-sign",
          event = "pw-tavern:peekAction",
          parameters = { action = "chargeCustomer" }
      }
  },
  options = {
      distance = { radius = 1.5 }
  }
}

Entries[#Entries + 1] = {
  type = 'polytarget',
  group = { 'tbar:getBag' },
  data = {
      {
          id = "tbar:getBag",
          label = "Grab Bag",
          icon = "circle",
          event = "pw-tavern:peekAction",
          parameters = { action = "getBag" }
      }
  },
  options = {
      distance = { radius = 1.5 }
  }
}

Entries[#Entries + 1] = {
  type = 'polytarget',
  group = { 'tbar:craftToxicMenu' },
  data = {
      {
          id = "tbar:craftToxicMenu",
          label = "Be Toxic",
          icon = "circle",
          event = "pw-tavern:peekAction",
          parameters = { action = "craftToxicMenu" }
      }
  },
  options = {
      distance = { radius = 1.5 }
  }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'townhall:gavel' },
    data = {
        {
            id = "townhall:gavel",
            label = "Use Gavel",
            icon = "circle",
            event = "pw-gov:gavel",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
}


Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'officer_sign_in' },
    data = {
        {
            id = "officer_sign_in",
            label = "Duty Action",
            icon = "circle",
            event = "pw-signin:peekAction",
            parameters = { name = "officer" }
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'ems_sign_in' },
    data = {
        {
            id = "ems_sign_in",
            label = "Duty Action",
            icon = "circle",
            event = "pw-signin:peekAction",
            parameters = { name = "ems" }
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'ems_volunteer_sign_in' },
    data = {
        {
            id = "ems_volunteer_sign_in",
            label = "Duty Action",
            icon = "circle",
            event = "pw-signin:peekAction",
            parameters = { name = "ems_volunteer" }
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'fire_dept_sign_in' },
    data = {
        {
            id = "fire_dept_sign_in",
            label = "Duty Action",
            icon = "circle",
            event = "pw-signin:peekAction",
            parameters = { name = "fire_dept" }
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'public_services_sign_in' },
    data = {
        {
            id = "public_services_sign_in",
            label = "Duty Action",
            icon = "circle",
            event = "pw-signin:peekAction",
            parameters = { name = "public_services" }
        },
        {
            id = "public_services_legal_aid",
            label = "Become Legal Aid",
            icon = "circle",
            event = "pw-signin:legalAid",
            parameters = {}
        },
    },
    options = {
        distance = { radius = 1.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'driving_instructor_sign_in' },
    data = {
        {
            id = "driving_instructor_sign_in",
            label = "Duty Action",
            icon = "circle",
            event = "pw-signin:peekAction",
            parameters = { name = "driving_instructor" }
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
}

Entries[#Entries + 1] = {
    type = 'polytarget',
    group = { 'pw-jail:prison_services' },
    data = {
        {
            id = "prison_services",
            label = "Prison Services",
            icon = "circle",
            event = "pw-jail:services",
            parameters = {}
        }
    },
    options = {
        distance = { radius = 1.5 }
    }
}

Citizen.CreateThread(function()
    for _, entry in ipairs(Entries) do
        if entry.type == 'flag' then
            AddPeekEntryByFlag(entry.group, entry.data, entry.options)
        elseif entry.type == 'model' then
            AddPeekEntryByModel(entry.group, entry.data, entry.options)
        elseif entry.type == 'entity' then
            AddPeekEntryByEntityType(entry.group, entry.data, entry.options)
        elseif entry.type == 'polytarget' then
            AddPeekEntryByPolyTarget(entry.group, entry.data, entry.options)
        end
    end
end)
