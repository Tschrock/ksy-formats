meta:
  id: appinfo_vdf
  title: Steam's 'appinfo.vdf' file.
  application: Steam
  file-extension: vdf
  imports:
    - binary_vdf
  endian: le
doc: |
  Dev note: If you want to use Kaitai's web IDE for these files, you'll have to use Chrome - Firefox will hang.
doc-ref: https://github.com/SteamDatabase/SteamAppInfo/blob/17f17f46868a196752134d150f48310fd287f56f/README.md#appinfovdf
seq:
- id: magic
  contents: [0x27, 0x44, 0x56, 0x07]
- id: universe
  type: u4
- id: sections
  type: test
  if: next_u4 != 0
  repeat: until
  repeat-until: _.next_u4 == 0
- id: eof
  contents: [0x00, 0x00, 0x00, 0x00]
instances:
  next_u4:
    pos: _io.pos
    type: u4
types:
  test:
    seq:
      - id: body
        type: section
    instances:
      next_u4:
        pos: _io.pos
        type: u4
  section:
    seq:
      - id: app_id
        type: u4
      - id: size
        type: u4
      - id: info_state
        type: u4
      - id: last_updated
        type: u4
      - id: pics_token
        type: u8
      - id: sha1
        size: 20
      - id: change_number
        type: u4
      - id: binary_vdf
        type: binary_vdf
