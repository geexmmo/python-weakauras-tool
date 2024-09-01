<h3 align="center">WeakAuras String Encoder/Decoder as wrapper for lua in Python</h3>
<p align="center"> Based on encode/decode functions of WeakAuras2 and wago.io</p>

WeakAura strings version 2 is supported (`retail`version tested only):
https://github.com/WeakAuras/WeakAuras2/blob/main/WeakAuras/Transmission.lua#L270
https://github.com/WeakAuras/WeakAuras2/blob/main/WeakAuras/Transmission.lua#L299
``` lua
  -- encoding format:
  -- version 0: simple b64 string, compressed with LC and serialized with AS
  -- version 1: b64 string prepended with "!", compressed with LD and serialized with AS
  -- version 2+: b64 string prepended with !WA:N! (where N is encode version)
  --   compressed with LD and serialized with LS

```

## Table of Contents

- [About](#about)
- [Getting Started](#getting_started)
- [Usage](#usage)


## About <a name = "about"></a>

Script decodes WeakAura2 export strings into JSON or encodes JSON into WeakAura2 string invoking corresponding `decode.lua` or `encode.lua` in `lua` folder

## Getting Started <a name = "getting_started"></a>

Get env and python requirements, only requirement is [Lupa](https://github.com/scoder/lupa), CPython integration of Lua or LuaJit runtimes:
```bash
python3 -m venv ./
pip install -r requirements.txt
```

## Usage <a name="usage"></a>

Modify *`import_string`* and *`action`* inside *docode-wa.py* in *__main__*
```bash
python wa_tool.py
```
or to decode wa string from command-line pass wa string as argument:
```bash
python wa_tool.py '!WA:2!YourEncodedString'
```
or load as module:
```python
>>> from wa_tool import run_lua
>>> run_lua('decode','!WA:2!YourEncodedString')
>>> (outputhere)
>>> run_lua('encode','{ "m": "d", "s": "5.17.0", "v": 1421 }')
>>> (outputhere)
```