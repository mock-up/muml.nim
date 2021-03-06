import json, types, utils

proc getVideo* (muml: mumlNode): mumlObject =
  result = mumlObject(kind: mumlKindVideo)
  for key, val in muml.pairs:
    case key:
    of "path":
      result.path = val.getStr.removeDoubleQuotation
    of "frame":
      result.frame.start = val["start"].getInt
      result.frame.`end` = val["end"].getInt
    of "layer":
      result.layer = val.getInt
    of "video":
      for key2, val2 in val.pairs:
        case key2:
        of "frame":
          result.video.frame.start = val2["start"].getInt
          result.video.frame.`end` = val2["end"].getInt
        of "position": result.video.position = val2.getPosition
        of "scale": result.video.scale = val2.getScale
        of "rotate": result.video.rotate = val2.getNumberValue
        of "opacity":
          result.video.opacity = val2.getNumberValue
        of "filters":
          result.video.filters = val2.getFilters
    of "audio":
      for key2, val2 in val.pairs:
        case key2:
        of "volume": result.audio.volume = val2.getNumberValue