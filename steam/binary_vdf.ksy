meta:
  id: binary_vdf
  title: Binary VDF format, used for Steam's 'shortcuts.vdf' and parts of other files.
  application: Steam
  file-extension: vdf
  endian: le
  encoding: utf-8
doc-ref: https://github.com/Corecii/steam-binary-vdf-ts/blob/c95da71e4e893982ded21d6355f3b330264ccdf0/README.md#binary-vdf-format
-webide-representation: '<map>'
seq:
  - id: items
    type: record
    repeat: until
    repeat-until: _.type == record_type::map_end
types:
  record:
    -webide-representation: '{key} = {value}'
    seq:
    - id: type
      type: u1
      enum: record_type
    - id: key
      type: strz
      if: type != record_type::map_end
    - id: value
      type:
        switch-on: type
        cases:
          'record_type::map': binary_vdf
          'record_type::string': strz
          'record_type::number': u4
enums:
  record_type:
    0x00: map
    0x01: string
    0x02: number
    0x08: map_end
