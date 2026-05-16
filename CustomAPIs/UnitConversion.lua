function formatBytes(bytes)
    local kb = 1024
    local mb = kb * 1024
    local gb = mb * 1024

    if bytes >= gb then
        return string.format("%.2f GB", bytes / gb)
    elseif bytes >= mb then
        return string.format("%.2f MB", bytes / mb)
    elseif bytes >= kb then
        return string.format("%.2f KB", bytes / kb)
    else
        return string.format("%d Bytes", bytes)
    end
end

thousand = 1000
million = 10000000
billion = 1000000000

function formatFE(energy)
    if energy >= billion then
        return string.format("%.2f GFE", energy/billion)
    elseif energy >= million then
        return string.format("%.2f MFE", energy/million)
    elseif energy >= thousand then
        return string.format("%.2f KFE", energy/thousand)
    else
        return string.format("%d FE", energy)
    end
end

function formatEU(energy)
    if energy >= billion then
        return string.format("%.2f GEU", energy/billion)
    elseif energy >= million then
        return string.format("%.2f MEU", energy/million)
    elseif energy >= thousand then
        return string.format("%.2f KEU", energy/thousand)
    else
        return string.format("%d EU", energy)
    end
end

function formatMB(bucket)
    millibucket = 0.001
    kilobucket = 1000
    megabucket = 1000000
    gigabucket = 1000000000

    if bucket >= gigabucket then
        return string.format("%.2f Gb", bucket/gigabucket)
    elseif bucket >= megabucket then
        return string.format("%.2f Mb", bucket/megabucket)
    elseif bucket >= kilobucket then
        return string.format("%.2f Kb", bucket/kilobucket)
    elseif bucket >= millibucket then
        return string.format("%.2f mb", bucket/millibucket)
    else
        return string.format("%d b", )
    end

end



