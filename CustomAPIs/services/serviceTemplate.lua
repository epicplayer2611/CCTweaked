-- services/serviceTemplate.lua
return {
    name = "myservice",
    autostart = true,

    start = function(self)
        while true do
            print("[myservice] doing work...")
            sleep(5)
        end
    end,

    onStop = function(self)
        print("[myservice] stopped cleanly")
    end
}
